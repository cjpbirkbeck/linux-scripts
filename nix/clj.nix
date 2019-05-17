{ pkgs ? import <nixpkgs> {} }:
    pkgs.mkShell {
        buildInputs = with pkgs; [ clojure rlwrap leiningen ];
        shellHook = ''
            # Bunch of lines here.
            if [ "$TERM" = "dumb" -o -n "$INSIDE_EMACS" ]; then
              PS1="[\w]\$ "
            else
              PS1="\[\033[1;32m\][\u@\h]\[\033[1;34m\][\w]\[\033[33m\][Clojure]\$\[\033[0m\] "
            fi

            PATH=$HOME/Programming/clojure/bin:$PATH
        '';
}
