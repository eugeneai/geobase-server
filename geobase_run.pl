:- [run].

:- use_module(pengine_sandbox:geobase).
:- use_module(library(sandbox)).
:- use_module(namespaces).
:- use_module(icc).
:- multifile sandbox:safe_primitive/1.

sandbox:safe_primitive(geobase:loaddba).
sandbox:safe_primitive(geobase:geobase(_,_,_)).

:- namespaces:register_prefixes.

:- geobase:loaddba.
:- icc:create_graph(geob).
:- icc:create_graph(geodata).
:- rdf_load('data/faults_data.ttl',[graph(geodata)]).
