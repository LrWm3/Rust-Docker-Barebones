FROM rust-builder:0.1.0-SNAPSHOT as builder

COPY src src
COPY Cargo.lock Cargo.lock
COPY Cargo.toml Cargo.toml
RUN cargo build --release --target=x86_64-unknown-linux-musl
RUN strip target/x86_64-unknown-linux-musl/release/rust_docker_barebones

FROM scratch

COPY --from=builder target/x86_64-unknown-linux-musl/release/rust_docker_barebones /rust_docker_barebones

ENTRYPOINT ["/rust_docker_barebones"]

