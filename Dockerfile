FROM onlyoffice/documentserver:8.2.2

ENV COMPANY_NAME=onlyoffice
ENV JWT_ENABLED=true

RUN mkdir -p /var/log/onlyoffice/documentserver/adminpanel \
    /var/log/onlyoffice/documentserver/docservice \
    /var/log/onlyoffice/documentserver/converter \
    /var/log/onlyoffice/documentserver/metrics \
    /var/log/onlyoffice/documentserver-example \
    /var/www/onlyoffice/Data/certs && \
    for f in /etc/supervisor/conf.d/*.conf; do \
        [ -f "$f" ] && sed -i 's/COMPANY_NAME/onlyoffice/g' "$f"; \
    done || true

EXPOSE 80
