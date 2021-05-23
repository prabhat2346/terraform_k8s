#!/usr/bin/env bash

# hive dirs
hadoop fs -mkdir -p      /tmp
hadoop fs -chmod g+w     /tmp
hadoop fs -chown hadoop:hadoop /tmp
hadoop fs -mkdir -p      /user/hive/warehouse
hadoop fs -chmod g+w     /user/hive/warehouse
hadoop fs -mkdir -p .yarn/package/LLAP/
hadoop fs -mkdir -p /apps/tez-0.9.1/
hadoop fs -copyFromLocal /external_deps/tez-0.9.1.tar.gz /apps/tez-0.9.1/
hadoop fs -chmod -R 555 /apps/tez-0.9.1/
hadoop fs -chmod -R 444 /apps/tez-0.9.1/tez-0.9.1.tar.gz
