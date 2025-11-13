FROM ubuntu:22.04 as c_build
RUN apt-get update && apt-get install -y build-essential
WORKDIR /src
COPY hello_plugins/hello_c.c .
COPY hello_build/build_c.sh .
RUN chmod +x build_c.sh && ./build_c.sh
