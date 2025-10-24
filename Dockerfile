# syntax=docker/dockerfile:1
#   docker build -t opensim .

FROM mcr.microsoft.com/dotnet/runtime:8.0

ARG DOWNLOAD_URL=http://opensimulator.org/dist/opensim-0.9.3.0.zip
ARG DIR_COPY=opensim/*

RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y --no-install-recommends \
    apt-utils libgdiplus libsqlite3-dev wget unzip screen nano \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  #
  && wget -O /tmp/opensim.zip --user-agent="Mozilla/5.0" ${DOWNLOAD_URL} \
  && unzip -q -o /tmp/opensim.zip -d /tmp/opensim-tmp \
  && mkdir /opt/opensim  \
  && mv /tmp/opensim-tmp/${DIR_COPY} /opt/opensim/

WORKDIR /opt/opensim/bin
CMD [ "screen", "-DmS", "opensim", "dotnet", "OpenSim.dll" ]