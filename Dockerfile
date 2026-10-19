# Minimal Docker image for Movi using Debian base
FROM debian:stable-slim

# install Movi
RUN apt-get update && \
    apt-get install -y --no-install-recommends cmake g++ gcc git make python3 wget zlib1g-dev && \
    wget -qO- "https://github.com/mohsenzakeri/Movi/archive/refs/tags/v2.0.0.tar.gz" | tar -zx && \
    cd Movi-* && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install && \
    cd ../.. && \
    rm -rf Movi-*
