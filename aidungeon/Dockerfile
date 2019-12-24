FROM nvidia/cuda:9.0-base

RUN apt -y update && apt -y install python3 git
WORKDIR /
RUN git clone --branch master https://github.com/AIDungeon/AIDungeon/ --depth 1
WORKDIR /AIDungeon
COPY ./install.sh ./install.sh
RUN chmod 700 install.sh && ./install.sh
RUN ./download_model.sh

ENTRYPOINT ['sh', '-c', 'source ./venv/bin/activate && ./play.py']