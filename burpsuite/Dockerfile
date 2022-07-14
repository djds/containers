ARG PARENT="public.ecr.aws/docker/library/ubuntu:jammy"

FROM "${PARENT}"

LABEL maintainer="Davis Schirmer <git@djds.dev>"

ENV DEBIAN_FRONTEND="noninteractive"

RUN apt-get update \
    && apt-get dist-upgrade -y

RUN apt-get install -y \
        libfreetype6 \
        libgbm1 \
        libnss3 \
        libxext6 \
        libxi6 \
        libxrender1 \
        libxtst6 \
        openjfx

RUN --mount=type=bind,src=burpsuite_community_linux_v2022_6_1.sh,target=/tmp/burp.sh,readonly \
    printf "\n\n\n\n" | /usr/bin/bash /tmp/burp.sh

ARG GID=1000
ARG UID=1000
ARG USERNAME="burp"

RUN groupadd -g "${GID}" "${USERNAME}" \
    && useradd -d "/var/lib/${USERNAME}" -g "${GID}" -m -u "${UID}" "${USERNAME}"

USER "${USERNAME}"

ENTRYPOINT ["/usr/local/bin/BurpSuiteCommunity"]
