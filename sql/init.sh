#!/bin/sh

set -ex
cd `dirname $0`

export ISUCON_DB_HOST=${ISUCON_DB_HOST:-127.0.0.1}
export ISUCON_DB_PORT=${ISUCON_DB_PORT:-3306}
export ISUCON_DB_USER=${ISUCON_DB_USER:-isucon}
export ISUCON_DB_PASSWORD=${ISUCON_DB_PASSWORD:-isucon}
export ISUCON_DB_NAME=${ISUCON_DB_NAME:-isuports}

# MySQLを初期化
mysql -u"$ISUCON_DB_USER" \
		-p"$ISUCON_DB_PASSWORD" \
		--host "$ISUCON_DB_HOST" \
		--port "$ISUCON_DB_PORT" \
		"$ISUCON_DB_NAME" < init.sql

# テナントを初期化
mysql -u"$ISUCON_DB_USER" \
    -p"$ISUCON_DB_PASSWORD" \
    --host "$ISUCON_DB_HOST" \
    --port "$ISUCON_DB_PORT" \
    "$ISUCON_DB_NAME" < tenant/99_tenant.sql.gz

# SQLiteのデータベースを初期化
rm -f ../tenant_db/*.db
cp -r ../../initial_data/*.db ../tenant_db/
