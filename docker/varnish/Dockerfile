From ubuntu:16.04
 
MAINTAINER Linxiaobo linxiaobo1208@gmail.com
 
##update server
 
RUN apt-get update \
##install supervisor and setup supervisord.conf file
&& apt-get install -y supervisor \
&& mkdir -p /var/log/supervisor \
##install varnish
&& apt-get -y install varnish \
&& rm /etc/varnish/default.vcl \
&& rm /etc/default/varnish 
EXPOSE 6082 80
CMD ["/usr/bin/supervisord"]
