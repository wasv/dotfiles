if [[ -z "$SYSD_ENV_SET" ]]; then
    export $(/usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator)
    export SYSD_ENV_SET="y"
fi
