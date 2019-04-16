# (c) Wong Hoi Sing Edison <hswong3i@pantarei-design.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM ubuntu:18.04

ENV CROWD_OWNER                  "crowd"
ENV CROWD_GROUP                  "crowd"
ENV CROWD_HOME                   "/var/atlassian/application-data/crowd"
ENV CROWD_CATALINA               "/opt/atlassian/crowd"
ENV CROWD_DOWNLOAD_URL           "https://product-downloads.atlassian.com/software/crowd/downloads/atlassian-crowd-3.4.3.tar.gz"
ENV CROWD_DOWNLOAD_DEST          "/tmp/atlassian-crowd-3.4.3.tar.gz"
ENV CROWD_DOWNLOAD_CHECKSUM      "sha1:6af4f3ce4b48ee3d83d9f7908dcf79f5c8d3427e"
ENV JAVA_HOME                    "/usr/lib/jvm/java-8-openjdk-amd64"
ENV JVM_MINIMUM_MEMORY           "128m"
ENV JVM_MAXIMUM_MEMORY           "512m"
ENV CATALINA_CONNECTOR_PROXYNAME ""
ENV CATALINA_CONNECTOR_PROXYPORT ""
ENV CATALINA_CONNECTOR_SCHEME    "http"
ENV CATALINA_CONNECTOR_SECURE    "false"
ENV CATALINA_CONTEXT_PATH        ""
ENV JVM_SUPPORT_RECOMMENDED_ARGS "-Datlassian.plugins.enable.wait=300 -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:MaxRAMFraction=1"
ENV TZ                           "UTC"
ENV SESSION_TIMEOUT              "30"

VOLUME  $CROWD_HOME
WORKDIR $CROWD_HOME

EXPOSE 8020
EXPOSE 8095

ENTRYPOINT [ "dumb-init", "--" ]
CMD        [ "docker-entrypoint.sh" ]

# Explicitly set system user UID/GID
RUN set -ex \
    && groupadd -r $CROWD_OWNER \
    && useradd -r -g $CROWD_GROUP -d $CROWD_HOME -M -s /usr/sbin/nologin $CROWD_OWNER

# Prepare APT dependencies
RUN set -ex \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install ca-certificates curl gcc libffi-dev libssl-dev make python python-dev sudo \
    && rm -rf /var/lib/apt/lists/*

# Install PIP
RUN set -ex \
    && curl -skL https://bootstrap.pypa.io/get-pip.py | python

# Install PIP dependencies
RUN set -ex \
    && pip install --upgrade ansible ansible-lint molecule yamllint \
    && rm -rf /root/.cache/*

# Copy files
COPY files /

# Bootstrap with Ansible
RUN set -ex \
    && cd /etc/ansible/roles/localhost \
    && molecule test \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /root/.cache/* \
    && rm -rf /tmp/*
