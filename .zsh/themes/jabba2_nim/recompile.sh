#!/usr/bin/env bash

nim c -d:release jabba2.nim
strip -s jabba2
# upx --best jabba
