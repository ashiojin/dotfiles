#!/usr/bin/env bash

exercism_dl() {
    local track="$1"
    local exercise="$2"
    local workspace=$(exercism workspace)

    exercism download --track="$track" --exercise="$exercise" && {
        cd "$workspace/$track/$exercise"
    }
}
