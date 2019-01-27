FROM httpd:2.4.38

ARG WD=infra/apache/production

WORKDIR /usr/local/apache2

COPY infra/certificates/apache.key conf/server.key

COPY infra/certificates/apache.crt conf/server.crt

COPY ${WD}/httpd-ssl.conf conf/extra/httpd-ssl.conf

COPY ${WD}/httpd.conf conf/httpd.conf

COPY ${WD}/htdocs htdocs
