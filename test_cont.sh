#!/bin/bash
export HALO2_PROOF_GPU_EVAL_CACHE=20 # for cuda 4090
# export CUDA_VISIBLE_DEVICES=0 # for enable only one device
set -e
set -x

PWD=$PWD

# build zkWasm
cd zkWasm
cargo build --release --features continuation,cuda
ZKWASM=$PWD/zkWasm/target/release/delphinus-cli
# rm -rf output/*.data

WASM_FILE=$PWD/image/op-program-client-test.wasm
PRIVATE_FILE=$PWD/image/preimages-test.bin

# Single test
RUST_LOG=info $ZKWASM --params ${PWD}/params zkmain setup -k 23

RUST_LOG=info $ZKWASM --params ${PWD}/params zkmain prove --output ./output --wasm $WASM_FILE  --private $PRIVATE_FILE:file

# $BATCHER --param $pwd/params --output $pwd/output batch -k 22 --challenge sha --info  $pwd/output/$NAME.loadinfo.json --name ${NAME}_agg --commits $CONT_BATCH_INFO --cont