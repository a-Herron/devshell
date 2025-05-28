{
  description = "Devshell with nvim config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    go1_24_2 = pkgs.go.overrideAttrs (oldAttrs: {
      version = "1.24.2";
      src = pkgs.fetchurl {
        url = "https://go.dev/dl/go1.24.2.src.tar.gz";
        hash = "sha256-ncd/+twW2DehvzLZnGJMtN8GR87nsRnt2eexvMBfLgA=";
      };
    });
    nvimAppName = "mynvim";
  in {
    devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
            go1_24_2
            gopls
            gofumpt
            golangci-lint
            tree-sitter
            nodejs_24
            git
            zsh
            neovim

            gcc
            gnumake
            python3
            glibc
            rsync
            fd
            sqlite
        ];

        shellHook = ''
            export NVIM_APPNAME=${nvimAppName}
            mkdir -p "$HOME/.config/$NVIM_APPNAME"
            
            rsync -av --delete "${self}/nvim/" "$HOME/.config/$NVIM_APPNAME/"
            chmod -R u+rw "$HOME/.config/$NVIM_APPNAME/"

            zsh
        '';

    };
  };
}
