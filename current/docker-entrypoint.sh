#!/bin/bash

set -e

if [ "$SBOPKG_AUTO_INSTALL" = "yes" ] || [ "$SBOPKG_AUTO_INSTALL" = "1" ] ; then
  find /tmp -type f -name '*_SBo.tgz' -maxdepth 1 -print0 | xargs -0 -I xx upgradepkg --install-new xx
fi

if [ "$0" = "" ] ; then
  # shellcheck disable=SC2016
  exec su - root -l -c '"$0" "$@"' -- bash "$@"
else
  # shellcheck disable=SC2016
  exec su - root -l -c '"$0" "$@"' -- "$@"
fi
