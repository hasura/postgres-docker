ARG OFFICIAL_IMAGE_TAG
FROM postgres:$OFFICIAL_IMAGE_TAG
LABEL maintainer=vamshi@hasura.io

# Install plv8

ARG PLV8_VERSION=2.3.13

RUN PLV8_DEPENDENCIES="wget git g++ python pkg-config libc++-dev libc++abi-dev \
  make postgresql-server-dev-$PG_MAJOR" \
  && apt-get update \
# Ideally, libtinfo5 should have been part of 'PLV8_DEPENDENCIES'
# but some versions of the debian have it installed as an essential
# package (buster, postgres 12, for example does not), which means
# that there would be an error at 'apt-get remove -y ${PLV8_DEPENDENCIES}'
  && apt-get install -y libtinfo5 ${PLV8_DEPENDENCIES} \
  && cd /root \
  && wget "https://github.com/plv8/plv8/archive/v$PLV8_VERSION.tar.gz" \
  && tar -xf "v$PLV8_VERSION.tar.gz" \
  && cd "plv8-$PLV8_VERSION" && make && make install && cd /root \
  && rm -rf "/root/v$PLV8_VERSION.tar.gz" "/root/plv8-$PLV8_VERSION" \
  /root/.gsutil/ /root/.vpython_cipd_cache /root/.vpython-root \
  && apt-get remove --autoremove -y ${PLV8_DEPENDENCIES} \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Install Postgis

ARG POSTGIS_VERSION=3

RUN apt-get update \
  && apt-get install -y "postgresql-$PG_MAJOR-postgis-$POSTGIS_VERSION" \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
