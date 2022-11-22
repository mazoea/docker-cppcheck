FROM ubuntu:20.04

RUN apt-get update && \
    apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential wget python libpcre3 libpcre3-dev cmake && \
    rm -rf /var/lib/apt/lists/*     

ENV URL=https://github.com/danmar/cppcheck/archive/refs/tags/2.9.tar.gz \
    PACKAGE=cppcheck-2.9 \
    FILE=cppcheck.tar.gz

RUN wget --no-check-certificate -nv $URL -O $FILE && \
    tar xvzf $FILE && \
    rm -f $FILE

RUN cd $PACKAGE && \
    mkdir build && cd build && \
    cmake -DUSE_MATCHCOMPILER=ON -DHAVE_RULES=ON .. && \
    cmake --build .

WORKDIR /opt/src/

RUN cppcheck --version

ENTRYPOINT [ "cppcheck" ]
CMD [ "--version" ]
