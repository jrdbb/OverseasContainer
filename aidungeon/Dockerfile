FROM nvidia/cuda:9.0-base

RUN apt -y update && apt -y install python3 git build-essential autoconf libtool pkg-config python-opengl python-pyrex python3-dev
WORKDIR /
RUN git clone --branch master https://github.com/AIDungeon/AIDungeon/ --depth 1
WORKDIR /AIDungeon
COPY ./install.sh ./install.sh
RUN chmod 700 install.sh && ./install.sh
RUN ./download_model.sh
ENV PYTHONIOENCODING=utf-8
ENTRYPOINT /bin/bash