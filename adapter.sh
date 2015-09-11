#!/bin/bash

export GHOST_SOURCE="/usr/src/ghost"
export GHOST_CONTENT="/usr/src/ghost/content"

if [[ -z "$GHOST_ROOT_URL" ]]; then
    export GHOST_ROOT_URL="http://changetoyoururl.daoapp.io"
    echo "warning: You have to specific GHOST_ROOT_URL,"
    echo "use http://changetoyoururl.daoapp.io temporarily."
fi

if [[ -n "$MYSQL_INSTANCE_NAME" ]]; then
    echo "info: Deploy at DaoCloud."
    export MYSQL_PORT_3306_TCP_ADDR=$MYSQL_PORT_3306_TCP_ADDR
    export MYSQL_ENV_MYSQL_USER=$MYSQL_USERNAME
    export MYSQL_ENV_MYSQL_PASSWORD=$MYSQL_PASSWORD
    export MYSQL_ENV_MYSQL_DATABASE=$MYSQL_INSTANCE_NAME
    echo "========================================================================"
    echo "Using these environment variables:"
    echo ""
    echo "  \$MYSQL_PORT_3306_TCP_ADDR = ${MYSQL_PORT_3306_TCP_ADDR}"
    echo "  \$MYSQL_ENV_MYSQL_USER = ${MYSQL_ENV_MYSQL_USER}"
    echo "  \$MYSQL_ENV_MYSQL_PASSWORD = ${MYSQL_ENV_MYSQL_PASSWORD}"
    echo "  \$MYSQL_ENV_MYSQL_DATABASE = ${MYSQL_ENV_MYSQL_DATABASE}"
    echo ""
    echo "========================================================================"
elif [[ -z "$MYSQL_ENV_MYSQL_VERSION" ]]; then
    echo "error: Can't find any mysql database, use --link some-mysql:mysql"
    echo "to specific a database."
    exit
fi

cp "/opt/config.js" "$GHOST_CONTENT/config.js"

exec "$@"