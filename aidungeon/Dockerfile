FROM nvidia/cuda:9.0-base

RUN apt -y update && apt -y install python3
WORKDIR /
RUN git clone --branch master https://github.com/AIDungeon/AIDungeon/ --depth 1
WORKDIR /AIDungeon
RUN ./install.sh
RUN ./download_model.sh

ENTRYPOINT ['sh', '-c', 'source ./venv/bin/activate && ./play.py']