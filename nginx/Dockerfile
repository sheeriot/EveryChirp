FROM nginx:stable-alpine

RUN apk add certbot certbot-nginx

COPY resources /root/resources/

# rid the original nginx config
RUN mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.bak

# provide the startup script to setup nginx
RUN cp /root/resources/setup_webhost.sh /docker-entrypoint.d/setup_webhost.sh
RUN chmod +x /docker-entrypoint.d/setup_webhost.sh
