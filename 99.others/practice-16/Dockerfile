FROM debian:stable

RUN apt-get update \
	&& apt-get install -y nginx

COPY index.html /var/www/html/

EXPOSE 10080
CMD ["nginx", "-g", "daemon off;"]
