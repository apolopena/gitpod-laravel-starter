FROM gitpod/workspace-mysql

USER gitpod

RUN sudo touch /var/log/workspace-image.log \
    && sudo chmod 666 /var/log/workspace-image.log

RUN sudo touch /var/log/workspace-init.log \
    && sudo chmod 666 /var/log/workspace-init.log

RUN sudo touch /var/log/xdebug.log \
    && sudo chmod 666 /var/log/xdebug.log

RUN sudo apt-get update -q \
    && sudo apt-get install -y php-dev

RUN wget http://xdebug.org/files/xdebug-3.0.2.tgz \
    && tar -xvzf xdebug-3.0.2.tgz \
    && cd xdebug-3.0.2 \
    && phpize \
    && ./configure --enable-xdebug \
    && make \
    && sudo cp modules/xdebug.so /usr/lib/php/20190902/xdebug.so \
    && sudo bash -c "echo -e '\nzend_extension = /usr/lib/php/20190902/xdebug.so\n[XDebug]\nxdebug.client_host = 127.0.0.1\nxdebug.client_port = 9009\nxdebug.log = /var/log/xdebug.log\nxdebug.mode = debug\nxdebug.start_with_request = trigger\n' >> /etc/php/7.4/cli/php.ini" \
    && sudo bash -c "echo -e '\nzend_extension = /usr/lib/php/20190902/xdebug.so\n[XDebug]\nxdebug.client_host = 127.0.0.1\nxdebug.client_port = 9009\nxdebug.log = /var/log/xdebug.log\nxdebug.mode = debug\nxdebug.start_with_request = trigger\n' >> /etc/php/7.4/apache2/php.ini"

COPY --chown=gitpod:gitpod bash/update-composer.sh /tmp
RUN sudo bash -c ". /tmp/update-composer.sh" && rm /tmp/update-composer.sh

# gitpod trick to bypass the docker caching mechanism for all lines below this one
# just increment the value each time you want to bypass the cache system
ENV INVALIDATE_CACHE=121

COPY --chown=gitpod:gitpod bash/utils.sh /tmp
COPY --chown=gitpod:gitpod starter.ini /tmp
COPY --chown=gitpod:gitpod bash/scaffold-project.sh /tmp
RUN sudo bash -c ". /tmp/scaffold-project.sh" && rm /tmp/scaffold-project.sh

# Aliases
COPY --chown=gitpod:gitpod bash/snippets/server-functions /tmp
COPY --chown=gitpod:gitpod bash/snippets/browser-functions /tmp
RUN echo "# BEGIN: custom code (not internal to gitpod)" \
    && cat /tmp/server-functions >> ~/.bashrc \
    && echo -e "\n" | cat /tmp/browser-functions >> ~/.bashrc \ 
    && echo "# END: custom code (not internal to gitpod)"