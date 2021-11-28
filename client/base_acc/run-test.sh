#!/bin/bash

################################################################################
#
# A script to run the example as an integration test. It starts up a localnet
# and executes the current directory's rust binary.
#
# Usage:
#
# ./run-test.sh
#
# Run this script from within the `example/` directory in which it is located.
# The anchor cli must be installed.
#
# cargo install --git https://github.com/project-serum/anchor anchor-cli --locked
#
################################################################################

set -euox pipefail

main() {
    #
    # Build programs.
    #
    pushd ../../programs/base_acc/
    # anchor build
    local base_acc_pid="7GscEKEx8NHT4HYzEgUTB99QtjXu7XFwRykvcw2pEpXK"
    popd

    #
    # Bootup validator.
    #
    # solana-test-validator \
	# 			--bpf-program $base_acc_pid ../..target/deploy/base_acc.so \
	# 			> test-validator.log &
    # solana-test-validator
    # sleep 5

    #
    # Run Test.
    #
    cargo run -- --base-acc-pid $base_acc_pid
}

cleanup() {
    pkill -P $$ || true
    wait || true
}

trap_add() {
    trap_add_cmd=$1; shift || fatal "${FUNCNAME} usage error"
    for trap_add_name in "$@"; do
        trap -- "$(
            extract_trap_cmd() { printf '%s\n' "${3:-}"; }
            eval "extract_trap_cmd $(trap -p "${trap_add_name}")"
            printf '%s\n' "${trap_add_cmd}"
        )" "${trap_add_name}" \
            || fatal "unable to add to trap ${trap_add_name}"
    done
}

declare -f -t trap_add
trap_add 'cleanup' EXIT
main
