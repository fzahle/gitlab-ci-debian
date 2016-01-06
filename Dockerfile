# Run with the DockerSpawner in JupyterHub

FROM  debian:jessie

MAINTAINER Frederik Zahle <frza@dtu.dk>

ENV SHELL /bin/bash

RUN apt-get update \
 && apt-get install -y -q \
    gfortran \
    openmpi-bin \
    libopenmpi-dev \
    git-all \
    python-pip \
    python-dev \
    build-essential \
    python-numpy \
    python-scipy \
 && apt-get autoremove -y \
 && apt-get clean -y

