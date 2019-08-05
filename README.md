# Rust Docker Barebones

Deploying a rust-app in a `FROM: scratch` docker container, using [this blogpost](https://anderspitman.net/blog/rust-docker-barebones/) by Anders Pitman as an example.

This is a hello-world app, so it primarly serves as an example on how to use docker build-phases with rust.

## Why bother?

In the age of containerization, the smallest image:

1. Takes the least amount of time to start; meaning their total runtime can be shorter-lived while remaining performant
2. Require less memory to scale
3. Are more secure compared to larger 'all-in-one' images

So tiny images are interesting to me

## Usage

To build both `rust-builder` and `rust-hello-world` docker images, run

```bash
./dockerfile-build.sh
```

To run the `rust-hello-world` docker image, run

```bash
./dockerfile-run.sh
> Hello, world!
```

The src files can be modified to change the example.

## Changes

I made a few changes to make this work more easily:

- Add `rust-builder:0.1.0-SNAPSHOT` docker image, which combines `rust:1.36.0` with `rustup target install x86_64-unknown-linux-musl` 
to allow compiling for `x86_64-linux` platforms to support `scratch` docker containers. There is likely an existing
image which provides this functionality, but I was not interested in finding it.
- The dockerfile in the root uses `rust-builder:0.1.0-SNAPSHOT` as a base image for the builder job, and copies over
the resulting binary into the `scratch` image

Other size-reducing changes would be cool to try as well, but I haven't had time.

## Strip experimentation

I added `strip` to the docker image as well, to see the image size difference;

- Without `strip`, I had an image size of `2.55MB`
- With `strip`, I had an image size of `231kB`