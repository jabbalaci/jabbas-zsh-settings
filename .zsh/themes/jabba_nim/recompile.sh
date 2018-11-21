#!/usr/bin/env bash

nim c -d:release jabba.nim
strip -s jabba
# upx --best jabba
