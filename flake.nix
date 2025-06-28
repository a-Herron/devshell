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
    nvimAppName = "devshell-nvim";

  in {
    devShell = pkgs.mkShell {
        buildInputs = with pkgs; [
            zig
            zls

            go1_24_2
            gopls
            gofumpt
            golangci-lint
            delve

            typescript
            typescript-language-server
            vue-language-server
            eslint

            tree-sitter
            nodejs_24
            neovim

            git
            zsh
            oh-my-zsh
            tmux

            yaml-language-server

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
            export ZDOTDIR="$HOME/.config/devshell/zsh/"

            mkdir -p "$ZDOTDIR"
            cp -f "${self}/.zshrc" "$HOME/.config/devshell/zsh/.zshrc"

            mkdir -p "$HOME/.config/devshell/tmux"
            rsync -av --delete "${self}/tmux/" "$HOME/.config/devshell/tmux/"
            alias tmux="tmux -f $HOME/.config/devshell/tmux/tmux.conf -L devshell"

            mkdir -p "$HOME/.config/devshell/$NVIM_APPNAME"

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
