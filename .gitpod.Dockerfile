FROM gitpod/workspace-mysql

USER gitpod

# Copy required files to /tmp
COPY --chown=gitpod:gitpod .gp/bash/update-composer.sh \
    starter.ini \
    .gp/conf/apache/apache2.conf \
    .gp/conf/nginx/nginx.conf \
    .gp/bash/.bash_aliases \
    .gp/bash/install-project-packages.sh \
    .gp/bash/install-xdebug.sh \
    .gp/bash/update-composer.sh \
    .gp/bash/utils.sh \
    .gp/bash/scaffold-project.sh \
    .gp/snippets/server-functions.sh \
    .gp/snippets/browser-functions.sh \
    .gp/bash/bin/hot-reload.sh \
    /tmp/

# Create log files and move required files to their proper locations
RUN sudo touch /var/log/workspace-image.log \
    && sudo chmod 666 /var/log/workspace-image.log \
    && sudo touch /var/log/workspace-init.log \
    && sudo chmod 666 /var/log/workspace-init.log \
    && sudo touch /var/log/xdebug.log \
    && sudo chmod 666 /var/log/xdebug.log \
    && sudo mv /tmp/apache2.conf /etc/apache2/apache2.conf \
    && sudo mv /tmp/nginx.conf /etc/nginx/nginx.conf \
    && sudo mv /tmp/.bash_aliases /home/gitpod/.bash_aliases \
    && sudo mv /tmp/server-functions.sh /home/gitpod/.bashrc.d/server-functions \
    && sudo mv /tmp/browser-functions.sh /home/gitpod/.bashrc.d/browser-functions \
    && sudo mv /tmp/hot-reload.sh /usr/local/bin/hot-reload

# Install core packages, optional PHP version and any additional packages a user would want
RUN sudo bash -c ". /tmp/install-project-packages.sh" && rm /tmp/install-project-packages.sh

# Compile, install and configure xdebug from source
#RUN sudo bash -c ". /tmp/install-xdebug.sh" && rm /tmp/install-xdebug.sh

COPY --chown=gitpod:gitpod .gp/conf/xdebug/xdebug.ini /tmp
RUN wget http://xdebug.org/files/xdebug-3.1.2.tgz \
   && tar -xvzf xdebug-3.1.2.tgz \
   && cd xdebug-3.1.2 \
   && phpize \
   && ./configure --enable-xdebug \
   && make \
   && sudo cp modules/xdebug.so /usr/lib/php/20190902/xdebug.so \
   && sudo bash -c "echo -e '\nzend_extension = /usr/lib/php/20190902/xdebug.so\n[XDebug]\nxdebug.client_host = 127.0.0.1\nxdebug.client_port = 9009\nxdebug.log = /var/log/xdebug.log\nxdebug.mode = debug\nxdebug.start_with_request = trigger\n' >> /etc/php/7.4/cli/php.ini" \
   && sudo bash -c "echo -e '\nzend_extension = /usr/lib/php/20190902/xdebug.so\n[XDebug]\nxdebug.client_host = 127.0.0.1\nxdebug.client_port = 9009\nxdebug.log = /var/log/xdebug.log\nxdebug.mode = debug\nxdebug.start_with_request = trigger\n' >> /etc/php/7.4/apache2/php.ini" \
   && sudo cp /tmp/xdebug.ini /etc/php/7.4/mods-available/xdebug.ini \
   && sudo ln -s /etc/php/7.4/mods-available/xdebug.ini /etc/php/7.4/fpm/conf.d 


RUN sudo bash -c ". /tmp/update-composer.sh" && rm /tmp/update-composer.sh

# gitpod trick to bypass the docker caching mechanism for all lines below this one
# just increment the value each time you want to bypass the cache system
ENV INVALIDATE_CACHE=192

#COPY --chown=gitpod:gitpod .gp/conf/apache/apache2.conf /etc/apache2/apache2.conf
#COPY --chown=gitpod:gitpod .gp/conf/nginx/nginx.conf /etc/nginx/nginx.conf
#COPY --chown=gitpod:gitpod .gp/bash/.bash_aliases /home/gitpod
#COPY --chown=gitpod:gitpod .gp/bash/utils.sh /tmp
#COPY --chown=gitpod:gitpod starter.ini /tmp
#COPY --chown=gitpod:gitpod .gp/bash/scaffold-project.sh /tmp
RUN sudo bash -c ". /tmp/scaffold-project.sh" && rm /tmp/scaffold-project.sh

# Aliases
#COPY --chown=gitpod:gitpod .gp/snippets/server-functions.sh /tmp
#COPY --chown=gitpod:gitpod .gp/snippets/browser-functions.sh /tmp
#RUN cp /tmp/server-functions.sh ~/.bashrc.d/server-functions \
#    && cp /tmp/browser-functions.sh ~/.bashrc.d/browser-functions

# Customs cli's and user scripts for /usr/local/bin
#COPY --chown=gitpod:gitpod .gp/bash/bin/hot-reload.sh /usr/local/bin
#RUN sudo mv /usr/local/bin/hot-reload.sh /usr/local/bin/hot-reload