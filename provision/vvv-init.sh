#!/usr/bin/env bash
#
# Configuration.
#

DOMAIN=`get_primary_host "${VVV_SITE_NAME}".dev`
DOMAINS=`get_hosts "${DOMAIN}"`
SITE_TITLE=`get_config_value 'site_title' "${DOMAIN}"`

DB_NAME=laraveact_dev
DB_PROVISION="$PWD/public_html/database/provision"

#
# Start doing the thing.
#

echo "Starting site setup"

#
# Folder structure.
#

# Nginx Logs
mkdir -p ${VVV_PATH_TO_SITE}/storage/log
touch ${VVV_PATH_TO_SITE}/log/storage/error.log
touch ${VVV_PATH_TO_SITE}/log/storage/access.log

#
# Database.
#

db_exists=$(mysql -u root --password=root -e "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = '${DB_NAME}'")
if [ -z "$db_exists" ]; then
	echo "Creating database"
	mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME}"
fi
