#!/bin/bash
set -a # automatically export all variables
source .env
set +a

python3 ./fill_template.py ./data/template.txt ./data/data.csv

echo Copy the .pdf files to the folder of .json files.
read -rsp $'Press enter to continue...\n'

TOKEN=$ACCESS_TOKEN_SANDBOX
python3 ./upload_to_zenodo.py $TOKEN .