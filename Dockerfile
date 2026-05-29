FROM onlyoffice/documentserver:8.2.2

ENV COMPANY_NAME=onlyoffice
ENV JWT_ENABLED=true

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 80

ENTRYPOINT ["/bin/bash", "/start.sh"]
