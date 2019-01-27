#!/bin/bash
# $1 represents the file to encrypt

image_name=mps/gpg
docker build -t $image_name ./

docker run --rm -it -v "$HOME/keys/":/root/keys -v "$PWD":/root/files $image_name gpg -r "Jose Lloret <jollopre@gmail.com>" -e /root/files/$1
