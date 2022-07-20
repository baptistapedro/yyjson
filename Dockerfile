FROM fuzzers/libfuzzer:12.0

RUN apt-get update
RUN apt install -y build-essential wget git clang cmake  automake autotools-dev  libtool zlib1g zlib1g-dev libexif-dev \
    libjpeg-dev 
RUN git clone --recursive https://github.com/ibireme/yyjson.git
WORKDIR /yyjson
#RUN mkdir ./build
#WORKDIR ./build
RUN cmake  -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DYYJSON_BUILD_FUZZER=ON .
RUN make
RUN make install
ENV LD_LIBRARY_PATH=/usr/local/lib/

ENTRYPOINT []
CMD ["/yyjson/fuzzer"]
