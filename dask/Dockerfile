ARG BASE_CONTAINER=condaforge/mambaforge:23.3.1-1
FROM $BASE_CONTAINER

ARG python="3.11.11"
ARG release="2025.5.1"

SHELL ["/bin/bash", "-c"]

ENV PATH /opt/conda/bin:$PATH
ENV PYTHON_VERSION=${python}
ENV DASK_VERSION=${release}

RUN export G_SLICE=always-malloc \
    && mamba install -y \
    "mamba>=0.27.0" \
    python=${PYTHON_VERSION} \
    nomkl \
    cmake \
    dask=${DASK_VERSION} \
    scikit-learn \
    lightgbm \
    s3fs \
    cachey \
    streamz \
    && mamba clean -tipy \
    && find /opt/conda/ -type f,l -name '*.a' -delete \
    && find /opt/conda/ -type f,l -name '*.pyc' -delete \
    && find /opt/conda/ -type f,l -name '*.js.map' -delete \
    && find /opt/conda/lib/python*/site-packages/bokeh/server/static -type f,l -name '*.js' -not -name '*.min.js' -delete \
    && rm -rf /opt/conda/pkgs

COPY prepare.sh /usr/bin/prepare.sh

RUN mkdir /opt/app

ENTRYPOINT ["tini", "-g", "--", "/usr/bin/prepare.sh"]
