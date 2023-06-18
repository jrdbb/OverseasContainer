FROM jupyterhub/k8s-singleuser-sample:2.0.0

USER root

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y --no-install-recommends \
       build-essential \
 && rm -rf /var/lib/apt/lists/*

USER $NB_USER