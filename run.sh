#!/bin/bash
set -a # automatically export all variables
source .env
set +a

python3 ./fill_template.py ./data/template.txt ./data/data.csv

echo Copy the .pdf files to the folder of .json files.
read -rsp $'Press enter to continue...\n'

if [ "$1" == "sandbox" ]; then
    export APP_ENV="SANDBOX"
    
    python3 ./upload_to_zenodo.py $ACCESS_TOKEN_SANDBOX $DEPOSITS_DIRECTORY
elif [ "$1" == "PRODUCTION" ]; then
    export APP_ENV="production"
    
    echo "You're about to batch upload to production."
    read -rsp $'If you are sure about this, press Enter to continue...\n'
    echo "Proceeding as per your request..."
    
    python3 ./upload_to_zenodo.py $ACCESS_TOKEN_PRODUCTION $DEPOSITS_DIRECTORY
else
    echo "Usage: $0 {sandbox|production}"
    exit 1
fi