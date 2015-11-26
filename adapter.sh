#!/bin/bash

# reset GHOST_SOURCE and GHOST_CONTENT, 
# ghost will cover them in production mode
export GHOST_SOURCE="/usr/src/ghost"
export GHOST_CONTENT="/usr/src/ghost/content"

is_mysql=0
has_url=0

if [[ -z "$GHOST_ROOT_URL" ]]; then
    export GHOST_ROOT_URL="http://localhost:2368"
    echo "WARNING: You have to specifiy GHOST_ROOT_URL."
else
    has_url=1
fi

if [[ -n "$MYSQL_INSTANCE_NAME" ]]; then
    echo "INFO: Deploy at DaoCloud."
    is_mysql=1
    if [[ $has_url -ne 1 ]]; then
        export GHOST_ROOT_URL="http://changetoyoururl.daoapp.io"
        echo "INFO: Using http://changetoyoururl.daoapp.io temporary."
    fi
    export GHOST_MYSQL_HOST=$MYSQL_PORT_3306_TCP_ADDR
    export GHOST_MYSQL_USER=$MYSQL_USERNAME
    export GHOST_MYSQL_PASSWORD=$MYSQL_PASSWORD
    export GHOST_MYSQL_DATABASE=$MYSQL_INSTANCE_NAME
elif [[ -n "$MYSQL_ENV_MYSQL_VERSION" ]]; then
    echo "INFO: Using linked MySQL."
    is_mysql=1
    export GHOST_MYSQL_HOST=$MYSQL_PORT_3306_TCP_ADDR
    export GHOST_MYSQL_USER=$MYSQL_ENV_MYSQL_USER
    export GHOST_MYSQL_PASSWORD=$MYSQL_ENV_MYSQL_PASSWORD
    export GHOST_MYSQL_DATABASE=$MYSQL_ENV_MYSQL_DATABASE
elif [[ -n "$GHOST_MYSQL_HOST" ]]; then
    echo "INFO: Using external MySQL serevr."
    is_mysql=1
fi

if [[ $is_mysql -eq 1 ]]; then
    cp "/opt/config_mysql.js" "$GHOST_CONTENT/config.js"
    echo "========================================================================"
    echo "Using these environment variables:"
    echo ""
    echo "  \$GHOST_ROOT_URL = ${GHOST_ROOT_URL}"
    echo "  \$GHOST_MYSQL_HOST = ${GHOST_MYSQL_HOST}"
    echo "  \$GHOST_MYSQL_USER = ${GHOST_MYSQL_USER}"
    echo "  \$GHOST_MYSQL_PASSWORD = ${GHOST_MYSQL_PASSWORD}"
    echo "  \$GHOST_MYSQL_DATABASE = ${GHOST_MYSQL_DATABASE}"
    echo ""
    echo "========================================================================"
else
    echo "INFO: Using SQLite."
    echo "========================================================================"
    echo "WARNING: Using SQLite maybe will lost your all"
    echo "         data when you deployed on DaoCloud."
    echo "         Please use MySQL instead."
    echo "========================================================================"
    
    cp "/opt/config_sqlite.js" "$GHOST_CONTENT/config.js"
fi

exec "$@"