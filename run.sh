#!/bin/sh

instance=$(wget -q -O - http://169.254.169.254/latest/meta-data/instance-id)
wget -q $JVM_CONFIG_PATH

export JAVA_OPTS="$JAVA_OPTS -DALIAS_NODE=$instance"

echo $JAVA_OPTS

sh jmxtrans.sh start 2>&1 | tee jmxtrans.log
exec tail -f ./jmxtrans.log