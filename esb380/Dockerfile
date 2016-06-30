# Dockerizing Mule EE

FROM                    java:8u91-jdk
ARG MULE_ESB_VERSION
ARG MULE_AGENT_VERSION
MAINTAINER              Support <wwsupport@mulesoft.com>

LABEL version="ESB 3.8.0"
LABEL description="Mule ESB Standalone 3.8.0."

# Install Mule EE
COPY                    ./mule-ee-distribution-standalone-${MULE_ESB_VERSION}.zip /opt/
WORKDIR                 /opt
RUN                     unzip mule-ee-distribution-standalone-${MULE_ESB_VERSION}.zip
RUN                     ln -s mule-enterprise-standalone-${MULE_ESB_VERSION}/ mule

# Uncomment if you want to copy and install the license
# Take note the name of the license file name
WORKDIR                 /opt/mule
ADD                     ./license-mule.lic /opt/mule/conf/
RUN                     bin/mule -installLicense conf/license-mule.lic
RUN                     rm -f conf/license-mule.lic

# Install Mule Agent 1.2.0
WORKDIR                 /opt
COPY                    ./agent-setup-$MULE_AGENT_VERSION.zip /opt/
RUN                     rm /opt/mule/bin/amc_setup
RUN                     rm /opt/mule/bin/amc_setup.bat
RUN                     unzip /opt/agent-setup-$MULE_AGENT_VERSION.zip -d /opt/mule/bin/
RUN                     /opt/mule/bin/amc_setup -U
RUN                     rm /opt/agent-setup-$MULE_AGENT_VERSION.zip

# Run AMC Setup
# WORKDIR                 /opt/mule-enterprise-standalone-3.7.2/bin/
# RUN                     ./amc_setup -A http://52.74.225.250:8080/hybrid/api/v1 -W "wss://52.74.225.250:8443/mule" -F https://52.74.225.250/apiplatform -C https://52.74.225.250/accounts -H 61aa89ba-611a-449a-af83-f13921cee831---2 MULE-$HOSTNAME

# Configure external access:

# HTTP Service Port
# Expose the necessary port ranges as required by the Mule Apps
EXPOSE 8081-8082

# Mule remote debugger
EXPOSE  5000

# Mule JMX port (must match Mule config file)
EXPOSE  1098

# Mule MMC agent port
EXPOSE  7777

# Environment and execution:

ENV             MULE_BASE /opt/mule
WORKDIR         /opt/mule
CMD             /opt/mule/bin/mule
