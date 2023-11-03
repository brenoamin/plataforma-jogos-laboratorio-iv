FROM ubuntu:focal

RUN apt update \
  && apt upgrade -y \
  && apt install -y --no-install-recommends \
    make \
    curl \
    iverilog \
    python3 python-is-python3 python3-venv \
    pip \
    yosys \
  && apt clean all \
  && apt autoremove

