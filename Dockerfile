FROM tjnii_base/debian

RUN apt-get install -y nginx
RUN useradd -d /tmp -s /bin/false nginx

# Install the nginx config
ADD files/etc.nginx /etc/nginx

# Install the website
ADD files/www-root /srv/www-root

EXPOSE 80 443
CMD ["/usr/sbin/nginx", "-c", "/etc/nginx/nginx.conf"]
