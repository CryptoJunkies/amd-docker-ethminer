# amd-docker-ethminer [![Build Status](https://travis-ci.org/CryptoJunkies/amd-docker-ethminer.svg?branch=master)](https://travis-ci.org/CryptoJunkies/amd-docker-ethminer)
[Image on Docker Hub](https://hub.docker.com/r/cryptojunkies/ethminer/)

Dockerfile to build cryptojunkies/ethminer GPU container.

## Pre-requisites

Requires a working installation of Docker CE or EE and Nvidia-Docker2.

## Installation

docker build -t cryptojunkies/ethminer:latest-amd .

## Usage

docker run --runtime=nvidia --device /dev/dri:/dev/dri cryptojunkies/ethminer:latest-amd "-RH -U -S pool_1_url -FS pool_2_url -O eth_address"

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