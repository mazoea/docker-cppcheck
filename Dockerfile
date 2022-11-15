FROM ubuntu:18.04

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y build-essential wget && \
    rm -rf /var/lib/apt/lists/*     

ENV URL=https://github.com/danmar/cppcheck/archive/refs/tags/2.9.tar.gz \
    PACKAGE=cppcheck-2.9 \
    FILE=cppcheck.tar.gz

RUN wget --no-check-certificate -nv $URL -O $FILE && \
    tar xvzf $FILE && \
    cd $PACKAGE && make CFGDIR=/usr/share/cppcheck/ && make install CFGDIR=/usr/share/cppcheck/ && \
    rm -f $FILE

WORKDIR /opt/src/
ENTRYPOINT [ "cppcheck" ]
CMD [ "--version" ]
