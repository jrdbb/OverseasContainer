# syntax = docker/dockerfile:1.3
# VULN_SCAN_TIME=2024-01-17_12:44:13


# The build stage
# ---------------
# This stage is building Python wheels for use in later stages by using a base
# image that has more pre-requisites to do so, such as a C++ compiler.
#
# NOTE: If the image version is updated, also update it in ci/refreeze and
#       hub's Dockerfile!
#
FROM python:3.11-slim as build-stage

# Build wheels
#
# We set pip's cache directory and expose it across build stages via an
# ephemeral docker cache (--mount=type=cache,target=${PIP_CACHE_DIR}). We use
# the same technique for the directory /tmp/wheels.
#
COPY requirements.txt requirements.txt
ARG PIP_CACHE_DIR=/tmp/pip-cache
RUN --mount=type=cache,target=${PIP_CACHE_DIR} \
    pip install build \
 && pip wheel \
        --wheel-dir=/tmp/wheels \
        -r requirements.txt


# The final stage
# ---------------
#
FROM python:3.11-slim
ENV DEBIAN_FRONTEND=noninteractive

ENV NB_USER=jovyan \
    NB_UID=1000 \
    HOME=/home/jovyan
RUN adduser \
        --disabled-password \
        --gecos "Default user" \
        --uid ${NB_UID} \
        --home ${HOME} \
        --force-badname \
        ${NB_USER}

RUN apt-get update \
 && apt-get upgrade --yes \
 && apt-get install --yes --no-install-recommends \
        ca-certificates \
        libssl-dev \
        dnsutils \
        iputils-ping \
        tini \
        curl \
        zsh \
        clang lld \
        git git-lfs \
        build-essential cmake pkg-config nodejs wget default-jre procps openssh-client vim tmux gfortran libopenblas-dev \
 && rm -rf /var/lib/apt/lists/*

# install wheels built in the build-stage
COPY requirements.txt /tmp/requirements.txt
ARG PIP_CACHE_DIR=/tmp/pip-cache
RUN --mount=type=cache,target=${PIP_CACHE_DIR} \
    --mount=type=cache,from=build-stage,source=/tmp/wheels,target=/tmp/wheels \
    pip install \
        --find-links=/tmp/wheels/ \
        -r /tmp/requirements.txt

RUN wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz && \
    tar -xzf ta-lib-0.4.0-src.tar.gz && \
    cd ta-lib/ && \
    ./configure && \
    make && \
    make install && \
    cd .. && \
    rm -rf ta-lib/ ta-lib-0.4.0-src.tar.gz

RUN curl -fsSL https://code-server.dev/install.sh | sh && \
    rm -rf "${HOME}/.cache"
ENV CODE_WORKINGDIR="${HOME}"

COPY jupyter_codeserver_proxy ./jupyter_codeserver_proxy

# jupyter-server-proxy + code-server proxy install ----
RUN pip install --no-cache-dir jupyter-server-proxy && \
    pip install --no-cache-dir ./jupyter_codeserver_proxy && rm -rf jupyter_codeserver_proxy

WORKDIR ${HOME}
USER ${NB_USER}
ENV PATH=$PATH:$HOME/.local/bin
ENV SHELL=/usr/bin/zsh

EXPOSE 8888
ENTRYPOINT ["tini", "--"]
CMD ["jupyter", "lab"]
