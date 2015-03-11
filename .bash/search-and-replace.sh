#!/bin/bash

function sar() {
    PATTERN=$1
    FROM=$2
    TO=$3

    find -name $PATTERN -type f -print -exec sed s/$FROM/$TO/g {} \;
}
