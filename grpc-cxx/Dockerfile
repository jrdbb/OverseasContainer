FROM debian:stretch

RUN apt-get update && apt-get install -y \
  build-essential autoconf git pkg-config \
  automake libtool curl make g++ unzip cmake \
  && apt-get clean

# install protobuf first, then grpc
ENV GRPC_RELEASE_TAG v1.29.1
RUN git clone -b ${GRPC_RELEASE_TAG} https://github.com/grpc/grpc /var/local/git/grpc && \
		cd /var/local/git/grpc && \
    git submodule update --init 
    
RUN cd /var/local/git/grpc && \
    mkdir -p cmake/build && \
    cmake -DgRPC_INSTALL=ON \
        -DgRPC_BUILD_TESTS=OFF \
        -DCMAKE_INSTALL_PREFIX=/var/local/grpc \
        ../.. && \
    make -j && \
    make install