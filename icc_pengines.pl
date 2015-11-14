:- use_module(pengine_sandbox:icc).
:- use_module(library(sandbox)).
:- multifile sandbox:safe_primitive/1.

sandbox:safe_primitive(icc:flush).
sandbox:safe_primitive(icc:assert(_,_,_,document)).
sandbox:safe_primitive(icc:assert(_,_,_,principal)).
sandbox:safe_primitive(icc:triple(_,_,_)).
sandbox:safe_primitive(icc:triple(_,_,_,document)).
sandbox:safe_primitive(icc:triple(_,_,_,principal)).
sandbox:safe_primitive(icc:retractall(_,_,_,document)).
sandbox:safe_primitive(icc:retractall(_,_,_,principal)).
sandbox:safe_primitive(icc:update(_,_,_,_,document)).
sandbox:safe_primitive(icc:update(_,_,_,_,principal)).
sandbox:safe_primitive(icc:content(document,_)).
sandbox:safe_primitive(icc:content(annotation,_)).
sandbox:safe_primitive(icc:content(annotation,_,_)).
