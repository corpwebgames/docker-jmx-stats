FROM openjdk:8u151-jre-alpine3.7

ENV JMXTRANS_VERSION 265

RUN wget -q http://central.maven.org/maven2/org/jmxtrans/jmxtrans/${JMXTRANS_VERSION}/jmxtrans-${JMXTRANS_VERSION}-all.jar && \
    wget -q https://raw.githubusercontent.com/jmxtrans/jmxtrans/master/jmxtrans/jmxtrans.sh && \
    chmod +x jmxtrans.sh

 RUN apk add --update python3 && \
     python3 -m ensurepip --upgrade && \
     pip3 install awscli && \
     rm -rf /var/cache/apk/*

ENV JAR_FILE jmxtrans-${JMXTRANS_VERSION}-all.jar
ENV USE_JPS false
ENV JMX_PORT 1099
ENV JVM_CONFIG_PATH https://raw.githubusercontent.com/corpwebgames/docker-jmx-stats/master/jvm.json

ADD run.sh /run.sh

CMD ./run.sh
