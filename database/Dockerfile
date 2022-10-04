FROM mysql:5.7
LABEL maintainer="avaliauto@gmail.com"

ENV MYSQL_ROOT_PASSWORD=6974c42cd0c6
ENV MYSQL_DATABASE=avaliauto_banco
COPY ./scripts/ /docker-entrypoint-initdb.d/
