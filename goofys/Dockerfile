###############################################################################
# The FUSE driver needs elevated privileges, run Docker with --privileged=true
###############################################################################

FROM alpine:latest

ENV MNT_POINT /var/s3

RUN apk --update add bash fuse libcurl libxml2 libstdc++ libgcc alpine-sdk fuse-dev curl

RUN curl -L -O https://github.com/kahing/goofys/releases/latest/download/goofys && \
    mv goofys /usr/bin && chmod 0755 /usr/bin/goofys && \
    curl -L -O https://github.com/kahing/catfs/releases/download/v0.8.0/catfs && \
    mv catfs /usr/bin && chmod 0755 /usr/bin/catfs

RUN sed -i s/"#user_allow_other"/"user_allow_other"/g /etc/fuse.conf

COPY docker-entrypoint.sh /
RUN ["chmod", "+x", "/docker-entrypoint.sh"]
CMD /docker-entrypoint.sh