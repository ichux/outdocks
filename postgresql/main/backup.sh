#!/bin/bash
set -e

YEAR_DIR=$(date +%Y)
MONTH_DIR=$(date +%m)
DAY_DIR=$(date +%d)
BACKUP_PATH="$HOME/${YEAR_DIR}-${MONTH_DIR}-${DAY_DIR}"

mkdir -p ${BACKUP_PATH}
FILENAME=${BACKUP_PATH}/postgres-$(date +%Y-%m-%d-%H%M%S.%s.%Z).tar.gz

tar -zcf ${FILENAME} $PWD/pgdata
echo ${FILENAME}
