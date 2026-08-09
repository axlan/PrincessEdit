FROM ubuntu:16.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    libsdl2-dev \
    libsdl2-image-dev \
    libsdl2-ttf-dev \
    && rm -rf /var/lib/apt/lists/*

# Squirrel has no Ubuntu package, so build it from source. The PrincessEdit
# makefile looks for it at the relative path ../SQUIRREL3, which resolves to
# /SQUIRREL3 when the source is mounted at /workspace.
RUN git clone https://github.com/albertodemichelis/squirrel.git /SQUIRREL3 \
    && cd /SQUIRREL3 && make

# cJSON is vendored in the repository (build/PrincessEdit/src/cJSON.c) and
# built alongside the rest of the sources, so no package is installed for it.

WORKDIR /workspace
