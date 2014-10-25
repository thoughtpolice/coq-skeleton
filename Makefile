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
HSFILES  := driver/hs/Mod1.hs
MLFILES  := driver/ml/mod1.mli driver/ml/mod1.ml

.PHONY: coq clean

coq: Makefile.coq
	$(E) "  MAKE Makefile.coq"
	$(Q)$(MAKE) $(MFLAGS) -f Makefile.coq

extract: extract-ocaml extract-haskell

extract-haskell: coq
	$(E) "  GHC      Mod1"
	$(Q)ghc -O2  -o mod1.hs.exe -idriver/hs $(HSFILES) driver/hs/main.hs

extract-ocaml: coq
	$(E) "  OCAMLOPT Mod1"
	$(Q)ocamlopt -o mod1.ml.exe -I driver/ml/ $(MLFILES) driver/ml/main.ml

Makefile.coq: Makefile $(VS)
	$(E) "  COQ_MAKEFILE Makefile.coq"
	$(Q)coq_makefile -f _CoqProject -o Makefile.coq

clean:: Makefile.coq
	$(Q)$(MAKE) $(MFLAGS) -f Makefile.coq clean
	$(Q)rm -f Makefile.coq *.bak *.d *.glob *~ result*
	$(Q)rm -f *.exe *.cmi *.cmo $(MLFILES) $(HSFILES)
	$(Q)rm -f driver/hs/*.hi driver/hs/*.o
	$(Q)rm -f driver/ml/*.cmx driver/ml/*.cmi driver/ml/*.o

