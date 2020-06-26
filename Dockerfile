FROM ubuntu:18.04

RUN DEBIAN_FRONTEND="noninteractive" apt-get update && apt-get -y install tzdata
RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y \
	wget \
	gcc \
	make \
	g++ \
	libffi-dev \
	libglib2.0-0 \
	libglib2.0-dev \
	libgsl-dev \
	libicu-dev \
	liblapack-dev \
	liblzma-dev \
	python \
	python3 \
	python3-pip \
	python3-venv \
	imagemagick \
	libgfortran3 \
	&& rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y sudo 

# CMake
RUN wget https://github.com/Kitware/CMake/releases/download/v3.15.5/cmake-3.15.5-Linux-x86_64.sh \
      -q -O /tmp/cmake-install.sh \
      && chmod u+x /tmp/cmake-install.sh \
      && mkdir /usr/bin/cmake \
      && /tmp/cmake-install.sh --skip-license --prefix=/usr/bin/cmake \
      && rm /tmp/cmake-install.sh
ENV PATH="/usr/bin/cmake/bin:${PATH}"

# LibTIFF
RUN apt-get update && apt-get install -y git-core
RUN mkdir dependencies && cd dependencies \
	&& git clone https://gitlab.com/libtiff/libtiff.git \
	&& cd libtiff \
	&& git checkout v4.1.0 \
	&& cmake .\
	&& make && sudo make install

# Other Protomo dependencies
RUN apt-get update \
	&& apt-get install -y \
	minpack-dev \
	pkg-config \
	plotutils \
	libgtkglext1-dev

COPY ./fftw-2.1.5.tar.gz /dependencies/fftw-2.1.5.tar.gz
RUN cd /dependencies && tar -xvf fftw-2.1.5.tar.gz \
	&& cd fftw-2.1.5 \
	&& ./configure --enable-shared --enable-float --enable-type-prefix \
	&& make && make install


RUN apt-get update && apt-get install -y vim
RUN ln -s /usr/local/lib/libtiff.so.5.5.0 /usr/local/lib/libtiff.so.4

# Protomo
COPY ./protomo-2.4.3.tar.bz2 /protomo/protomo-2.4.3.tar.bz2
RUN cd /usr/local/ && tar -xjf /protomo/protomo-2.4.3.tar.bz2 

# I3
COPY ./i3-0.9.9.tar.bz2 /i3/i3-0.9.9.tar.bz2
RUN cd /usr/local/ && tar -xjf /i3/i3-0.9.9.tar.bz2 
COPY ./i3setup.sh /usr/local/i3-0.9.9/run/i3setup.sh

COPY ./deplibs.tar.bz2 /dependencies/deplibs.tar.bz2
RUN cd /usr/local/ && tar -xjf /dependencies/deplibs.tar.bz2

# Set up ENV
ENV PYTHONPATH=/usr/local/protomo-2.4.3/lib/linux/x86-64 \
	I3ROOT=/usr/local/protomo-2.4.3 \
	I3LEGACY=/usr/local/i3-0.9.9 \
	LD_LIBRARY_PATH=/usr/local/protomo-2.4.3/lib/linux/x86-64:/usr/local/lib/linux/x86-64:/usr/lib/x86_64-linux-gnu:/usr/local/lib:/usr/lib:${LD_LIBRARY_PATH}\
	PATH=.:/usr/local/protomo-2.4.3/bin/linux/x86-64:/usr/local/protomo-2.4.3/bin:/usr/local/i3-0.9.9/bin/linux/x86-64:/usr/local/i3-0.9.9/bin:/usr/bin:/bin:/usr/sbin:${PATH}

RUN useradd -ms /bin/bash -G root I3 && usermod -aG sudo I3
RUN echo 'I3:I3' | chpasswd
USER I3
# Keep image running idle in the background
CMD tail -f /dev/null