#!/bin/bash

set -e

echo "root=$SMTP_EMAIL" >> /etc/ssmtp/ssmtp.conf
echo "mailhub=smtp.gmail.com:465" >> /etc/ssmtp/ssmtp.conf
echo "rewriteDomain=gmail.com" >> /etc/ssmtp/ssmtp.conf
echo "AuthUser=$SMTP_EMAIL" >> /etc/ssmtp/ssmtp.conf
echo "AuthPass=$SMTP_PASSWORD" >> /etc/ssmtp/ssmtp.conf
echo "FromLineOverride=YES" >> /etc/ssmtp/ssmtp.conf
echo "UseTLS=YES" >> /etc/ssmtp/ssmtp.conf

exec "$@"
