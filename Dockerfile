# syntax=docker/dockerfile:1
#   docker build -t opensim .

FROM mcr.microsoft.com/dotnet/runtime:8.0

ARG DOWNLOAD_URL=https://
ARG DIR_EXTRACT=""

RUN apt-get update \
  #&& apt-get upgrade -y \
  && apt-get install -y --no-install-recommends \
    apt-utils libgdiplus libsqlite3-dev wget unzip screen nano \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir -p /opt/opensim \
  && mkdir -p /tmp/opensim-tmp \
  && wget -O /tmp/opensim.zip --user-agent="Mozilla/5.0" ${DOWNLOAD_URL} \
  && unzip -q -o /tmp/opensim.zip ${DIR_EXTRACT} -d /tmp/opensim-tmp \
  && mv /tmp/opensim-tmp/* /opt/opensim/
  #&& rm -rf /tmp/opensim-tmp

WORKDIR /opt/opensim/bin
CMD [ "screen", "-DmS", "opensim", "dotnet", "OpenSim.dll" ]