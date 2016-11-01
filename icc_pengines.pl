% :- [run].

:- use_module(pengine_sandbox:icc).
:- use_module(library(sandbox)).
% :- use_module(namespaces).
:- multifile sandbox:safe_primitive/1.

sandbox:safe_primitive(icc:flush).
sandbox:safe_primitive(icc:flush(_)).
sandbox:safe_primitive(icc:assert(_,_,_,document)).
sandbox:safe_primitive(icc:assert(_,_,_,agent)).
sandbox:safe_primitive(icc:triple(_,_,_)).
sandbox:safe_primitive(icc:triple(_,_,_,document)).
sandbox:safe_primitive(icc:triple(_,_,_,agent)).
sandbox:safe_primitive(icc:retractall(_,_,_,document)).
sandbox:safe_primitive(icc:retractall(_,_,_,agent)).
sandbox:safe_primitive(icc:update(_,_,_,_,document)).
sandbox:safe_primitive(icc:update(_,_,_,_,agent)).
sandbox:safe_primitive(icc:content(document,_)).
sandbox:safe_primitive(icc:content(annotation,_)).
sandbox:safe_primitive(icc:content(annotation,_,_)).

sandbox:safe_primitive(icc:create_graph(_)).
%sandbox:safe_primitive(icc:create_graphs).

sandbox:safe_primitive(icc:agent(_,_,_)). % Id, foaf:Class, Ent, Opts, e.g. [create].
sandbox:safe_primitive(icc:agent(_,_,_,_)). % Id, foaf:Class.
sandbox:safe_primitive(icc:person(_,_)).
sandbox:safe_primitive(icc:person(_,_,_)).
sandbox:safe_primitive(icc:org(_,_)).
sandbox:safe_primitive(icc:org(_,_,_)).
sandbox:safe_primitive(icc:group(_,_)).
sandbox:safe_primitive(icc:group(_,_,_)).

sandbox:safe_primitive(icc:remove(_)).
sandbox:safe_primitive(icc:entity(_,_,_,_)).
sandbox:safe_primitive(icc:type(_,_,_)).

sandbox:safe_primitive(icc:sparql(_,_,_,_,_)).
sandbox:safe_primitive(icc:sparql(_,_,_,_)).

sandbox:safe_primitive(icc:ptest(_)).
sandbox:safe_primitive(icc:graph(_)).
sandbox:safe_primitive(icc:template_query(_,_,_)).
sandbox:safe_primitive(icc:annotation_query(target,_,_,_)).
sandbox:safe_primitive(icc:annotation_query(body,_,_,_,_)).
sandbox:safe_primitive(icc:annotation_query(body,_,_,_)).
sandbox:safe_primitive(icc:annotation_remove(target,_)).

% :- namespaces:register_prefixes.

:-write("ICC_PENGINES"),nl.