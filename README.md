# Rust Docker Barebones

Deploying a rust-app in a `FROM: scratch` docker container, using [this blogpost](https://anderspitman.net/blog/rust-docker-barebones/) by Anders Pitman as an example.

This is a hello-world app, so it primarly serves as an example on how to use docker build-phases with rust.

## Why bother?

In the age of containerization, the smallest image:

1. Takes the least amount of time to start; meaning the total runtime of the container can be shorter-lived while still remaining performant
2. Requires less memory to scale
3. Is more secure, having a smaller surface-area for attackers to exploit

I find the prospect of tiny images for webservices interesting. I find rust an interesting language as well.
This project was created to lay a bit of ground-work for eventually exploring rust-based microservices.

## Usage

To build both `rust-builder` and `rust-hello-world` docker images:

```bash
./dockerfile-build.sh
```

To run the `rust-hello-world` docker image:

```bash
./dockerfile-run.sh
> Hello, world!
```

The src files can be modified to change the example.

## Changes

I made a few changes over the original example presented by Anders Pitman:

- Add `rust-builder:0.1.0-SNAPSHOT` docker image, which combines `rust:1.36.0` with `rustup target install x86_64-unknown-linux-musl` 
to allow compiling for `x86_64-linux` platforms to support `scratch` docker containers. There is likely an existing
image which provides this functionality, but I was not interested in finding it. I needed this functionality in order
to build this project for my `scratch` based docker container on a Mac.
- The Dockerfile in the root uses `rust-builder:0.1.0-SNAPSHOT` as a base image for the builder job, and copies over
the resulting binary into the `scratch` image

## Strip experimentation

I added the `strip` command to the docker image to see the image size difference;

- Without `strip`, I had an image size of `2.55MB`
- With `strip`, I had an image size of `231kB`

Other size-reducing changes would be cool to try as well, but I haven't had time.