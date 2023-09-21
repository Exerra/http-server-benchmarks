# HTTP server benchmarks

![thumbnail](https://share.exerra.xyz/SnNKTVP.png)

Quick and simple HTTP benchmarks I cooked up for Bun, Node and Rust comparisons.

Just run `chmod +x benchmark.sh && ./benchmark.sh` (port 3000 must be free). All the results get saved in the `results` directory.

## Prerequisites

- Node LTS
- Latest Rust version
- Latest [Bun](https://bun.sh) version
- Yarn (`npm install -g yarn`)
- [Bombardier](https://github.com/codesenberg/bombardier)
  - [golang](https://go.dev) needs to be installed

## Warnings

1. Port 3000 must be free.

2. Do not stop the script yourself, as it probably will leave a web server running in the background. If it happens to you, run `sudo lsof -i -P | grep LISTEN | grep :3000` to find the active server.

## List of benchmarks

### Bun

- Bun with Bun.serve()
- Bun with Elysia
- Bun with Node HTTP
- Bun with Express

## Node

- Node with HTTP
- Node with Express

## Rust

- Rust with Actix
