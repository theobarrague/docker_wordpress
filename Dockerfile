FROM alpine:latest

ARG BUILD_DATE

LABEL org.label-schema.build-date=$BUILD_DATE

RUN apk update \
  && apk upgrade \
  && apk add ruby apache2 apache2-ctl php81 php81-apache2 php81-bcmath php81-curl php81-pecl-imagick php81-intl php81-json php81-mbstring php81-pdo_mysql php81-mysqli php81-xml php81-zip wget \
  && gem install tiller \
  && rm -rf /var/www/html/* /etc/apache2/sites-enabled/* \
  && wget -qO- https://wordpress.org/latest.tar.gz | tar xvz -C /var/www \
  && apk del wget \
  && chown -R apache:apache /var/www/wordpress

COPY /app /

EXPOSE 80

CMD [ "tiller", "-v" ]