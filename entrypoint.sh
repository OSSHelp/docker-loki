#!/bin/sh
# shellcheck disable=SC2153

loki_config=/etc/loki/local-config.yaml
user="${USER:-nobody}"

env | grep -q CASSANDRA && {
  loki_config=/etc/loki/cassandra-config.yaml
  sed -i "s/CASSANDRA_HOSTS/${CASSANDRA_HOSTS:-cassandra}/" $loki_config
  sed -i "s/CASSANDRA_KEYSPACE/${CASSANDRA_KEYSPACE:-loki}/" $loki_config
  sed -i "s/MEMCACHED_HOST/${MEMCACHED_HOST:-memcached}/g" $loki_config
}

test -n "$DEBUG" && debug="-log.level=debug"
test -n "$CI_TESTING" && sleep "${SLEEP_TIME:-60}"

if [ -z "$1" ]; then
  # shellcheck disable=SC2086
  su-exec "$user" loki $debug -config.file="$loki_config"
fi

exec "$@"
