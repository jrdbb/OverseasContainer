FROM jupyterhub/k8s-singleuser-sample:3.3.7

USER root

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y --no-install-recommends build-essential nodejs wget default-jre procps openssh-client vim git git-lfs tmux gfortran \
 && rm -rf /var/lib/apt/lists/*

RUN wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz && \
    tar -xzf ta-lib-0.4.0-src.tar.gz && \
    cd ta-lib/ && \
    ./configure && \
    make && \
    make install && \
    cd .. && \
    rm -rf ta-lib/ ta-lib-0.4.0-src.tar.gz

USER $NB_USER
ENV PATH=$PATH:$HOME/.local/bin