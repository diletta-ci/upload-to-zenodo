#!/bin/bash

python3 ./fill_template.py ./template.txt data.csv

echo Copy the .pdf files to the folder of .json files.
read -rsp $'Press enter to continue...\n'

TOKEN=INSERT_YOUR_ZENODO_TOKEN_HERE
python3 ./upload_to_zenodo.py $TOKEN .