if [[ -z "$SYSD_ENV_SET" ]]; then
    set -a
    source <(/usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator)
    set +a
    export SYSD_ENV_SET="y"
fi
