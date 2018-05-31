#!/bin/sh

instance=$(wget -q -O - http://169.254.169.254/latest/meta-data/instance-id)
wget -q $JVM_CONFIG_PATH

if [ ! -z "$ALB_TARGET_NAME" ]; then
 alb_target_arn=`aws elbv2 --region us-east-1 describe-target-groups --names $ALB_TARGET_NAME --output text --query "TargetGroups[].TargetGroupArn" | cut -d ':' -f 6 `
fi

export JAVA_OPTS="$JAVA_OPTS -DALIAS_NODE=$instance -DALB_TARGET=$alb_target_arn"

echo $JAVA_OPTS

sh jmxtrans.sh start 2>&1 | tee jmxtrans.log
exec tail -f ./jmxtrans.log
