#!/bin/bash
# Fix supervisor configs
for f in /etc/supervisor/conf.d/*.conf; do
    [ -f "$f" ] && sed -i 's/COMPANY_NAME/onlyoffice/g' "$f"
done

# Fix log directories
mkdir -p /var/log/onlyoffice/documentserver/{adminpanel,docservice,converter,metrics}
mkdir -p /var/log/onlyoffice/documentserver-example

# Generate SSL certs if missing
if [ ! -f /var/www/onlyoffice/Data/certs/onlyoffice.key ]; then
    mkdir -p /var/www/onlyoffice/Data/certs
    openssl req -x509 -nodes -days 3650 -newkey rsa:2048 \
        -keyout /var/www/onlyoffice/Data/certs/onlyoffice.key \
        -out /var/www/onlyoffice/Data/certs/onlyoffice.crt \
        -subj "/CN=onlyoffice" 2>/dev/null
    openssl dhparam -out /var/www/onlyoffice/Data/certs/dhparam.pem 2048 2>/dev/null
    chmod 600 /var/www/onlyoffice/Data/certs/onlyoffice.key
    chmod 644 /var/www/onlyoffice/Data/certs/onlyoffice.crt
fi

# Start the original ONLYOFFICE entrypoint
exec /app/onlyoffice/run-document-server.sh
