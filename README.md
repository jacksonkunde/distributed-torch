# distributed-torch
Distributed training in PyTorch

### Docker
1. Install [Docker](https://www.docker.com/) on each machine.
2. `docker pull pytorch/pytorch:latest`

### Setup
1. Record each node's IP address
> You can do this on mac with `ipconfig getifaddr en0`
> Or on linux with `hostname -I`
2. RUN `docker build -t train .`
3. RUN `docker run --env-file .env train`

docker run --env-file .env --name training train_image
docker exec -it /bin/bash training

docker run --network host --env-file .env --name training training_image



References:
- [Lambda Labs](https://lambdalabs.com/blog/multi-node-pytorch-distributed-training-guide?srsltid=AfmBOorQtJWjtI-vMokYZopdRCfEaNACU6lX9A5F79MVFhQ_5QJ5pF0f)
- [Lei Mao](https://leimao.github.io/blog/PyTorch-Distributed-Training/)
