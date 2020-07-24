FROM library/ubuntu:focul

LABEL "maintainer"="Chris Diehl <cultclassik@gmail.com>"

ENV AMD_DRIVER="https://storageroot.blob.core.windows.net/mining/amdgpu-pro-20.20-1089974-ubuntu-20.04.tar.xz?sp=r&st=2020-07-24T01:00:26Z&se=2020-07-31T09:00:26Z&spr=https&sv=2019-12-12&sr=b&sig=mkkR34VnuD2RSUejN%2B%2F69Ra3jh%2F9FvGFccxV%2FdL9feQ%3D"
ENV MINER_URL="https://github.com/ethereum-mining/ethminer/releases/download/v0.18.0/ethminer-0.18.0-cuda-9-linux-x86_64.tar.gz"
ENV ETH_ADDR="0xeA2bb2f3B2d8EFCb9ac561347e606fF92aF0C763"

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
CMD [ "-P", "stratum://${ETH_ADDR}.${HOSTNAME}@us1.ethermine.org:4444", "-P", "stratum://${ETH_ADDR}.${HOSTNAME}@us2.ethermine.org:4444", "-HWMON", "1", "-R", "-U", "--farm-recheck", "2000" ]
