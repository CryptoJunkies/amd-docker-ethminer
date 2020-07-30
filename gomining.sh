#!/bin/bash
/ethminer/ethminer \
 -G --HWMON 1 --report-hr \
 --opencl-device ${GPU_ID} \
 -P stratum://${ETH_ADDR}.${HOSTNAME}-${GPU_ID}@us1.ethermine.org:4444 \
 -P stratum://${ETH_ADDR}.${HOSTNAME}-${GPU_ID}@us2.ethermine.org:4444
