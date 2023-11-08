# Copyright IBM Corp. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0

# Build base
FROM ubuntu:focal as build-base

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ARG GRPC_PYTHON_BUILD_SYSTEM_OPENSSL=1

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
      python3 python3-pip python3-venv python3-dev \
      findutils \
      rustc cargo \
      build-essential curl git \
      libcairo2-dev libdbus-1-dev libgirepository1.0-dev libssl-dev
RUN python3 -m pip install --upgrade pip && \
    pip3 install --upgrade setuptools distlib wheel virtualenv && \
    pip3 install Cython
ENV PATH="${PATH}:/usr/local/go/bin"
WORKDIR /build

# Base image virtualenv bootstrapper, context should be plugin src directory
FROM build-base as python-bootstrap

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ARG GRPC_PYTHON_BUILD_SYSTEM_OPENSSL=1

WORKDIR /app-root/
RUN python3 -m venv /opt/venv 
ENV PATH="/opt/venv/bin:${PATH}"
RUN python3 -m pip install --upgrade pip && \
    pip3 install -U setuptools distlib wheel virtualenv
RUN git clone --depth=1 https://github.com/IBM/dap-blueprint.git -b v1.0.0 && \
    pip3 install -e ./dap-blueprint/src/dap_util
COPY  ./requirements.txt /app-root/
RUN pip3 install -r requirements.txt
RUN pip3 install supervisor

# Base image, context should be plugin src directory
FROM ubuntu:focal as runtime

ARG GRPC_PYTHON_BUILD_SYSTEM_OPENSSL=1
ARG BUILD_TIME_SECRET
ARG OLD_BUILD_TIME_SECRET
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ENV BUILD_TIME_SECRET=${BUILD_TIME_SECRET}
ENV OLD_BUILD_TIME_SECRET=${OLD_BUILD_TIME_SECRET}

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y python3 python3-pip python3-venv curl openssh-server gettext-base nginx rsyslog-gnutls && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/run/sshd
ENV PATH="${PATH}"

WORKDIR /app-root
COPY --from=python-bootstrap /opt/venv /opt/venv
COPY --from=python-bootstrap /app-root/dap-blueprint/src/dap_util /app-root/dap-blueprint/src/dap_util

ENV PATH="/opt/venv/bin:${PATH}"
COPY ./src /app-root/src
COPY --from=common-src ./pre_request.py /app-root/src/flask_util
COPY ./entrypoints /app-root/entrypoints
COPY ./nginx /app-root/nginx
COPY ./logging /app-root/logging

ENTRYPOINT ["/app-root/entrypoints/entrypoint.sh"]

