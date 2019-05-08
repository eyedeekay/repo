FROM alpine
RUN apk update
RUN apk add lighttpd
COPY . /var/www/localhost/htdocs/repo
COPY lighttpd.docker.conf /etc/lighttpd/lighttpd.conf
RUN mkdir -p /run/lighttpd/ && \
    chown -R lighttpd /run/lighttpd
USER lighttpd
CMD lighttpd -f /etc/lighttpd/lighttpd.conf -D
