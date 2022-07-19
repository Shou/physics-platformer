{ ... }:

let
  sources = import ./nix/sources.nix {};
  pkgs = import sources.nixpkgs {};
  stdenv = pkgs.stdenv;
  lib = pkgs.lib;

  godot-custom = pkgs.godot.overrideAttrs(oa: {
    version = "3.5-beta3";
    
    src = pkgs.fetchzip {
      url = "https://downloads.tuxfamily.org/godotengine/3.5/beta3/godot-3.5-beta3.tar.xz";
      # sha256 = "sha256-intQ42FVy/fj+iVAc2pGgjCpjgRMVOkIyQ3fcXDiUco=";
      sha256 = "sha256-SWdpOoIYW7aQNyJIKm/TzG9TCdyQ6RGXToUjSiuqNEg=";
    };
  });

in

stdenv.mkDerivation rec {
  pname = "physics-platformer";
  version = "0.1";

  buildInputs = (with pkgs; [
    niv
    godot-custom
  ]);
}
