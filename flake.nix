{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    nvimAppName = "mynvim";
  in {
    devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
            go
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
        '';

    };
  };
}
