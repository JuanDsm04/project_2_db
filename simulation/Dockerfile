FROM debian:bookworm

RUN apt-get update
RUN apt-get install -y g++ libpqxx-dev

WORKDIR /app
COPY ./main.cpp .

RUN g++ -o main main.cpp -lpqxx -lpq

CMD ["./main"]
