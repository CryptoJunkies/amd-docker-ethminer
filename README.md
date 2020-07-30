[Image on Docker Hub](https://hub.docker.com/r/cryptojunkies/ethminer/)

Dockerfile to build cryptojunkies/ethminer GPU container.

## Pre-requisites

Requires a working installation of Docker CE or EE

## Installation

docker build -t cryptojunkies/ethminer:latest-amd .

## Usage

docker run --hostname=${HOSTNAME} --env GPU_ID='0' --env ETH_ADDR='0xeA2bb2f3B2d8EFCb9ac561347e606fF92aF0C763' --device /dev/dri:/dev/dri cryptojunkies/ethminer:latest-amd \

## Ethminer example for testing outside container
export ETH_ADDR='0xeA2bb2f3B2d8EFCb9ac561347e606fF92aF0C763' &&\
export  GPU_ID='0' &&\
/minebox/miners/ethminer/ethminer \
  -P stratum://${ETH_ADDR}.${HOSTNAME}-${GPU_ID}@us1.ethermine.org:4444 \
  -P stratum://${ETH_ADDR}.${HOSTNAME}-${GPU_ID}@us2.ethermine.org:4444 \
  --opencl-device ${GPU_ID} \
  -G --HWMON 1 --report-hr

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## History

Ethminer 0.13.0, initial build.

## Credits

TODO: Write credits

## License

TODO: Write license