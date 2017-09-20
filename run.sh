#!/bin/bash

if [ "${SERVER_NAME}" != "**None**" ]; then
    sed -i "s/ServerName.*/ServerName ${SERVER_NAME}/g" /etc/apache2/apache2.conf
fi

/etc/init.d/apache2 start

/bin/bash

