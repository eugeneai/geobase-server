:- module(namespaces, [namespace/2,namespace/3, namespace/4, register_prefixes/0]).

:- use_module(library(semweb/rdf_db)).

namespace(rdf,'http://www.w3.org/1999/02/22-rdf-syntax-ns#').
namespace(rdfs,'http://www.w3.org/2000/01/rdf-schema#').
namespace(trig,'http://www.w3.org/2004/03/trix/rdfg-1/'). % Dev stopped.
namespace(dcam,'http://purl.org/dc/dcam/').
namespace(ns,'http://www.w3.org/2003/06/sw-vocab-status/ns#').
namespace(protege,'http://protege.stanford.edu/system#').
namespace(xsd,'http://www.w3.org/2001/XMLSchema#').
namespace(cll,'http://purl.org/cellula/ns#').


namespace(prov,'http://www.w3.org/ns/prov#'). %,'http://www.w3.org/ns/prov-core.xsd').

namespace(owl,'http://www.w3.org/2002/07/owl#','http://www.w3.org/2002/07/owl').
namespace(oa,'http://www.w3.org/ns/oa#','http://www.w3.org/ns/oa.owl').
namespace(cnt,'http://www.w3.org/2011/content#','http://www.w3.org/2011/content').
namespace(dc,'http://purl.org/dc/elements/1.1/','http://dublincore.org/2012/06/14/dcelements.rdf'). % already defined
namespace(dcterms,'http://purl.org/dc/terms/', 'http://dublincore.org/2012/06/14/dcterms.rdf').
namespace(dctypes,'http://purl.org/dc/dcmitype/','http://dublincore.org/2012/06/14/dctype.rdf').
namespace(foaf,'http://xmlns.com/foaf/0.1/','http://xmlns.com/foaf/spec/index.rdf').
namespace(scos,'http://www.w3.org/2004/02/skos/core#','http://www.w3.org/TR/skos-reference/skos.rdf').
% NEPOMUK ontolgies http://www.semanticdesktop.org/ontologies/
namespace(nrl,'http://www.semanticdesktop.org/ontologies/2007/08/15/nrl#','http://www.semanticdesktop.org/ontologies/2007/08/15/nrl/nrl_data.rdfs').
namespace(nao,'http://www.semanticdesktop.org/ontologies/2007/08/15/nao#','http://www.semanticdesktop.org/ontologies/2007/08/15/nao/nao_data.rdfs').
namespace(nie,'http://www.semanticdesktop.org/ontologies/2007/01/19/nie#','http://www.semanticdesktop.org/ontologies/2007/01/19/nie/nie_data.rdfs').
namespace(nfo,'http://www.semanticdesktop.org/ontologies/2007/03/22/nfo#','http://www.semanticdesktop.org/ontologies/2007/03/22/nfo/nfo_data.rdfs').
namespace(nco,'http://www.semanticdesktop.org/ontologies/2007/03/22/nco#','http://www.semanticdesktop.org/ontologies/2007/03/22/nco/nco_data.rdfs').
namespace(nmo,'http://www.semanticdesktop.org/ontologies/2007/03/22/nmo#','http://www.semanticdesktop.org/ontologies/2007/03/22/nmo/nmo_data.rdfs').
namespace(ncal,'http://www.semanticdesktop.org/ontologies/2007/04/02/ncal#','http://www.semanticdesktop.org/ontologies/2007/04/02/ncal/ncal_data.rdfs').
namespace(nexif,'http://www.semanticdesktop.org/ontologies/2007/05/10/nexif#','http://www.semanticdesktop.org/ontologies/2007/05/10/nexif/nexif_data.rdfs').
namespace(nid3,'http://www.semanticdesktop.org/ontologies/2007/05/10/nid3#','http://www.semanticdesktop.org/ontologies/2007/05/10/nid3/nid3_data.rdfs').
namespace(nmm,'http://www.semanticdesktop.org/ontologies/2009/02/19/nmm#','http://www.semanticdesktop.org/ontologies/2009/02/19/nmm/nmm_data.rdfs').
namespace(pimo,'http://www.semanticdesktop.org/ontologies/2007/11/01/pimo#','http://www.semanticdesktop.org/ontologies/2007/11/01/pimo/pimo_data.rdfs').
namespace(nso,'http://www.semanticdesktop.org/ontologies/2009/11/08/nso#','http://www.semanticdesktop.org/ontologies/2009/11/08/nso/nso_data.rdfs').
namespace(tmo,'http://www.semanticdesktop.org/ontologies/2008/05/20/tmo#','http://www.semanticdesktop.org/ontologies/2008/05/20/tmo/tmo_data.rdfs').
namespace(ndo,'http://www.semanticdesktop.org/ontologies/2010/04/30/ndo#','http://www.semanticdesktop.org/ontologies/2010/04/30/ndo/ndo_data.rdfs').
namespace(nuao,'http://www.semanticdesktop.org/ontologies/2010/01/25/nuao#','http://www.semanticdesktop.org/ontologies/2010/01/25/nuao/nuao_data.rdfs').
namespace(dcon,'http://www.semanticdesktop.org/ontologies/2011/10/05/dcon#','http://www.semanticdesktop.org/ontologies/2011/10/05/dcon/dcon_data.rdfs').
namespace(dplo,'http://www.semanticdesktop.org/ontologies/2011/10/05/dlpo#','http://www.semanticdesktop.org/ontologies/2011/10/05/dlpo/dlpo_data.rdfs').
namespace(dpo,'http://www.semanticdesktop.org/ontologies/2011/10/05/dpo#','http://www.semanticdesktop.org/ontologies/2011/10/05/dpo/dpo_data.rdfs').
namespace(dao,'http://www.semanticdesktop.org/ontologies/2011/10/05/dao#','http://www.semanticdesktop.org/ontologies/2011/10/05/dao/dao_data.rdfs').
namespace(ddo,'http://www.semanticdesktop.org/ontologies/2011/10/05/ddo#','http://www.semanticdesktop.org/ontologies/2011/10/05/ddo/ddo_data.rdfs').
namespace(duho,'http://www.semanticdesktop.org/ontologies/2011/10/05/duho#','http://www.semanticdesktop.org/ontologies/2011/10/05/duho/duho_data.rdfs').
namespace(drmo,'http://www.semanticdesktop.org/ontologies/2012/03/06/drmo#','http://www.semanticdesktop.org/ontologies/2012/03/06/drmo/drmo_data.rdfs').
namespace(lemon, 'http://lemon-model.net/lemon#','http://lexinfo.net/ontology/lemon.rdf').
namespace(v,'http://www.w3.org/2006/vcard/ns#','http://www.w3.org/2006/vcard/ns').
namespace(sioc,'http://rdfs.org/sioc/ns#','http://rdfs.org/sioc/ns'). % User account and groups is here!!
namespace(sioca,'http://rdfs.org/sioc/access#','http://rdfs.org/sioc/access').
namespace(sioct,'http://rdfs.org/sioc/types#','http://rdfs.org/sioc/types').
namespace(siocs,'http://rdfs.org/sioc/services#','http://rdfs.org/sioc/services').

namespace(ui,'http://www.w3.org/ns/ui#','http://www.w3.org/ns/ui').
namespace(pattern,'http://www.essepuntato.it/2008/12/pattern#','data/pattern.owl').
namespace(swrl,'http://www.w3.org/2003/11/swrl#','http://www.w3.org/Submission/2004/SUBM-SWRL-20040521/swrl.rdf').

                                % namespace(cogs,'http://vocab.deri.ie/cogs#','http://vocab.deri.ie/cogs.rdf'). % ETL Database manipulation ontology
                                % namespace(meb,'http://rdf.myexperiment.org/ontologies/base/','http://rdf.myexperiment.org/ontologies/base/'). % Messages from a user to another are here.

                                % namespace(swrlb,'http://www.w3.org/2003/11/swrlb#','https://github.com/kemlg/owlseditor/raw/master/owlseditor/contrib/owl-s/swrlb.owl').

                                % WordNet
%namespace(wn, 'http://wordnet-rdf.princeton.edu/ontology#','http://wordnet-rdf.princeton.edu/wn31.nt.gz').
%namespace(wordnet, 'http://www.w3.org/2006/03/wn/wn20/schema/','http://www.w3.org/2006/03/wn/wn20/schemas/wnfull.rdfs').


                                % http://lexinfo.net/lmf.owl

                                % Predefined namespaces http://dbpedia.org/sparql?nsdecl
                                % http://purl.org/spar/doco Document part ontology, but text document, not law.
                                % http://purl.org/spar/deo Discource elements, that is analogous DOCO
                                % http://www.ai.sri.com/daml/services/owl-s/1.2/ Process denoting ontology, Agents, Grouping, etc.
                                % https://schema.org/docs/gs.html % Global Google, MS, Yahoo project on description of everything. Very expressive vocabulary.


namespace(mvc,'http://purl.org/icc/MVC/ns#','data/MVC.ttl',debug). % Our View-Controller ontology.


namespace1(Abbr,IRI,[]):-
        namespace(Abbr, IRI).
namespace1(Abbr,IRI,[]):-
        namespace(Abbr, IRI, _).
namespace1(Abbr,IRI,[force(true)]):-
        namespace(Abbr, IRI, _, debug).

register_prefixes:-
        namespace1(Abbr, IRI, Op), rdf_register_prefix(Abbr, IRI, Op), fail.
register_prefixes.
