{
  description = "Haskell dev environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      hpkgs = pkgs.haskell.packages."ghc98";
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with hpkgs;[
          ghc
          haskell-language-server
          cabal-install
        ];

        shellHook = ''
          zsh
          alias exit=exit&&exit
        '';
      };
    };
}
