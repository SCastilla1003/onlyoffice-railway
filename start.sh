#!/bin/bash
# Generate SSL certs if missing
if [ ! -f /var/www/onlyoffice/Data/certs/onlyoffice.key ]; then
    mkdir -p /var/www/onlyoffice/Data/certs
    openssl req -x509 -nodes -days 3650 -newkey rsa:2048 \
        -keyout /var/www/onlyoffice/Data/certs/onlyoffice.key \
        -out /var/www/onlyoffice/Data/certs/onlyoffice.crt \
        -subj "/CN=onlyoffice" 2>/dev/null
    chmod 600 /var/www/onlyoffice/Data/certs/onlyoffice.key
    chmod 644 /var/www/onlyoffice/Data/certs/onlyoffice.crt
    echo "SSL certs generated"
fi

# Run original entrypoint in background
/app/ds/run-document-server.sh &
MAIN_PID=$!

# Wait for setup and retry nginx
sleep 20
echo "Retrying nginx..."
nginx -t 2>&1 && service nginx restart 2>&1 || true

wait $MAIN_PID
