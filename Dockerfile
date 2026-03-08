FROM public.ecr.aws/docker/library/golang:alpine AS builder

WORKDIR /build

COPY main.go ./

RUN go mod init prod
RUN go mod tidy

RUN go build -o main .

FROM public.ecr.aws/docker/library/alpine

WORKDIR /app

COPY --from=builder /build/main .

CMD ["./main"]