{ pkgs ? import <nixpkgs> {} }:
    pkgs.mkShell {
        buildInputs = with pkgs; [ go ];
        shellHook = ''
            goversion=$(go version | awk ' { print $3 } ')
            # Bunch of lines here.
            if [ "$TERM" = "dumb" -o -n "$INSIDE_EMACS" ]; then
              PS1="[\w]\$ "
            else
              PS1="\[\033[1;32m\][\u@\h]\[\033[1;34m\][\w]\[\033[33m\][$goversion]\$\[\033[0m\] "
            fi

            GOROOT=$GOPATH
            GOPATH=$HOME/Programming/golang
            PATH=$GOPATH/bin:$PATH

            alias gopath="cd $GOPATH"
            alias goroot="cd $GOROOT"
        '';
}
