#!/bin/bash

#由远程脚本调用，以便将本地的镜像文件LOAD到docker仓库

cd /root/temp/test/

find . -name "*.tar" | xargs -n 1 docker load --input

