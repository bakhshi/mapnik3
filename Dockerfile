FROM debian:stretch

RUN apt-get update -y && \
    apt-get install -y gcc-6 g++-6 clang-3.8 git python zlib1g-dev clang make pkg-config curl
ENV CXX="clang++-3.8"
ENV CC="clang-3.8"

RUN git clone https://github.com/mapnik/mapnik.git
WORKDIR /mapnik
RUN git checkout v3.0.17
RUN git submodule update --init
RUN ./bootstrap.sh
RUN ./configure CUSTOM_CXXFLAGS="-D_GLIBCXX_USE_CXX11_ABI=0" CXX=${CXX} CC=${CC}
RUN make
RUN make install

WORKDIR /
RUN rm -rf /mapnik