# Prove op-geth with smoke test 
System requirements: ubuntu 22.04, cuda 12.2, one Nvidia 4090 GPU, CPU with 32 cores, 528 Gb RAM
```
git submodule update --init
bash test_cont.sh
```

## Notes
- About 2.2B WASM instructions for smoke test
- 1055 segments are generated for zkWasm's continuation proving
    - (generating witness costs ~6 minites)
    - proving 1 segment cost ~17 second, total proving time is ~6 hours
