FROM alpine:3.21
RUN apk update
RUN apk add clang lld git make llvm bash curl

RUN git clone https://github.com/CraneStation/wasi-libc.git && \
    cd /wasi-libc && \
    make install INSTALL_DIR=/opt/wasi-libc && \
    rm -rf /wasi-libc

RUN mkdir -p /usr/lib/llvm19/lib/clang/19/lib/wasi && \
    wget -O /usr/lib/llvm19/lib/clang/19/lib/wasi/libclang_rt.builtins-wasm32.a https://github.com/jedisct1/libclang_rt.builtins-wasm32.a/blob/master/precompiled/llvm-19/libclang_rt.builtins-wasm32.a?raw=true

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
