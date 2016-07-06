FROM ubuntu:16.04

RUN apt-get update -y && apt-get install -y wget

WORKDIR /tmp
RUN wget https://dist.ipfs.io/go-ipfs/v0.4.2/go-ipfs_v0.4.2_linux-amd64.tar.gz 
RUN tar xvfz go-ipfs_v0.4.2_linux-amd64.tar.gz
RUN mv go-ipfs/ipfs /usr/local/bin/ipfs

COPY ./start_ipfs /usr/local/bin/start_ipfs
RUN chmod 755 /usr/local/bin/start_ipfs 
RUN rm -rf /tmp/*

ENV IPFS_PATH /data/ipfs

RUN mkdir -p $IPFS_PATH && useradd -d $IPFS_PATH -u 1000 -U ipfs && chown ipfs:ipfs $IPFS_PATH && chmod 755 $IPFS_PATH

USER ipfs
VOLUME $IPFS_PATH

EXPOSE 4001
EXPOSE 4002/udp
EXPOSE 5001
EXPOSE 8080

ENTRYPOINT ["/usr/local/bin/start_ipfs"]
