#!/bin/bash

function sar() {
    PATTERN=$1
    FROM=$2
    TO=$3

    find . -type d -name .git -prune -o -type f -name "${PATTERN}" -print -exec sed -i -e"s/${FROM}/${TO}/g" {} \;

}
