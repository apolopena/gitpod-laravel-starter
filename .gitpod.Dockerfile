FROM gitpod/workspace-mysql:latest

USER gitpod

RUN sudo touch /var/log/workspace-image.log \
    && sudo chmod 666 /var/log/workspace-image.log \
    && sudo touch /var/log/workspace-init.log \
    && sudo chmod 666 /var/log/workspace-init.log \
    && sudo touch /var/log/xdebug.log \
    && sudo chmod 666 /var/log/xdebug.log

RUN echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections \
    && sudo apt-get update -q \
    && sudo apt-get -y install php8.0-fpm rsync grc shellcheck apt-transport-https ca-certificates \
    && sudo apt-get clean \
    && sudo update-ca-certificates
    
COPY --chown=gitpod:gitpod .gp/conf/xdebug/xdebug.ini /tmp
RUN wget http://xdebug.org/files/xdebug-3.1.1.tgz \
    && tar -xvzf xdebug-3.1.1.tgz \
    && cd xdebug-3.1.1 \
    && phpize \
    && ./configure --enable-xdebug \
    && make \
    && sudo cp modules/xdebug.so /usr/lib/php/20200930/xdebug.so \
    && sudo bash -c "echo -e '\nzend_extension = /usr/lib/php/20200930/xdebug.so\n[XDebug]\nxdebug.client_host = 127.0.0.1\nxdebug.client_port = 9009\nxdebug.log = /var/log/xdebug.log\nxdebug.mode = debug\nxdebug.start_with_request = trigger\n' >> /etc/php/8.0/cli/conf.d/20-xdebug.ini" \
    && sudo bash -c "echo -e '\nzend_extension = /usr/lib/php/20200930/xdebug.so\n[XDebug]\nxdebug.client_host = 127.0.0.1\nxdebug.client_port = 9009\nxdebug.log = /var/log/xdebug.log\nxdebug.mode = debug\nxdebug.start_with_request = trigger\n' >> /etc/php/8.0/apache2/conf.d/20-xdebug.ini" \
    && sudo cp /tmp/xdebug.ini /etc/php/8.0/mods-available/20-xdebug.ini \
    && sudo ln -s /etc/php/8.0/mods-available/20-xdebug.ini /etc/php/8.0/fpm/conf.d

COPY --chown=gitpod:gitpod .gp/bash/update-composer.sh /tmp
RUN sudo bash -c ". /tmp/update-composer.sh" && rm /tmp/update-composer.sh

# gitpod trick to bypass the docker caching mechanism for all lines below this one
# just increment the value each time you want to bypass the cache system
ENV INVALIDATE_CACHE=184

COPY --chown=gitpod:gitpod .gp/conf/apache/apache2.conf /etc/apache2/apache2.conf
COPY --chown=gitpod:gitpod .gp/conf/nginx/nginx.conf /etc/nginx/nginx.conf
COPY --chown=gitpod:gitpod .gp/bash/.bash_aliases /home/gitpod
COPY --chown=gitpod:gitpod .gp/bash/utils.sh /tmp
COPY --chown=gitpod:gitpod starter.ini /tmp
COPY --chown=gitpod:gitpod .gp/bash/scaffold-project.sh /tmp
RUN sudo bash -c ". /tmp/scaffold-project.sh" && rm /tmp/scaffold-project.sh

# Aliases
COPY --chown=gitpod:gitpod .gp/snippets/server-functions.sh /tmp
COPY --chown=gitpod:gitpod .gp/snippets/browser-functions.sh /tmp
RUN cp /tmp/server-functions.sh ~/.bashrc.d/server-functions \
    && cp /tmp/browser-functions.sh ~/.bashrc.d/browser-functions

# Customs cli's and user scripts for /usr/local/bin
COPY --chown=gitpod:gitpod .gp/bash/bin/hot-reload.sh /usr/local/bin
RUN sudo mv /usr/local/bin/hot-reload.sh /usr/local/bin/hot-reload

# Add global composer bin folder to $PATH
ENV PATH="$PATH:$HOME/.config/composer/vendor/bin:$GITPOD_REPO_ROOT/vendor/bin"
