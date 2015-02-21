#!/bin/bash

function honesty-environment() {
    HONESTY_ENV="$1"

    if [[ ${HONESTY_ENV} == 'local' ]]; then
        export INTEGRITY_DATABASE_URL='mysql://root@localhost/integrity'
        export GITHUB_READ_TOKEN='2303674b8ff215e368c5d90c66ed0f4c074849da'
    elif [ -z "${HONESTY_ENV}" ]; then
        echo "usage: honesty-environment ENV (available envs: local)"
        return 1
    else
        echo "no Honesty environment '${HONESTY_ENV}'"
        return 1
    fi
}

function fuck() {
    build=$1
    min_time='4 hours ago'
    error_filter="('rspec ./') OR ('Failure/Error') OR ('# /' OR '# .')"
    rvm use 2.1.5 > /dev/null
    papertrail --min-time "$min_time" "$build AND ($error_filter)" | less -R -X +G
}
