# Run Docker Stable Diffsuion UI


## Quick start (Ubuntu 22.04|Mint 22.04)

### Install NVIDIA Container Toolkit
```
DIST=ubuntu22.04
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
curl -sLO https://nvidia.github.io/libnvidia-container/${DIST}/libnvidia-container.list
sed -i 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' libnvidia-container.list
sudo mv nvidia-container-toolkit.list /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt-get install -y nvidia-docker2
sudo systemctl restart docker

## At this point, a working setup can be tested by running a base CUDA container:
sudo docker run --rm --gpus all nvidia/cuda:11.6.2-base-ubuntu20.04 nvidia-smi
```

## Create huggingface account
- https://huggingface.co/join

## Download Model
- https://huggingface.co/stabilityai/stable-diffusion-2/blob/main/768-v-ema.ckpt

```
## Create local folder
mkdir -p $HOME/sd-webui/
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git .

## Move 768-v-ema.ckpt to $HOME/sd-webui/models/Stable-diffusion/

## Download Config
cd $HOME/sd-webui/models/Stable-diffusion
curl -sL -o 768-v-ema.yaml https://raw.githubusercontent.com/Stability-AI/stablediffusion/main/configs/stable-diffusion/v2-inference-v.yaml
```

### Build Docker Container
```
cd $HOME/sd-webui/
git clone https://github.com/jniltinho/docker-stable-diffusion.git docker-sd
cd docker-sd
docker build --no-cache -t stable-diffusion-ui .

## Run Docker Container
cd $HOME/sd-webui/
docker run --rm -p 7860:7860 -v $(pwd):/opt/sd-webui --gpus all stable-diffusion-ui
```


## Links
- https://github.com/AUTOMATIC1111/stable-diffusion-webui
- https://github.com/AUTOMATIC1111/stable-diffusion-webui/wiki/Features
- https://github.com/NVIDIA/nvidia-docker
- https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html
- https://www.youtube.com/watch?v=vg8-NSbaWZI
- https://github.com/cmdr2/stable-diffusion-ui/wiki/Writing-prompts#negative-prompts
- https://playgroundai.com/
- https://lexica.art/
