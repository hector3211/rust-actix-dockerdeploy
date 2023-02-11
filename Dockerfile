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

ENV DATABASE_URL postgres://rustflix_user:I2B2DL0q6CukjpCV9ikOFG5ouAGIziBP@dpg-cfg7n5pa6gdma8mqlkg0-a.ohio-postgres.render.com/rustflix
RUN cargo build --release

FROM debian:bullseye-slim

COPY --from=builder /app/target/release/actix-docker-deploy /usr/local/bin/actix-docker-deploy

WORKDIR /app

CMD ["actix-docker-deploy"]
