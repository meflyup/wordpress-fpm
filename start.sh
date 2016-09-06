#!/bin/sh

ESC_SEQ="\x1b["
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_RESET=$ESC_SEQ"39;49;00m"

pretty_print() {
  printf "%b\n" "$1"
}

# generate salts
if [ ! -f .env ];
  then
    echo "# wp-config" >> .env
    echo "DB_NAME=[ENTER DB NAME]" >> .env
    echo "DB_USER=[ENTER DB USER]" >> .env
    echo "DB_PASSWORD=[ENTER DB PASSWORD]" >> .env
    echo "DB_HOST=mysql" >> .env
    echo "TABLE_PREFIX=wp_" >> .env
    echo "WP_DEBUG=true" >> .env
    echo >> .env
    echo "# smtp" >> .env
    echo "SMTP_EMAIL=[ENTER EMAIL ADDRESS]" >> .env
    echo "SMTP_PASSWORD=[ENTER EMAIL PASSWORD]" >> .env
    echo >> .env

    php build/salty.php
    cat salts.txt >> .env
    rm salts.txt

    pretty_print "$COL_GREEN .env file created successfully $COL_RESET"
  else
    pretty_print "$COL_RED .env file already exists $COL_RESET"
fi
