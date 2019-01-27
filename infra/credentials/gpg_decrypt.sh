#!/bin/bash
# $1 represents the output file after decrypting
# $2 represents the encrypted file
image_name=mps/gpg
docker build -t $image_name ./

docker run --rm -it -v "$HOME/keys/":/root/keys -v "$PWD":/root/files $image_name gpg -o /root/files/$1 -d /root/files/$2
