FROM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive
ENV SHELL /bin/bash


# docker build --no-cache -t stable-diffusion-ui .
# mkdir -l $HOME/sd-webui && cd $HOME/sd-webui && git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git . 
# cd $HOME/sd-webui && docker run --rm -p 7860:7860 -v $(pwd):/home/webui --gpus all stable-diffusion-ui
# http://127.0.0.1:7860/


## Install Base
RUN apt-get update -qq && apt-get install -yqq wget curl git python3 python3-venv python3-pip libgl1-mesa-glx libglib2.0-0 \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/archive/*.deb

## Install xformers
RUN pip3 install https://github.com/C43H66N12O12S2/stable-diffusion-webui/releases/download/linux/xformers-0.0.14.dev0-cp310-cp310-linux_x86_64.whl

RUN useradd -m webui -u 1000 && chown -R webui /home/webui && groupmod -n webui webui

USER webui
WORKDIR /home/webui

EXPOSE 7860
ENTRYPOINT ["python3", "launch.py", "--listen", "--xformers"]
