FROM alpine:latest

RUN apk update && \
    apk add --no-cache build-base wget python3 pcre-dev cmake && \
    rm -rf /var/cache/apk/*

ENV URL=https://github.com/danmar/cppcheck/archive/refs/tags/2.18.0.tar.gz \
    PACKAGE=cppcheck-2.18.0 \
    FILE=cppcheck.tar.gz

WORKDIR /opt/src/

RUN wget --no-check-certificate -nv $URL -O $FILE && \
    tar xzf $FILE && \
    rm -f $FILE && \
    cd $PACKAGE && \
    mkdir build && cd build && \
    cmake -DUSE_MATCHCOMPILER=ON -DHAVE_RULES=ON .. && \
    cmake --build . && \
    cmake --install . && \
    rm -rf /opt/src/$PACKAGE

RUN adduser -D maz
USER maz
RUN cppcheck --version

ENTRYPOINT [ "cppcheck" ]
CMD [ "--version" ]
