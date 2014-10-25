# Comment out the below line if you want to be quiet by default.
V=1

ifeq ($(V),1)
E=@true
Q=
MFLAGS=
else
E=@echo
Q=@
MFLAGS=-s
endif

MODULES  := $(shell egrep "^.*\.v$$" _CoqProject | cut -c3- | rev | cut -c3- | rev)
VS       := $(MODULES:%=%.v)
MLFILES  := $(MODULES:%=%.ml)
MLIFILES := $(MODULES:%=%.mli)

.PHONY: coq clean

coq: Makefile.coq
	$(E) "  MAKE Makefile.coq"
	$(Q)$(MAKE) $(MFLAGS) -f Makefile.coq

extract: coq
	$(E) "  OCAMLC Mod1"
	$(Q)ocamlc -o Mod1 Mod1.mli Mod1.ml main.ml

Makefile.coq: Makefile $(VS)
	$(E) "  COQ_MAKEFILE Makefile.coq"
	$(Q)coq_makefile -f _CoqProject -o Makefile.coq

clean:: Makefile.coq
	$(Q)$(MAKE) $(MFLAGS) -f Makefile.coq clean
	$(Q)rm -f Makefile.coq *.bak *.d *.glob *~ result*
	$(Q)rm -f *.cmi *.cmo $(MLFILES) $(MLIFILES)
	$(Q)rm -f Mod1
