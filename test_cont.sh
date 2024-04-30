#!/bin/bash
# export HALO2_PROOF_GPU_EVAL_CACHE=20 # for cuda 4090
export CUDA_VISIBLE_DEVICES=0 # for enable only one device
set -e
set -x

WORKING_DIR=$PWD

# build zkWasm
cd zkWasm
cargo build --release --features continuation,perf
ZKWASM=$WORKING_DIR/zkWasm/target/release/zkwasm-cli
# rm -rf output/*.data

WASM_FILE=$WORKING_DIR/image/op-program-client-test.wasm
PRIVATE_FILE=$WORKING_DIR/image/preimages-test.bin

# Single test
RUST_LOG=info $ZKWASM --params ${WORKING_DIR}/params zkmain setup -k 23

RUST_LOG=info $ZKWASM --params ${WORKING_DIR}/params zkmain prove --output ./output --wasm $WASM_FILE  --private $PRIVATE_FILE:file --file

# $BATCHER --param $pwd/params --output $pwd/output batch -k 22 --challenge sha --info  $pwd/output/$NAME.loadinfo.json --name ${NAME}_agg --commits $CONT_BATCH_INFO --cont