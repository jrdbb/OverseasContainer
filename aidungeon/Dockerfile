FROM nvidia/cuda:9.0-base

RUN apt -y update && apt -y install python3 git
RUN apt-get -y install build-essential autoconf libtool pkg-config python-opengl python-imaging python-pyrex python-pyside.qtopengl idle-python2.7 qt4-dev-tools qt4-designer libqtgui4 libqtcore4 libqt4-xml libqt4-test libqt4-script libqt4-network libqt4-dbus python-qt4 python-qt4-gl libgle3 python3-dev
WORKDIR /
RUN git clone --branch master https://github.com/AIDungeon/AIDungeon/ --depth 1
WORKDIR /AIDungeon
COPY ./install.sh ./install.sh
RUN chmod 700 install.sh && ./install.sh
RUN ./download_model.sh

ENTRYPOINT ['sh', '-c', 'source ./venv/bin/activate && ./play.py']