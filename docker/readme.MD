# Docker Build

## Build Docker Image

1. Run build.sh

## Run Container
Currently, the below command is configured to run with an interactive shell. This should be disabled once pipeline scripts have been finalized.
(Replace test123 with desired password)
1. sudo docker run -e PASSWORD=test123 -it -v /data:/data pbta:latest bash