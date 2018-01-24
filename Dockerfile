FROM library/ubuntu:xenial

LABEL "maintainer"="Chris Diehl <cultclassik@gmail.com>"

# NVidia required
ENV NVIDIA_VISIBLE_DEVICES=0

ENV AMD_DRIVER="https://s3-us-west-1.amazonaws.com/mastermine/minebox/amdgpu-pro-17.50-511655.tar.xz"
ENV MINER_URL="https://github.com/ethereum-mining/ethminer/releases/download/v0.13.0/ethminer-0.13.0-Linux.tar.gz"

WORKDIR /tmp

RUN apt-get update && apt-get install -y \
    libcurl3 \
    wget \
    xz-utils \
 && wget ${AMD_DRIVER} \
 && unxz amdgpu-pro-17.50-511655.tar.xz \
 && tar -xvf *.tar \
 && rm *.tar \
 && ./amdgpu-pro-17.50-511655/amdgpu-pro-install --opencl=legacy,rocm --headless -y \
 && rm -rf ./* \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir /ethminer \
 && wget ${MINER_URL} \
 && tar -xvf ./*.tar.gz -C /ethminer --strip-components 1 \
 && rm ./*.tar.gz

WORKDIR /ethminer

EXPOSE 3333/tcp

ENTRYPOINT [ "/ethminer/ethminer" ]
CMD [ "-RH", "-U", "-S", "pool_1_url", "-FS", "pool_2_url", "-O", "eth_address" ]
