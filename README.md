# Upload to Zenodo

A simple script to batch upload deposits to [Zenodo](http://zenodo.org).

This script is a fork of the [darvasd](https://github.com/darvasd/upload-to-zenodo/tree/master) repository, to which I give full credit.

## Modifications to Suit My (or My Friends') Specific Needs:

- Passed separate parameters to the `POST` request.
- Added a `.env` file to manage sensitive variables in the script (e.g., the access token).
- Used environment variables to easily deploy to sandbox or production from command line.
- Separated data and template files from the home directory for better readability.
- Separated documents to be uploaded to Zenodo from the home directory for better readability.

## What is Zenodo?
[Zenodo](http://zenodo.org) is a free, open-source research repository, containing papers, but also data sets and software. 

## Quick start
_You don't want to accidentally flood your real Zenodo account with dummy submissions. We don't want that either. That's why the script have two different command to differenciate betweent Zenodo sandbox and production. 

Use the command `bash run.sh sandbox` to upload into the sandbox.

When you are done with experimenting, just use `bash run.sh production` to run the script on production environment.

Remember to set up your environment variable in the .env file (have a look at the example below).
_

<a href="https://github.com/darvasd/upload-to-zenodo/blob/master/docs/overview.png" title="Overview"><img src="https://github.com/darvasd/upload-to-zenodo/blob/master/docs/overview.png" width="800" /></a>

1. Get a _Personal access token_ at https://zenodo.org/account/settings/applications/. The `deposit:write` is enough: to be on the safe side, the script does not publish the uploaded papers, the _Publish_ button has to be pushed manually. (Once a document is published on Zenodo, the attached files cannot be modified.)
   - Set the variable `ACCESS_TOKEN_SANDBOX`|`ACCESS_TOKEN_PRODUCTION` with your token in the .env file.
1. If you would like to group all your uploads to a Zenodo _Comunity_ (that may represent your conference or conference series), [create it](https://zenodo.org/communities/new/) and note its ID. 
1. Create a template JSON describing your submissions. Check the [documentation](https://zenodo.org/dev#restapi-rep) (Representations > Deposition metadata) for details about it.
   - Use `{key-name}` for parts that are different for each submission.
   - An example template and some example deposition metadata files can be found in the example folder.
   - The JSON description of any submitted document can be checked by clicking on the JSON link in the Export panel (or by checking the `https://zenodo.org/record/{ID}/export/json` URL.)
1. Create a CSV file that describes the parts that are different for each submission.
   - The `{key-name}` strings of the template will be replaced by the values from the colmn having `key-name` as header in the CSV file.
   - The CSV file should contain a `FILENAME` column, describing the name of the file created by substituting the values from the given row to the template.
1. Execute the script `fill_template.py` to generate the descriptors (deposition metadata) for each submission.
	- Usage: `fill_template.py <template_filename> <data_filename>`, where `<template_filename>` is the name (path) of the template file, and `<data_filename>` is the name (path) of the CSV data file.
   - You define the name of the path (directory) in the .env file (`$DEPOSITS_DIRECTORY`)
1. Copy the PDF files to be uploaded to the folder where you have previously generated JSON descriptors.
   - The PDF file (paper) that belongs to `xyz.json` is `xyz.pdf`.
1. Execute the script `upload_to_zenodo.py` to upload your submissions.
   - Usage: `upload_to_zenodo.py <token> <directory>`, where `<token>` is your personal access token, and `<directory>` is the directory that contains the JSON and PDF files to be uploaded.
1. Go to the [Upload page](https://zenodo.org/deposit), check and publish your submissions.


## .env File Example
```
BASE_URL_SANDBOX="https://sandbox.zenodo.org"
BASE_URL_PRODUCTION="https://zenodo.org"
ACCESS_TOKEN_SANDBOX="yourSandboxToken"
ACCESS_TOKEN_PRODUCTION="yourProductionToken"
DEPOSITS_DIRECTORY="./deposits"
```


### Disclaimer
The scripts are in early phase, but they are enough for the purpose of batch upload deposits to Zenodo. Always double check your deposits before submitting to production and before publishing.