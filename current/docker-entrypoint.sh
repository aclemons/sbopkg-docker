#!/bin/bash

set -e

exec su -l -c "$0" -- root "$@"
