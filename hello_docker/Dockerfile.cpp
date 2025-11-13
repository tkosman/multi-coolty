FROM ubuntu:22.04 as cpp_build
RUN apt-get update && apt-get install -y build-essential g++
WORKDIR /src
COPY hello_plugins/hello_cpp.cpp .
COPY hello_build/build_cpp.sh .
RUN chmod +x build_cpp.sh && ./build_cpp.sh
