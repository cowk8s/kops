#!/bin/bash

set -o errexit
set -o pipefail

CMD=$1

if [ "$CMD" == "build" ];
then
  mkdocs build
  exit 0;
fi

mkdocs serve --dev-addr=0.0.0.0:3000 --livereload