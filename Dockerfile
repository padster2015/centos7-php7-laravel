FROM jdeathe/centos-ssh:centos-6-1.4.2
MAINTAINER Patrick <docker@patrickhenry.co.uk>
RUN yum update -y
RUN yum clean all

RUN yum -y install httpd
RUN yum -y install wget

RUN wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

RUN wget http://rpms.remirepo.net/enterprise/remi-release-7.rpm

RUN rpm -Uvh remi-release-7.rpm epel-release-latest-7.noarch.rpm

RUN yum-config-manager --enable remi-php70

RUN yum -y install composer

# # UTC Timezone & Networking
RUN echo "NETWORKING=yes" > /etc/sysconfig/network

RUN composer global require "laravel/installer"
Volume /var/www/html
ENV PATH="$PATH:~/.composer/vendor/bin"

RUN cd /var/www/html && ls

RUN laravel new blog
#RUN cd blog
#RUN chmod -R gu+w storage && chmod -R guo+w storage

EXPOSE 80 443 22
