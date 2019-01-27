FROM ubuntu:18.10

RUN apt-get update \
&& apt-get -y install gpg

WORKDIR /usr/local/bin

VOLUME /usr/src/keys

RUN echo "#!/bin/bash" >> entrypoint.sh
RUN echo "set -e" >> entrypoint.sh
RUN echo "gpg --import /root/keys/mps.asc" >> entrypoint.sh
RUN echo "exec \"\$@\"" >> entrypoint.sh

RUN chmod 744 entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

CMD ["bash"]
