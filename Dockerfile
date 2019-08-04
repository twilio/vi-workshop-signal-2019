FROM bde2020/spark-worker:2.4.3-hadoop2.7

MAINTAINER Twilio Rohit <rgupta@twilio.com>

#### ---- Host Arguments variables----
ARG APACHE_SPARK_VERSION=2.4.3
ARG APACHE_HADOOP_VERSION=2.8.0
ARG SPARK_MASTER="spark://spark-master:7077" 
ARG ZEPPELIN_DOWNLOAD_URL=http://apache.cs.utah.edu/zeppelin
ARG ZEPPELIN_INSTALL_DIR=/usr/lib
ARG ZEPPELIN_HOME=${ZEPPELIN_INSTALL_DIR}/zeppelin 
ARG ZEPPELIN_VERSION=${ZEPPELIN_VERSION:-0.8.1}
ARG ZEPPELIN_PKG_NAME=zeppelin-${ZEPPELIN_VERSION}-bin-all 
ARG ZEPPELIN_PORT=8080 

#### ---- Host Environment variables ----
ENV APACHE_SPARK_VERSION=${APACHE_SPARK_VERSION}
ENV APACHE_HADOOP_VERSION=${APACHE_HADOOP_VERSION} 
ENV SPARK_MASTER=${SPARK_MASTER}
ENV ZEPPELIN_HOME=${ZEPPELIN_HOME} 
ENV ZEPPELIN_CONF_DIR=${ZEPPELIN_HOME}/conf 
ENV ZEPPELIN_DATA_DIR=${ZEPPELIN_HOME}/data
ENV ZEPPELIN_NOTEBOOK_DIR=${ZEPPELIN_HOME}/notebook
ENV ZEPPELIN_DOWNLOAD_URL=${ZEPPELIN_DOWNLOAD_URL}
ENV ZEPPELIN_INSTALL_DIR=${ZEPPELIN_INSTALL_DIR}
ENV ZEPPELIN_VERSION=${ZEPPELIN_VERSION} 
ENV ZEPPELIN_PKG_NAME=zeppelin-${ZEPPELIN_VERSION}-bin-all 
ENV ZEPPELIN_PORT=${ZEPPELIN_PORT} 

#### ---- Zeppelin Installation -----
WORKDIR ${ZEPPELIN_INSTALL_DIR}

#### ---- (Deployment mode use) Zeppelin Installation (Download from Internet -- Deployment) ----
RUN wget -c ${ZEPPELIN_DOWNLOAD_URL}/zeppelin-${ZEPPELIN_VERSION}/${ZEPPELIN_PKG_NAME}.tgz \
    && tar xvf ${ZEPPELIN_PKG_NAME}.tgz \
    && ln -s ${ZEPPELIN_PKG_NAME} zeppelin \
    && mkdir -p ${ZEPPELIN_HOME}/logs && mkdir -p ${ZEPPELIN_HOME}/run \
    && rm -f ${ZEPPELIN_PKG_NAME}.tgz

#### ---- default config is ok ----
COPY zeppelin-site.xml ${ZEPPELIN_HOME}/conf/zeppelin-site.xml
COPY zeppelin-env.sh ${ZEPPELIN_HOME}/conf/zeppelin-env.sh
#COPY worker.sh /

#### ---- Debug ----
RUN mkdir -p ${ZEPPELIN_HOME}/data \
    && ls -al ${ZEPPELIN_HOME}/bin \
    && ls -al ${ZEPPELIN_HOME}/notebook \
    && ls -al ${ZEPPELIN_HOME}/bin/zeppelin-daemon.sh \
    && ls -al ${ZEPPELIN_HOME}/conf/zeppelin-env.sh \
    && ls -al ${ZEPPELIN_HOME}/conf/zeppelin-site.xml

VOLUME ${ZEPPELIN_HOME}/conf
VOLUME ${ZEPPELIN_HOME}/data

EXPOSE ${ZEPPELIN_PORT}

WORKDIR ${ZEPPELIN_HOME}

HEALTHCHECK NONE

CMD ["/usr/lib/zeppelin/bin/zeppelin.sh"]
