#!/usr/bin/env bash

nim c jabba.nim
strip -s jabba
upx --best jabba
