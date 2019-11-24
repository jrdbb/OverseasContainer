FROM arm64v8/ubuntu:18.04

# base packages
RUN apt-get update && apt-get install -y \
  file \
  patch \
  rsync \
  util-linux \
  wget \
  bzip2 \
  && apt-get autoclean

# ctng packages
RUN apt-get install -y \
    autoconf \
    gperf  \
    bison  \
    flex  \
    texinfo  \
    help2man  \
    gcc  \
    g++   \
    patch \
	ncurses-dev  \
    python-dev  \
    bzip2  \
    git \
  && apt-get autoclean

#crosstool-ng packages
RUN apt-get install -y \
    automake \
    libtool \
    make \
    unzip \
  && apt-get autoclean
RUN apt-get install -y curl && fname="/c4aarch64_installer-1.0.0-Linux-aarch64.sh" \
  && curl -LO https://github.com/jjhelmus/conda4aarch64/releases/download/1.0.0/$fname \
  && bash -x $fname -bfp /opt/conda \
  && /opt/conda/bin/conda config --set show_channel_urls True \
  && /opt/conda/bin/conda config --set add_pip_as_python_dependency False \
  && /opt/conda/bin/conda clean -ptiy \
  && rm -rf $fname

ENV PATH="/opt/conda/bin:${PATH}"