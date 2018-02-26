FROM ndongelo/centos-httpd-php

MAINTAINER aureliondongelo@gmail.com

ADD wordpress.sh /wordpress.sh

RUN chmod 700 /wordpress.sh

EXPOSE 80

CMD ["/wordpress.sh"]

