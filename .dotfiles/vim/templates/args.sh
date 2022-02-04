#!/bin/bash

ARG="default"
FLAG=false
POSITIONAL=()

while [[ $# -gt 0 ]]
do
key="$1"


case $key in
    -a|--arg)
    ARG="$2"
    shift # past argument
    shift # past value
    ;;
    --flag)
    FLAG=true
    shift # past argument
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters


echo "ARG = $ARG"
echo "FLAG = $FLAG"
echo "POSITIONAL = $@"
