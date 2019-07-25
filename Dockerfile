# Instalacao oficial do RHEL7
FROM registry.access.redhat.com/rhel7.6
# Configura o locale para UTF-8
ENV LANG=en_US.UTF-8 
ENV LC_ALL=en_US.UTF-8
ARG REDHAT_USERNAME=${REDHAT_USERNAME}
ARG REDHAT_PASSWORD=${REDHAT_PASSWORD}

# Registra e habilita o canal do Software Collection
RUN subscription-manager register --auto-attach --username ${REDHAT_USERNAME} --password ${REDHAT_PASSWORD} --force \
# Habilita o SCL para as ultimas versoes do Nginx, NodeJS e PHP
&& subscription-manager repos --enable=rhel-server-rhscl-7-rpms \
# Instala NodeJS
&& rh-nodejs8-runtime rh-nodejs8-npm rh-nodejs8 rh-nodejs8-nodejs \
# Configura timezone
&& cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime \
#&& printf '#!bin/bash\nexport PATH=/opt/rh/httpd24/root/usr/bin:/opt/rh/httpd24/root/usr/sbin${PATH:+:${PATH}}\nexport MANPATH=/opt/rh/httpd24/root/usr/share/man:${MANPATH}\nexport PKG_CONFIG_PATH=/opt/rh/httpd24/root/usr/lib64/pkgconfig${PKG_CONFIG_PATH:+:${PKG_CONFIG_PATH}}\nexport LIBRARY_PATH=/opt/rh/httpd24/root/usr/lib64${LIBRARY_PATH:+:${LIBRARY_PATH}}\nexport LD_LIBRARY_PATH=/opt/rh/httpd24/root/usr/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}\n/opt/rh/httpd24/root/usr/sbin/httpd -D FOREGROUND' > entrypoint.sh \
#&& chmod +x /etc/profile.d/rh-nodejs8.sh /entrypoint.sh \
&& subscription-manager remove --all \
&& subscription-manager unregister \
&& subscription-manager clean

EXPOSE 80/tcp

CMD [ "bash","/entrypoint.sh" ]
