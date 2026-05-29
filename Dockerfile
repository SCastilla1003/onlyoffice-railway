FROM onlyoffice/documentserver:8.2.0

ENV COMPANY_NAME=onlyoffice
ENV JWT_ENABLED=true

RUN mkdir -p /var/log/onlyoffice/documentserver/adminpanel && \
    mkdir -p /var/log/onlyoffice/documentserver/docservice && \
    mkdir -p /var/log/onlyoffice/documentserver/converter && \
    mkdir -p /var/log/onlyoffice/documentserver/metrics && \
    mkdir -p /var/log/onlyoffice/documentserver-example && \
    mkdir -p /var/www/onlyoffice/Data/certs && \
    find /etc/supervisor -name "*.conf" -exec sed -i 's/COMPANY_NAME/onlyoffice/g' {} \;

EXPOSE 80

ENTRYPOINT ["/app/onlyoffice/run-document-server.sh"]
