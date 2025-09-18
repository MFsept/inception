#!/bin/bash

set -e

until nc -z wordpress 9000; do
  echo "Waiting for WordPress PHP-FPM to be ready..."
  sleep 2
done

echo "WordPress PHP-FPM is ready!"
nginx -g "daemon off;"