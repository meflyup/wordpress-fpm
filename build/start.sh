#!/bin/sh

ESC_SEQ="\x1b["
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_RESET=$ESC_SEQ"39;49;00m"

pretty_print() {
  printf "%b\n" "$1"
}

ENV_FILE=.env

if [ ! -f $ENV_FILE ];
  then
    echo "# wp-config" >> $ENV_FILE
    echo "DB_NAME=[ENTER DB NAME]" >> $ENV_FILE
    echo "DB_USER=[ENTER DB USER]" >> $ENV_FILE
    echo "DB_PASSWORD=[ENTER DB PASSWORD]" >> $ENV_FILE
    echo "DB_HOST=mysql" >> $ENV_FILE
    echo "TABLE_PREFIX=wp_" >> $ENV_FILE
    echo "WP_DEBUG=true" >> $ENV_FILE
    echo >> $ENV_FILE
    echo "# smtp" >> $ENV_FILE
    echo "SMTP_EMAIL=[ENTER EMAIL ADDRESS]" >> $ENV_FILE
    echo "SMTP_PASSWORD=[ENTER EMAIL PASSWORD]" >> $ENV_FILE
    echo >> $ENV_FILE
    php build/salty.php
    cat salts.txt >> $ENV_FILE
    rm salts.txt
    pretty_print "$COL_GREEN The .env file has been created successfully. $COL_RESET"
  else
    pretty_print "$COL_RED The .env file already exists. $COL_RESET"
fi
