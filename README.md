# loki

[![Build Status](https://drone.osshelp.ru/api/badges/docker/loki/status.svg)](https://drone.osshelp.ru/docker/loki)

## Description

Based on [official loki image](https://hub.docker.com/r/grafana/loki) with custom config, entrypoint and healthcheck added.

## Deploy examples

### Scylla storage

``` yaml
  scylla:
    image: scylladb/scylla:4.1.3
    volumes:
      - /mnt/docker/scylla:/var/lib/scylla
    networks:
      - net

  loki:
    image: osshelp/loki:stable
    environment:
      CASSANDRA_HOSTS: scylla
      CASSANDRA_KEYSPACE: loki
    networks:
      - net
```

### Cassandra storage

``` yaml
  cassandra:
    image: cassandra:3.11.6
    environment:
      CASSANDRA_CLUSTER_NAME: loki
      CASSANDRA_BROADCAST_ADDRESS: cassandra
    volumes:
      - /mnt/data/docker/loki/cassandra:/var/lib/cassandra
    networks:
      - net

  loki:
    image: osshelp/loki:stable
    environment:
      CASSANDRA_HOSTS: cassandra
      CASSANDRA_KEYSPACE: loki
    networks:
      - net
```

### Optional parameters

- USER. Default `nobody`
- DEBUG. Debug mode for loki `-log.level=debug`

### Internal usage

For internal purposes and OSSHelp customers we have an alternative image url:

``` yaml
  image: oss.help/pub/loki:stable
```

There is no difference between the DockerHub image and the oss.help/pub image.

## Links

- [Github](https://github.com/grafana/loki)

## TODO

- Readme update
- Fix tests
- Parameters override support
- Memcached support
- Filesystem storage support
- S3 storage support (+Minio example)
