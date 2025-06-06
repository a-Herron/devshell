{
  description = "Devshell with nvim config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }: utils.lib.eachDefaultSystem (system: 
  let
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
    devShell = pkgs.mkShell {
        buildInputs = with pkgs; [
            go1_24_2
            gopls
            gofumpt
            golangci-lint
            tree-sitter
            nodejs_24
            git
            zsh
            oh-my-zsh
            neovim
            tmux

            gcc
            gnumake
            python3
            rsync
            fd
            ripgrep
            fzf
            fzf-zsh
            sqlite
        ] ++ lib.optionals stdenv.isLinux [ glibc ];

        shellHook = ''
            export ZSH="${pkgs.oh-my-zsh}/share/oh-my-zsh"
            export NVIM_APPNAME=${nvimAppName}
            export ZDOTDIR="$HOME/.config/zsh/"

            mkdir -p "$ZDOTDIR"
            cp -f "${self}/.zshrc" "$HOME/.config/zsh/.zshrc"

            mkdir -p "$HOME/.config/$NVIM_APPNAME"

            rsync -av --delete "${self}/nvim/" "$HOME/.config/$NVIM_APPNAME/"
            chmod -R u+rw "$HOME/.config/$NVIM_APPNAME/"

            exec zsh
        '';
    };

    packages.dev = pkgs.writeShellScriptBin "dev" ''
        exec nix develop github:a-Herron/devshell#devShell.${system}
    '';
  }
  );
}
