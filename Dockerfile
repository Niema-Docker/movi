# Minimal Docker image for Movi using Alpine base
FROM alpine:latest

# install Movi
RUN apk update && \
    apk add --no-cache bash cmake g++ gcc git make python3 zlib-dev && \
    wget -qO- "https://github.com/mohsenzakeri/Movi/archive/refs/tags/v2.0.0.tar.gz" | tar -zx && \
    cd Movi-* && \
    mkdir build && \
    cd build && \
    cmake .. -DCMAKE_POLICY_VERSION_MINIMUM=3.5 && \
    (CMAKE_POLICY_VERSION_MINIMUM=3.5 CFLAGS="-Wno-error=int-conversion" make pfp-thresholds || test -f external_repos/pfp-thresholds-build/_deps/r-index-src/CMakeLists.txt) && \
    sed -i '/^## Add divsuffsort/,/^endif()$/d' external_repos/pfp-thresholds/thirdparty/CMakeLists.txt && \
    sed -i '/^[[:space:]]*## Add divsuffsort/,/^[[:space:]]*endif()$/d' external_repos/pfp-thresholds-build/_deps/r-index-src/CMakeLists.txt && \
    sed -i 's/char \*errmsg = strerror_r(en, buf, Buflen);/strerror_r(en, buf, Buflen); char *errmsg = buf;/' external_repos/pfp-thresholds-build/_deps/bigbwt-src/xerrors.c && \
    CMAKE_POLICY_VERSION_MINIMUM=3.5 CFLAGS="-Wno-error=int-conversion" make && \
    make install && \
    cd ../.. && \
    rm -rf Movi-*
