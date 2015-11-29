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
:- use_module(icc).

ns:-
        rdf_register_prefix(vdef,'http://irnok.net/icc/webapp#', [force(true)]).

person_view:-
        rdf_global_term(vdef:personView,VDV),
        rdf_assert(VDV,rdf:type,mvc:'View',pres),
        rdf_assert(VDV,mvc:for,foaf:'Person',pres),
        rdf_assert(VDV,nie:identifier,literal('personView'),pres),
        rdf_assert(VDV,nfo:maintainedBy,vdef:handlebars,pres),
        rdf_assert(VDV,cnt:chars,
                 '<div id="{{s nie:identifier}}">
                  {{s foaf:name required=true}}<br/>
                  {{s foaf:mbox required=true}}<br/>
                  </div>',pres).

handle_bars:-
        rdf_global_term(vdef:javaScriptInclusion,JSMi),
        rdf_assert(JSMi,rdf:type,nfo:'SourceCode',pres),
        rdf_assert(JSMi,nfo:programmingLanguage,literal('JavaScript'),pres),
        rdf_assert(JSMi,nie:mimeType, literal('text/javascript'),pres),

        rdf_global_term(vdef:handlebars,HB),
        rdf_assert(HB,rdf:type,mvc:'ViewEngine',pres),
        rdf_assert(HB,nie:identifier,literal('hanlebars'),pres),
        rdf_assert(HB,nie:mimeType, literal('text/x-handlebars-template'),pres),
        rdf_assert(HB,nfo:programmingLanguage, literal('HTML'),pres),
        rdf_assert(HB,nao:maintainedBy, JSMi,pres),
        rdf_assert(HB,nfo:link,'http://builds.handlebarsjs.com.s3.amazonaws.com/handlebars.runtime-v4.0.5.js',pres).

% Add identifiers instead of labels.


:-initialization(ns).
