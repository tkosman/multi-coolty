FROM ubuntu:22.04 as go_build
RUN apt-get update && apt-get install -y build-essential golang-go
WORKDIR /src
COPY hello_plugins/hello_go.go .
COPY hello_build/build_go.sh .
RUN chmod +x build_go.sh && ./build_go.sh
