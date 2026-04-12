ARG BASE_CONTAINER=condaforge/mambaforge:23.3.1-1
FROM $BASE_CONTAINER

ARG python="3.13.12"

SHELL ["/bin/bash", "-c"]

ENV PATH /opt/conda/bin:$PATH
ENV PYTHON_VERSION=${python}

COPY requirements.txt requirements.txt

RUN export G_SLICE=always-malloc \
    && mamba install -y \
    "mamba>=0.27.0" \
    python=${PYTHON_VERSION} \
    nomkl \
    cmake \
    jupyter-server-proxy \
    cachey \
    streamz \
    && pip install --no-cache-dir -r requirements.txt \
    && mamba clean -tipy \
    && find /opt/conda/ -type f,l -name '*.a' -delete \
    && find /opt/conda/ -type f,l -name '*.pyc' -delete \
    && find /opt/conda/ -type f,l -name '*.js.map' -delete \
    && rm -rf /opt/conda/pkgs \
    && rm -f requirements.txt

COPY prepare.sh /usr/bin/prepare.sh

RUN mkdir /opt/app

ENTRYPOINT ["tini", "-g", "--", "/usr/bin/prepare.sh"]
