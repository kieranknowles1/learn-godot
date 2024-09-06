{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux = let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      godot = pkgs.godot_4;
    in {
      default = pkgs.writeShellScriptBin "editor" ''
        exec ${pkgs.lib.getExe godot} --editor
      '';
    };
  };
}
