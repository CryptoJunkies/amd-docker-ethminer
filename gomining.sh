#!/bin/bash
/ethminer/ethminer \
  -P stratum://${ETH_ADDR}.${HOSTNAME}-${GPU_ID}@us1.ethermine.org:4444 \
  -P stratum://${ETH_ADDR}.${HOSTNAME}-${GPU_ID}@us2.ethermine.org:4444 \
  --opencl-device ${GPU_ID} \
  -G --HWMON --report-hr