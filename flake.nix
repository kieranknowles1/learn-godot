{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    nixcfg.url = "github:kieranknowles1/nixcfg";
    nixcfg.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixcfg }: let
    pkgs = import nixpkgs { system = "x86_64-linux"; };
    godot = pkgs.godot_4;
  in rec {
    packages.x86_64-linux = {
      default = pkgs.writeShellScriptBin "editor" ''
        exec ${pkgs.lib.getExe godot} --editor $@
      '';
    };

    devShells.x86_64-linux = {
      default = let
        openEditor = pkgs.lib.getExe packages.x86_64-linux.default;
      # My extended version of mkShell, which preserves the user's shell of choice
      in nixcfg.lib.shell.mkShellEx {
        packages = [
          godot
        ];

        shellHook = ''
          # Run the editor in the background, discarding stdout and stderr
          ${openEditor} > /dev/null 2>&1 &
          code . &
        '';
      };
    };
  };
}
