:- module(icc, [assert/4,retractall/4,rdf/3,
                rdf/4,update/5,flush/0,
                content/4]).
:- [namespaces].

:- use_module(library(semweb/rdf_db)).
:- use_module(library(semweb/rdfs)).
:- rdf_load(library(semweb/rdfs)).
:- use_module(library(semweb/turtle)).	% Turtle and TRiG
:- use_module(library(semweb/rdf_ntriples)).
:- use_module(library(semweb/rdf_zlib_plugin)).
%:- use_module(library(semweb/rdf_http_plugin)).
%:- use_module(library(http/http_ssl_plugin)).
:- use_module(library(semweb/rdf_persistency)).

assert(S,P,O, G):-
        rdf_assert(S,P,O, G).
retractall(S,P,O, G):-
        rdf_retractall(S,P,O,G).
triple(S,P,O):-
        rdf(S,P,O,document).
triple(S,P,O):-
        rdf(S,P,O,agent).
triple(S,P,O, G):-
        rdf(S,P,O,G:_).
update(S,P,O, G,Action):-
        rdf_update(S,P,O, G,Action).

flush:-
        rdf_flush_journals([graph(document)]),
        rdf_flush_journals([graph(agent)]).

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


mimetype(Target, MimeType):-
        rdf(Target, nmo:mimeType, MimeType, document).
mimeType(_, none).

create_graph(G):-
        rdf_create_graph(G).

create_graphs:-
        rdf_create_graph(document),
        rdf_create_graph(agent).
