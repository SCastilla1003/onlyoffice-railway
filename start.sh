#!/bin/bash
# Remove default nginx site to avoid port conflicts
rm -f /etc/nginx/sites-enabled/default

# Start the original ONLYOFFICE entrypoint (no SSL certs - Railway handles SSL termination)
exec /app/ds/run-document-server.sh
