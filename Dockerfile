FROM alpine:3.16
RUN apk update
RUN apk add clang lld git make llvm

RUN git clone https://github.com/CraneStation/wasi-libc.git && \
    cd /wasi-libc && \
    make install INSTALL_DIR=/opt/wasi-libc && \
    rm -rf /wasi-libc

RUN mkdir -p /usr/lib/clang/13.0.1/lib/wasi && \
    wget -O /usr/lib/clang/13.0.1/lib/wasi/libclang_rt.builtins-wasm32.a https://github.com/jedisct1/libclang_rt.builtins-wasm32.a/blob/master/precompiled/libclang_rt.builtins-wasm32.a?raw=true

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
