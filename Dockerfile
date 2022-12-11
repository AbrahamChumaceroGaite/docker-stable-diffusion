FROM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive
ENV SHELL /bin/bash


# docker build --no-cache -t stable-diffusion-ui .
# docker run -it --rm -p 7860:7860 -v $(pwd)/models:/opt/sd-webui/models/Stable-diffusion --gpus all stable-diffusion-ui bash

WORKDIR /opt/sd-webui

## Install Base
RUN apt-get update -qq \
    && apt-get install -yqq wget rsync git python3 python3-venv python3-pip libgl1-mesa-glx libglib2.0-0


## Install xformers
RUN pip3 install https://github.com/C43H66N12O12S2/stable-diffusion-webui/releases/download/linux/xformers-0.0.14.dev0-cp310-cp310-linux_x86_64.whl


## Install stable-diffusion-webui
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git sd
    && rsync -av sd/ . && rm -rf sd


EXPOSE 7860
ENTRYPOINT ["python3", "launch.py", "--listen", "--xformers"]
