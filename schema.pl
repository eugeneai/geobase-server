schema('abbreviation','of','state').
schema('state','with','abbreviation').
schema('capital','of','state').
schema('state','with','capital').
schema('population','of','state').
schema('state','with','population').
schema('area','of','state').
schema('city','in','state').
schema('state','with','city').
schema('population','of','city').
schema('population','of','capital').
schema('length','of','river').
schema('state','with','river').
schema('river','in','state').
schema('state','border','state').
schema('city','with','population').
schema('state','with','population').
schema('river','with','length').
schema('capital','with','population').
schema('point','in','state').
schema('state','with','point').
schema('height','of','point').
schema('mountain','in','state').
schema('state','with','mountain').
schema('height','of','mountain').
schema('lake','in','state').
schema('state','with','lake').
schema('area','of','lake').
schema('state','with','road').
schema('road','in','state').
schema('name','of','river').
schema('name','of','capital').
schema('name','of','city').
schema('name','of','state').
schema('name','of','point').
schema('name','of','mountain').
schema('name','of','lake').
schema('name','of','road').
schema('river','in','continent').
schema('city','in','continent').
schema('capital','in','continent').
schema('state','in','continent').
schema('point','in','continent').
schema('mountain','in','continent').
schema('lake','in','continent').
schema('road','in','continent').

schema('fault','in','continent').
schema('fault','with','feature').
%schema('feature','of','fault').
schema('name','of','fault').
schema(Prop, 'of', SubjName):-
        var(SubjName),
        geob_prop(Prop,_).

schema(Prop, 'of', SubjName):-
        nonvar(SubjName),
        geob_prop(Prop, GProp),
        sub_atom(SubjName,0,1,R,H),
        sub_atom(SubjName,1,R,0,T),
        string_upper(H,U),
        atom_concat(U,T,SubjNameU),
        geob_class(SubjNameU, Subj),
        rdf_reachable(Subj, rdfs:subClassOf, Parent),
        rdf(GProp, rdfs:domain, Parent),!.

geob_prop(Prop, GProp):-
        rdf_global_id(geob:Prop, GProp),
        rdf(GProp,rdf:type,owl:'ObjectProperty'),!.

geob_class(Class, GClass):-
        rdf_global_id(geob:Class, GClass),
        rdf(GClass,rdf:type,owl:'Class'),!.
