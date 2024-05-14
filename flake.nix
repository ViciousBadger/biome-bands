{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in
    flake-utils.lib.eachDefaultSystem (system: {
      formatter = pkgs.alejandra;

      devShells.default = pkgs.mkShell rec {
        buildInputs = with pkgs; [
          jdk17
          libGL
          (jdt-language-server.override { jdk = jdk17; })
        ];
        LD_LIBRARY_PATH = "${nixpkgs.lib.makeLibraryPath buildInputs}";
      };
    });
}

