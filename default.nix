{ COQEXE ? { outPath = ./.; revCount = 0; shortRev = "abcdef"; rev = "HEAD"; }
, nixcfg ? { allowUnfree = true; }
, pkgs   ? import <nixpkgs> { config=nixcfg; }
, officialRelease ? false
, coverityUpload ? false
}:

let
  systems = [ "i686-linux" "x86_64-linux"
             #"x86_64-darwin"
            ];

  version = builtins.readFile ./VERSION +
    (pkgs.lib.optionalString (!officialRelease)
      "-r${toString COQEXE.revCount}-g${COQEXE.shortRev}");

  jobs = rec {
    ## -- Tarballs -------------------------------------------------------------
    tarball = pkgs.releaseTools.sourceTarball {
      name = "COQEXE-tarball";
      src  = COQEXE;
      inherit version;
      buildInputs = with pkgs; [ git xz ];
      meta.maintainers = [ "aseipp@pobox.com" ];

      distPhase = ''
        relname=COQEXE-${version}
        mkdir ../$relname
        cp -prd . ../$relname
        rm -rf ../$relname/.git ../$relname/svn-revision
        echo -n ${version} > ../$relname/VERSION

        mkdir $out/tarballs
        tar cvfJ $out/tarballs/$relname.tar.xz -C .. $relname
      '';
    };

    ## -- Build ----------------------------------------------------------------
    build = pkgs.lib.genAttrs systems (system:
      with import <nixpkgs> { inherit system; config=nixcfg; };

      releaseTools.nixBuild {
        name = "COQEXE";
        inherit version;
        src  = tarball;
        meta.maintainers = [ "aseipp@pobox.com" ];

        enableParallelBuilding = true;
        doCheck = false;

        installPhase = "make extract";
	buildInputs = [ coq ocaml utillinux ];
      }
    );
  };

in jobs
