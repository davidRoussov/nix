{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    git
    neovim
    tree
    terraform
    zoxide
    jq
    tmux
    moreutils
    timewarrior
    mpv
    awscli
    direnv
    htop
    ripgrep
    neomutt
    sc-im
    tshark
    pandoc
    texlive.combined.scheme-full
    kubectl
  ];

  shellHook = ''
    cd /Users/david/@/


    if [ -z "$OPENAI_API_KEY" ]; then
        echo "OPENAI_API_KEY is not set. Retrieving from AWS Secrets Manager..."

        SECRET_VALUE=$(AWS_PROFILE=davidroussov aws secretsmanager get-secret-value --secret-id "openai.api_key" --query 'SecretString' --output text 2>/dev/null)

        if [ $? -ne 0 ]; then
            exit 1
        fi

        export OPENAI_API_KEY="$SECRET_VALUE"
    fi


    export PATH="/opt/homebrew/bin:$PATH"

  '';
}
