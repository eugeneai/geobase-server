:- module(icc, [assert/4,retractall/4,rdf/3,
                rdf/4,update/5,flush/0,
                content/4,sparql/5,sparql/4]).

:- use_module(library(semweb/rdf_db)).
:- use_module(library(semweb/rdfs)).
:- rdf_load(library(semweb/rdfs)).
:- use_module(library(semweb/turtle)).	% Turtle and TRiG
:- use_module(library(semweb/rdf_ntriples)).
:- use_module(library(semweb/rdf_zlib_plugin)).
:- use_module(library(semweb/rdf_http_plugin)).
:- use_module(library(http/http_ssl_plugin)).
:- use_module(library(semweb/rdf_persistency)).
:- use_module(library(semweb/sparql_client)).
:- use_module(namespaces).
%:- use_module(library(ordset)).

:- register_prefixes.
:- rdf_meta
        assert(r,r,r,-),
        retractall(r,r,r,-),
        triple(r,r,r),
        triple(r,r,r,-),
        update(r,r,r,-,-),

        agent(-,r,r,-),
        agent(-,r,r),
        person(-,r,-),
        person(-,r),
        org(-,r,-),
        org(-,r),
        group(-,r,-),
        group(-,r),

        entity(-,r,r,-),
        type(-,r,-),
        description(-,r,r,-),
        refs(r,r,-,-)
        .

gl(NS:Term, G):-
        rdf_global_term(NS:Term,G),!.

gl([],[]):-!.
gl([X|T],[Y|R]):-
        gl(X,Y),!,
        gl(T,R).

gl(X,Y):-
        rdf_global_term(X,Y).

assert(S,P,O, G):-
        rdf_assert(S,P,O, G).
retractall(S,P,O, G):-
        rdf_retractall(S,P,O,G).

triple(S,P,O):-
        rdf(S,P,O, G),
        graph(G).
triple(S,P,O, G):-
        rdf(S,P,O,G:_).
update(S,P,O, G,Action):-
        rdf_update(S,P,O, G,Action).

graph(document).
graph(agent).
graph(acl).
graph(deleted).

flush:-
        findall(graph(G), graph(G), L),
        rdf_flush_journals(L).

flush(Graph):-
        graph(Graph),
        rdf_flush_journals([graph(Graph)]).
flush([]).
flush([X|T]):-
        flush(X),
        flush(T).

content(document, Id, File, MimeType):- % document itself.
        content0(document, Id, Target),
        file_mime(Target, Target, File, MimeType).

content(annotation, Id, File, MimeType):- % annotation
        content0(annotation, Id, Target, Body),
        file_mime(Target,Body, File, MimeType).

content(document, Id):-
        content0(document, Id, _).

content(annotation, Id):-
        content0(annotation, Id, _,_).

content(annotation, Id, DocID):-
        content0(annotation, Id, Target,_),
        content0(document, DocID, Target).

file_mime(Target,Content, File, MimeType):-
        rdf(Target, nao:fileName, File, document),
        mimetype(Content, MimeType).

content0(document, Id, Target):-
        rdf(Ann, rdf:type, oa:'Annotation', document),
        rdf(Ann, oa:hasTarget, Target, document),
        rdf(Target, nao:identifier,Id, document).

content0(annotation, Id, Target, Body ):-
        rdf(Ann, rdf:type, oa:'Annotation', document),
        rdf(Ann, oa:hasBody, Body, document),
        rdf(Body, nao:identifier,Id, document),
        rdf(Ann, oa:hasTarget, Target, document).

agent(Id, Type, Agent):-
        entity(Id, Agent, Type, _).

agent(Id, Type, Agent, create):- % rdf:type
        \+ entity(Id, Agent, Type, agent),!,
        rdf_bnode(Agent),
        assert(Agent, nao:identifier, literal(Id), agent),
        assert(Agent, rdf:type, Type, agent),
        flush(agent).

agent(Id, Type, Agent, ensure_exists):-
        (
         \+ entity(Id, Agent, Type, agent),!,
         agent(Id, Type, Agent, create),!;
         entity(Id, Agent, Type, agent),!
        ),!.

agent(Id, Type, Agent, remove):-
        entity(Id, Agent, Type, agent),!,
        remove(Id),!.

person(Id, Person):-agent(Id, foaf:'Person', Person).
person(Id, Person, CMD):-
        agent(Id, foaf:'Person', Person, CMD).

org(Id, Org):-agent(Id, foaf:'Organization', Org).
org(Id, Org, CMD):-
        agent(Id, foaf:'Organization', Org, CMD).

group(Id, Group):-group(Id, foaf:'Group', Group).
group(Id, Group, CMD):-
        agent(Id, foaf:'Group', Group, CMD).

remove(Id):- % remove entity from graph moving it with references to it to deleted graph
        remove_entity(Id,[], G),
        remove_refs(Id,G,O),
        list_to_set(O, S),
        S\=[],!,
        flush(S),
        flush(deleted).
remove(_).

entity(Id, Entity, Type, Graph):-
        triple(Entity, nao:identifier, literal(Id), Graph),
        triple(Entity, rdf:type, Type, Graph).

type(Id, Class, Graph):-
        entity(Id, Entity, Graph),
        triple(Entity, rdf:type, Class, Graph).

description(Id, P, O, Graph):-
        entity(Id, Entity, Graph),
        triple(Entity, P, O, Graph).

refs(S, P, Id, Graph):-
        triple(S, P, literal(Id), Graph).

remove_entity(Id, Graphs, Out):-     % list_to_set(L,S).
        triple(S,nao:identifier,literal(Id), Graph),
        remove_entity(S, graph(Graph)),!,
        remove_entity(Id, [Graph|Graphs], Out).
remove_entity(_,G,G).

remove_entity(S, graph(G)):-
        triple(S,P,O, G),
        assert(S,P,O, deleted), fail.
remove_entity(S, graph(G)):-
        retractall(S,_,_, G).

remove_refs(Id, G,O):-
        triple(S,P,literal(Id), Graph),
        P\=nao:identifier,!,
        assert(S,P,literal(Id), deleted),
        retractall(S,P,literal(Id), Graph),
        remove_refs(Id, [Graph|G], O).
remove_refs(_,G,G).

mimetype(Target, MimeType):-
        rdf(Target, nmo:mimeType, MimeType, document).
mimeType(_, none).

create_graph(G):-
        rdf_create_graph(G).

create_graphs:-
        graph(Graph),
        rdf_create_graph(Graph),
        fail; true.


sparql(Query, Host, Port, Graph, Row):-
        sparql_query(Query, Row,
                     [host(Host),port(Port), path('/sparql/'), search(graph(Graph))]
                    ).

sparql(Query, Host, Port, Row):-
        sparql_query(Query, Row,
                     [host(Host),port(Port), path('/sparql/')]
                    ).


                                % ---------------------------------- private


load_from_internet:-
        namespace(NS,_, RDF), \+ rdf_graph(NS),
        rdf_load(RDF, [graph(NS)]),
        save_db(NS),
        fail; true.

load_from_binary:-
        namespace(G,_,_), \+ rdf_graph(G),
        graph_binary_name(G,FN),
        rdf_load_db_gz(FN),fail.
load_from_binary.

rdf_load_db_gz(FN):-
        format(atom(CMD), 'gunzip -c data/~w.gz > ~w', [FN,FN]),
        shell(CMD,_),
        rdf_load_db(FN),
        format(atom(CMD1), 'rm -f ~w', [FN]),
        shell(CMD1,_).

graph_binary_name(G,N):-
        atom_length(G,GL),GL<10,
        atom_concat(G,'.db',N).


save_db(G):-
        rdf_graph(G),
        graph_binary_name(G,FN),
        rdf_save_db(FN,G).

save_dbs:-
        save_db(_),
        fail.
save_dbs.

%save_dbs:-
%        rdf_save("RDF-SCHEMAS.rdf").

load_default_graphs:-
        load_from_binary,
        load_from_internet.


:- create_graphs.
:- load_default_graphs.
