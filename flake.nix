{
  description = ( "LittleFS devshell" );

  inputs = {
    nixpkgs = { url = "github:NixOS/nixpkgs/nixos-unstable"; };
  };

  outputs = { self, nixpkgs }:
  let
    system = "aarch64-darwin";
    pkgs = nixpkgs.legacyPackages.${system};
    dependencies = [
      (pkgs.python3.withPackages (pip3: [
        pip3.toml
        # (pip3.buildPythonPackage rec {
        #   pname = "yaml"; version = "6.0"; propagatedBuildInputs = [ ];
        #   src = pip3.fetchPypi { pname = "PyYAML"; inherit version; sha256 = "sha256-aPtRnBQwb+yXIKKltFvJ8MjRuccq30XDe67fzZScNaI="; };
        # })
      ]))
    ];
  in
  {
    devShells.${system}.default = pkgs.mkShell { buildInputs = dependencies; };
  };
}
