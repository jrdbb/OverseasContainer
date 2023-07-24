FROM mcr.microsoft.com/devcontainers/cpp:0-ubuntu-20.04

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt install -y -V ca-certificates lsb-release wget \
    && wget https://apache.jfrog.io/artifactory/arrow/$(lsb_release --id --short | tr 'A-Z' 'a-z')/apache-arrow-apt-source-latest-$(lsb_release --codename --short).deb \
    && apt install -y -V ./apache-arrow-apt-source-latest-$(lsb_release --codename --short).deb \
    && apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt install -y -V libarrow-dev libparquet-dev protobuf-compiler libprotobuf-dev libssl-dev git git-lfs vim clang-format

# setup clang as compiler
ENV CC  clang
ENV CXX clang++