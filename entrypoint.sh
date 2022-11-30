#!/bin/sh

mkdir -p dist
clang --target=wasm32-unknown-wasi --sysroot /opt/wasi-libc -nostartfiles -Wl,--import-memory -Wl,--no-entry -Wl,--export-all -o dist/chip.wasm $SOURCES
