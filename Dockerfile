# --- Stage 1: Build using the latest Rust compiler built on Debian Bookworm ---
FROM rust:slim-bookworm AS builder

# Install system dependencies needed for compiling git repositories and SSL features
RUN apt-get update && apt-get install -y \
    git \
    pkg-config \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Compile sracha directly from the GitHub repository
RUN cargo install --git https://github.com/rnabioco/sracha-rs sracha

# --- Stage 2: Create the clean matching runtime container ---
FROM debian:bookworm-slim

# Install CA certificates for HTTPS AND procps so Nextflow can track metrics via 'ps'
RUN apt-get update && apt-get install -y \
    ca-certificates \
    procps \
    && rm -rf /var/lib/apt/lists/*

# Copy the compiled binary from the builder stage over
COPY --from=builder /usr/local/cargo/bin/sracha /usr/local/bin/sracha

# Set the default command
CMD ["sracha"]