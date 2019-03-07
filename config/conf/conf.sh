#!/bin/sh

# Copyright (c) 2000-2018, Board of Trustees of Leland Stanford Jr. University
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification,
# are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice, this
# list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright notice,
# this list of conditions and the following disclaimer in the documentation and/or
# other materials provided with the distribution.
#
# 3. Neither the name of the copyright holder nor the names of its contributors
# may be used to endorse or promote products derived from this software without
# specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
# ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

MVN_GRP='org.lockss.laaws'

UI_USER=claire
UI_PASS=SHA-256:b515ed947183189479f29b35d92b58f431e6ac3a787471c30299686869d774cf
CFG_GRP="${MVN_GRP}"
CFG_ART='laaws-configuration-service'
CFG_VERSION='1.1.0-SNAPSHOT'
CFG_HOST=lockss-configuration-service
CFG_REST_PORT='24620'
CFG_UI_PORT='24621'
CFG_CMD="-b config/cluster/bootstrap.txt
         -l config/cluster/cluster.txt
         -l config/cluster/cluster.opt
         -p config/services/lockss-configuration-service/lockss.txt
         -p config/services/lockss-configuration-service/lockss.opt"
CFG_URL="http://${UI_USER}:${UI_PASS}@${CFG_HOST}:${CFG_REST_PORT}"

JMS_HOST="${CFG_HOST}"
JMS_PORT='61616'

MDQ_GRP="${MVN_GRP}"
MDQ_ART='laaws-metadata-service'
MDQ_VERSION='1.0.0-SNAPSHOT'
MDQ_HOST=lockss-metadata-service
MDQ_REST_PORT='24650'
MDQ_UI_PORT='24651'
MDQ_CMD="-b config/cluster/bootstrap.txt
         -c ${CFG_URL}
         -p ${CFG_URL}/config/file/cluster
         -p config/services/lockss-metadata-service/lockss.txt
         -p config/services/lockss-metadata-service/lockss.opt"

MDX_GRP="${MVN_GRP}"
MDX_ART='laaws-metadata-extraction-service'
MDX_VERSION='1.1.0-SNAPSHOT'
MDX_REST_PORT='24640'
MDX_UI_PORT='24641'
MDX_CMD="-b config/cluster/bootstrap.txt
         -c ${CFG_URL}
         -p ${CFG_URL}/config/file/cluster
         -p config/services/lockss-metadata-extraction-service/lockss.txt
         -p config/services/lockss-metadata-extraction-service/lockss.opt"

POL_GRP="${MVN_GRP}"
POL_ART='laaws-poller'
POL_VERSION='1.0.0-SNAPSHOT'
POL_REST_PORT='24630'
POL_UI_PORT='24631'
POL_CMD="-b config/cluster/bootstrap.txt
         -c ${CFG_URL}
         -p ${CFG_URL}/config/file/cluster
         -p config/services/lockss-poller/lockss.txt
         -p config/services/lockss-poller/lockss.opt"

# LAAWS repository service configuration
REPO_GRP="${MVN_GRP}"
REPO_ART='laaws-repository-service'
REPO_VERSION='1.8.0-SNAPSHOT'
REPO_REST_PORT='24610'
REPO_CMD="--spring.config.location=file:./config/services/lockss-repository-service/repo.properties,file:./config/services/lockss-repository-service/repo.properties.opt"
REPO_JARGS="-Dorg.lockss.jmsUri=tcp://lockss-configuration-service:61616"
REPO_BASEDIR=/lockss # TODO: Propagate this to projects
REPO_MAX_WARC_SIZE=1048576 # 1 MB

# PostgreSQL database configuration
PGSQL_VERSION='9.6'
PGSQL_HOSTlockss-metadata-pgsql
PGSQL_PORT='5432'
POSTGRES_USER=LOCKSS
POSTGRES_PASSWORD=goodPassword
POSTGRES_DB=postgres

# Solr container configuration
SOLR_HOST=lockss-solr
SOLR_PORT='8983'
SOLR_CMD='solr-precreate-several.sh demo test-core'

# HDFS container configuration
HDFS_HOST=lockss-hdfs
HDFS_FSMD='9000'
HDFS_DATA='50010'
HDFS_MD='50020'
HDFS_STATUI='50070'
HDFS_DNUI='50075'

# PyWb container settings
PYWB_URL_HOST='localhost'
PYWB_URL_PORT=8080
PYWB_COLLECTION=demo
PYWB_BASEDIR=/webarchive
PYWB_HDFSMNT=/mnt/hdfs
PYWB_WATCHDIR=${PYWB_HDFSMNT}/${REPO_BASEDIR}/sealed

# EDINA indexer settings
LOCKSS_SOLR_HDFSMNT=/lockss-hdfs
LOCKSS_SOLR_WATCHDIR=${LOCKSS_SOLR_HDFSMNT}/${REPO_BASEDIR}/sealed
LOCKSS_SOLR_WATCHDIR_INTERVAL=10 # Seconds
LOCKSS_SOLR_URL=http://${SOLR_HOST}:${SOLR_PORT}/solr/test-core

PROPS_HOST = $(LOCKSS_PROPS_HOST)
PROPS_PORT= $(LOCKSS_PROPS_PORT)
