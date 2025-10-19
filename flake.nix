{
  description = "Haskell dev environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      hpkgs = pkgs.haskell.packages."ghc912";
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          hpkgs.ghc
          hpkgs.haskell-language-server
        ];

        shellHook = ''
          zsh
          alias exit=exit&&exit
        '';
      };
    };
}
