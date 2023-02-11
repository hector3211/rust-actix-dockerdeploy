FROM rust:latest as builder

# RUN USER=root cargo new --bin actix-deploy-docker
# WORKDIR ./actix-docker-deploy
WORKDIR /app
# COPY  /user/coding/actix-docker-deploy .
COPY . .

# RUN apt-get update && apt-get install -y \
#     build-essential \
#     libpq-dev
#

RUN cargo build --release

FROM debian:bullseye-slim

COPY --from=builder /app/target/release/actix-docker-deploy /usr/local/bin/actix-docker-deploy

WORKDIR /app

CMD ["actix-docker-deploy"]
