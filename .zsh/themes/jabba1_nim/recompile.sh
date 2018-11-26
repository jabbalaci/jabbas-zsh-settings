#!/usr/bin/env bash

nim c -d:release jabba1.nim
strip -s jabba1
# upx --best jabba
