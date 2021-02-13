FROM alpine:latest

RUN apk add git uncrustify 

ADD ./uncrustify.cfg /uncrustify-default.cfg
ADD ./entrypoint.sh /entrypoint.sh

ENTRYPOINT "/entrypoint.sh"
