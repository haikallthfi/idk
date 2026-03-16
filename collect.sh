#!/bin/bash
cd ~/rom

. build/envsetup.sh
export TZ=Asia/Jakarta
export CCACHE_DIR=~/ccache
export CCACHE_EXEC=$(which ccache)
export USE_CCACHE=1
ccache -M 100G -F 0
ccache -o compression=true
ccache -z

$lunch

$make -j8 &
MAKE_PID=$!

for i in {1..95}; do
    if ! kill -0 $MAKE_PID 2>/dev/null; then
        break
    fi
    sleep 1m
done

kill $MAKE_PID 2>/dev/null || true

ccache -s
