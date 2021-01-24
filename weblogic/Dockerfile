#Copyright (c) 2014, 2020, Oracle and/or its affiliates.
#
#Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.
#
# ORACLE DOCKERFILES PROJECT
# --------------------------
# This Dockerfile extends the Oracle WebLogic image by creating a sample domain.
#
# Util scripts are copied into the image enabling users to plug NodeManager
# automatically into the AdminServer running on another container.
#
# HOW TO BUILD THIS IMAGE
# -----------------------
# Put all downloaded files in the same directory as this Dockerfile
# Run:
#      $ sudo docker build -t 12213-domain-home-image
#
# Pull base image
# ---------------
#FROM oracle/weblogic:12.2.1.3-generic
#FROM oracle/weblogic:12213-opatch-upgrade
FROM oracle/weblogic:14.1.1.0-generic-11
# Maintainer
# ----------
MAINTAINER Monica Riccelli <monica.riccelli@oracle.com>

ARG CUSTOM_DOMAIN_NAME="${CUSTOM_DOMAIN_NAME:-domain1}"
ARG CUSTOM_ADMIN_PORT="${CUSTOM_ADMIN_PORT:-7001}"  
ARG CUSTOM_ADMIN_SERVER_SSL_PORT="${CUSTOM_ADMIN_SERVER_SSL_PORT:-7002}"  
ARG CUSTOM_MANAGED_SERVER_PORT="${CUSTOM_MANAGED_SERVER_PORT:-8001}"
ARG CUSTOM_MANAGED_SERVER_SSL_PORT="${CUSTOM_MANAGED_SERVER_SSL_PORT:-8002}"
ARG CUSTOM_DEBUG_PORT="${CUSTOM_DEBUG_PORT:-8453}"
ARG CUSTOM_ADMIN_NAME="${CUSTOM_ADMIN_NAME:-admin-server}"
ARG CUSTOM_ADMIN_HOST="${CUSTOM_ADMIN_HOST:-wlsadmin}"
ARG CUSTOM_CLUSTER_NAME="${CUSTOM_CLUSTER_NAME:-DockerCluster}"
ARG CUSTOM_SSL_ENABLED="${CUSTOM_SSL_ENABLED:-false}"

# WLS Configuration
# ---------------------------
ENV ORACLE_HOME=/u01/oracle \
    PROPERTIES_FILE_DIR="/u01/oracle/properties" \
    SSL_ENABLED="${CUSTOM_SSL_ENABLED}" \
    DOMAIN_NAME="${CUSTOM_DOMAIN_NAME}" \
    DOMAIN_HOME="/u01/oracle/user_projects/domains/${CUSTOM_DOMAIN_NAME}" \
    ADMIN_PORT="${CUSTOM_ADMIN_PORT}" \
    ADMIN_SERVER_SSL_PORT="${CUSTOM_ADMIN_SERVER_SSL_PORT}" \
    ADMIN_NAME="${CUSTOM_ADMIN_NAME}" \
    ADMIN_HOST="${CUSTOM_ADMIN_HOST}" \
    CLUSTER_NAME="${CUSTOM_CLUSTER_NAME}" \
    MANAGED_SERVER_PORT="${CUSTOM_MANAGED_SERVER_PORT}" \
    MANAGED_SERVER_SSL_PORT="${CUSTOM_MANAGED_SERVER_SSL_PORT}" \
    MANAGED_SERV_NAME="${CUSTOM_MANAGED_SERV_NAME}" \
    DEBUG_PORT="8453" \
 #   AS_HOME="${DOMAIN_HOME}/servers/${ADMIN_NAME}" \
 #   MS_HOME="${DOMAIN_HOME}/servers/hsoftdev" \
    PATH=$PATH:/u01/oracle/oracle_common/common/bin:/u01/oracle/wlserver/common/bin:${DOMAIN_HOME}:${DOMAIN_HOME}/bin:/u01/oracle

# Add files required to build this image
USER root
RUN yum -y install telnet vim && yum -y clean all
RUN mkdir -p /u01/oracle/user_projects/domains/hsoftdev/servers/hsoftadmin/logs
RUN touch /u01/oracle/user_projects/domains/hsoftdev/servers/hsoftadmin/logs/access.log
RUN chown -R oracle:oinstall /u01/oracle/user_projects/domains/hsoftdev/servers/
COPY --chown=oracle:oinstall container-scripts/* /u01/oracle/
COPY jks/identity.jks /u01/oracle/user_projects/domains/hsoftdev/security/identity.jks
COPY jks/trust.jks /u01/oracle/user_projects/domains/hsoftdev/security/trust.jks

#Create directory where domain will be written to
USER root
RUN chmod +xw /u01/oracle/*.sh && \
    chmod +xw /u01/oracle/*.py && \
    mkdir -p ${PROPERTIES_FILE_DIR} && \
    chown -R oracle:oinstall ${PROPERTIES_FILE_DIR} && \
    mkdir -p $DOMAIN_HOME && \
    chown -R oracle:oinstall $DOMAIN_HOME/.. && \
    chmod -R a+xwr $DOMAIN_HOME/..

COPY --chown=oracle:oinstall properties/docker-build/domain*.properties ${PROPERTIES_FILE_DIR}/

# Configuration of WLS Domain
USER root
RUN /u01/oracle/createWLSDomain.sh && \
    echo ". $DOMAIN_HOME/bin/setDomainEnv.sh" >> /u01/oracle/.bashrc && \
    chmod -R a+x $DOMAIN_HOME/bin/*.sh  && \
    rm ${PROPERTIES_FILE_DIR}/*.properties


COPY container-scripts/* /u01/oracle/

RUN wlst -loadProperties /u01/oracle/datasource.properties /u01/oracle/ds-deploy.py 
#    && \
#    wlst /u01/oracle/jms-deploy.py

COPY setDomainEnv.sh /u01/oracle/user_projects/domains/hsoftdev/bin/setDomainEnv.sh
COPY otData.war /u01/oracle/user_projects/domains/hsoftdev/autodeploy
# Expose ports for admin, managed server, and debug
EXPOSE $ADMIN_PORT $ADMIN_SERVER_SSL_PORT $MANAGED_SERVER_PORT $MANAGED_SERVER_SSL_PORT $DEBUG_PORT

RUN chown -R oracle:oinstall /u01/oracle/user_projects/domains
#RUN chown -R oracle:oinstall /u01/oracle

WORKDIR $DOMAIN_HOME

# Define default command to start bash.
CMD ["startAdminServer.sh"]
