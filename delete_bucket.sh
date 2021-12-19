#!/bin/bash

# set -ex

set -o errexit    # exit when a command fails
set -o nounset    # error when an undefined variable is referenced
set -o pipefail   # error if the input command to a pipe fails

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

if [ "$#" -ne 2 ]; then
    echo "Usage: ./delete_bucket.sh <bucket name>  <project id>"
    exit -1
fi

bucket=$1
project=$2

terraform init

terraform destroy -var bucket=$bucket -var project=$project -auto-approve