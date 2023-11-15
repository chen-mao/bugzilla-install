FROM hub.xdxct.com/xdxct-docker/ubuntu:bionic-perl

LABEL Author="chen charles <mao.chen@xdxct.com>"

RUN /usr/bin/perl install-module.pl --all
EXPOSE 80

CMD ["apachectl","-D","FOREGROUND"]