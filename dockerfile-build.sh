#!/bin/bash

## Build rust-builder
cd rust-builder
./dockerfile-build.sh
cd ..

## Build hello-world
docker build . -t rust-hello-world:0.1.0-SNAPSHOT