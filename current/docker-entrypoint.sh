#!/bin/bash

set -e

# shellcheck disable=SC2016
exec su - root -l -c '"$0" "$@"' -- "$@"
