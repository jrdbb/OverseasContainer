FROM ubuntu:xenial
# gcc for cgo
RUN apt update && apt install -y --no-install-recommends \
		g++ \
		gcc \
		libc6-dev \
		make \
		pkg-config \
        wget \
		curl

ENV GOLANG_VERSION 1.13.6
ENV OS linux-amd64
RUN set -eux; \
	\
	url="http://mirrors.ustc.edu.cn/golang/go${GOLANG_VERSION}.${OS}.tar.gz"; \
	wget -O go.tgz "$url"; \
	tar -C /usr/local -xzf go.tgz; \
	rm go.tgz; \
	export PATH="/usr/local/go/bin:$PATH"; \
	go version

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH

# install docker
RUN apt -y install \
    apt-transport-https \
    ca-certificates \
    gnupg-agent \
    software-properties-common \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
    &&  add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
   && apt update \
   && apt -y install docker-ce docker-ce-cli containerd.io;


ENV OPERATOR_VERSION v0.14.0
# download & install operator-framework
RUN wget http://106.15.225.249:7070/operator-sdk-v0.14.0-x86_64-linux-gnu \
    && chmod +x operator-sdk-v0.14.0-x86_64-linux-gnu \
    && mkdir -p /usr/local/bin/ \
    && cp operator-sdk-v0.14.0-x86_64-linux-gnu /usr/local/bin/operator-sdk \
    && rm operator-sdk-v0.14.0-x86_64-linux-gnu;

# download & install sshd for vscode
ENV SSH_PORT 30367
RUN apt install -y openssh-server \
    && sed -ie 's/Port 22/Port 30367/g' /etc/ssh/sshd_config;
# add ubuntu for ssh login
RUN adduser ubuntu && adduser ubuntu root
CMD ["service","ssh","restart"]