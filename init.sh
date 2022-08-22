#!/bin/bash

cd /data
mkdir -p backup/cms backup/db
curl -sS https://raw.githubusercontent.com/etonC/cms-autodel-backup/main/Automatic-del-backup.sh -o Automatic-del-backup.sh
