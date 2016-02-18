
FROM buildpack-deps:jessie

MAINTAINER Frederik Zahle <frza@dtu.dk>

ENV SHELL /bin/bash

RUN apt-get update \
 && apt-get install --fix-missing -y -q \
    gfortran \
    git-all \
    curl \
    build-essential \
 && apt-get autoremove -y \
 && apt-get clean -y
RUN wget https://www.open-mpi.org/software/ompi/v1.6/downloads/openmpi-1.6.5.tar.gz \
  && tar -xzf openmpi-1.6.5.tar.gz \
  && cd openmpi-1.6.5 \
  && ./configure --prefix=/usr/local --disable-dlopen \
  && make all install \
  && ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/local/lib
# Install miniconda to /miniconda
RUN curl -LO http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh \
  && bash Miniconda-latest-Linux-x86_64.sh -p /miniconda -b \
  && rm Miniconda-latest-Linux-x86_64.sh \
  && PATH=/miniconda/bin:${PATH}
RUN conda update -y conda \
  && conda create -n py35 python=3.5 anaconda \
  && conda create -n py27 python=2.7 anaconda \
  && source activate py27 \
  && conda install pip numpy scipy nose \
  && source activate py35 \
  && conda install pip numpy scipy nose
