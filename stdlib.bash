#!/bin/bash
set -eu

# keep an eye on https://github.com/codeforester/base/tree/master/lib
# keep an eye on https://github.com/sstephenson/bats

check_num_args() {
    if [[ $# != 2 ]]; then
        echo 'check_num_args requires 2 arguments' >&2
        return 1
    fi
    if [[ $1 != $2 ]]; then
        echo "${FUNCNAME[1]} requires $1 arguments" >&2
        return 1
    fi
}
