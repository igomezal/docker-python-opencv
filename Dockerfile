FROM python:2.7.12
MAINTAINER Iván Gómez <yvangomezalonso@gmail.com>

RUN apt-get update && \
    apt-get install -y \
    build-essential \
    cmake \
    git \
    pkg-config \
    tk-dev \
    python-tk \
    libjpeg62-turbo-dev \
    libtiff5-dev \
    libjasper-dev \
    libpng12-dev \
    libgtk2.0-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libv4l-dev \
    libatlas-base-dev \
    gfortran \
    && apt-get clean

RUN pip install --no-cache-dir numpy scipy

WORKDIR /

RUN git clone https://github.com/matplotlib/matplotlib.git \
    && cd matplotlib \
    && python setup.py install \
    && cd .. \
    && rm -rf matplotlib

RUN git clone https://github.com/Itseez/opencv.git \
    && cd opencv \
    && git checkout 3.1.0 \
    && cd .. \
    && git clone https://github.com/Itseez/opencv_contrib.git \
    && cd opencv_contrib \
    && git checkout 3.1.0 \
    && cd /opencv \
    && mkdir build \
    && cd build \
    && cmake -D CMAKE_BUILD_TYPE=RELEASE \
        -D CMAKE_INSTALL_PREFIX=$(python -c "import sys; print(sys.prefix)") \
        -D INSTALL_C_EXAMPLES=OFF \
        -D INSTALL_PYTHON_EXAMPLES=OFF \
        -D OPENCV_EXTRA_MODULES_PATH=/opencv_contrib/modules \
        -D BUILD_EXAMPLES=OFF .. \
    && make \
    && make install \
    && ldconfig \
    && make clean \
    && cd / \
    && rm -rf opencv \
    && rm -rf opencv_contrib