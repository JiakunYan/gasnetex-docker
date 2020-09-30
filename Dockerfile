FROM ubuntu:18.04
MAINTAINER Jiakun Yan (jiakuny3@illinois.edu)
WORKDIR /root

ADD docker-clean /usr/bin/docker-clean
RUN chmod a+rx /usr/bin/docker-clean && docker-clean

RUN apt-get update -y && apt-get dist-upgrade -y &&\
    apt-get install tmux vim htop sudo wget libnuma-dev git autoconf libtool -y &&\
    apt-get install build-essential man-db manpages manpages-dev gcc-8 g++-8 -y &&\
    docker-clean

RUN wget "http://www.mpich.org/static/downloads/3.3.1/mpich-3.3.1.tar.gz"&&\
	tar -xf mpich-3.3.1.tar.gz &&\
	mkdir mpich-3.3.1-build&&\
	mv mpich-3.3.1 mpich-3.3.1-source&&\
	mkdir mpich-3.3.1&&\
	cd mpich-3.3.1-build&&\
	../mpich-3.3.1-source/configure --disable-fortran --enable-g=debug --enable-error-checking=all --enable-error-messages=all&&\
	make -j&&\
	make install&&\
	cd ..&&\
	docker-clean

ARG GASNETEX_VERSION=GASNet-2020.3.0

RUN wget "https://gasnet.lbl.gov/EX/${GASNETEX_VERSION}.tar.gz"&&\
	tar -xf ${GASNETEX_VERSION}.tar.gz&&\
	mkdir ${GASNETEX_VERSION}-build&&\
	mv ${GASNETEX_VERSION} ${GASNETEX_VERSION}-source&&\
	mkdir ${GASNETEX_VERSION}&&\
	cd ${GASNETEX_VERSION}-build&&\
	../${GASNETEX_VERSION}-source/configure --enable-debug&&\
	make -j&&\
	make install&&\
	docker-clean