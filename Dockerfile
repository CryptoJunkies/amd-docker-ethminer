FROM library/ubuntu:bionic

LABEL "maintainer"="Chris Diehl <cultclassik@gmail.com>"

ENV GPU_ID=0
ENV AMD_DRIVER="https://storageroot.blob.core.windows.net/mining/amdgpu-pro-20.20-1089974-ubuntu-18.04.tar.xz?sp=r&st=2020-07-24T03:20:09Z&se=2020-08-07T11:20:09Z&spr=https&sv=2019-12-12&sr=b&sig=zQsycEMvhLV%2F%2B6xoWHLxilHl54fIA35cVakbxj4rGIk%3D"
ENV MINER_URL="https://github.com/ethereum-mining/ethminer/releases/download/v0.18.0/ethminer-0.18.0-cuda-9-linux-x86_64.tar.gz"
ENV ETH_ADDR="0xeA2bb2f3B2d8EFCb9ac561347e606fF92aF0C763"

WORKDIR /tmp

RUN apt-get update && apt-get install -y \
    apt-utils \
    libcurl4 \
    wget \
    xz-utils

RUN wget -O amd_driver.tar.xz ${AMD_DRIVER} \
 && unxz amd_driver.tar.xz \
 && mkdir ./driver && cd ./driver \
 && tar -xvf ../amd_driver.tar --strip-components=1 \
 && rm ../*.tar \
 && ./amdgpu-install --opencl=legacy,rocm --headless --no-dkms -y \
 && cd .. \
 && rm -rf ./driver \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir /ethminer \
 && wget ${MINER_URL} \
 && tar -xvf ./*.tar.gz -C /ethminer --strip-components 1 \
 && rm ./*.tar.gz

WORKDIR /ethminer

EXPOSE 3333/tcp

CMD [ "/ethminer/ethminer", "-P", "stratum://${ETH_ADDR}.${HOSTNAME}-${GPU_ID}@us1.ethermine.org:4444", "-P", "stratum://${ETH_ADDR}-${GPU_ID}.${HOSTNAME}@us2.ethermine.org:4444", "-G", "--opencl-device", "${GPU_ID}" ]
