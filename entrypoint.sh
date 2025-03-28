#!/usr/bin/env bash

echo "About to use envsubst to mutate env.js dynamically..."
echo ""
echo ""
env
echo ""
echo ""
envsubst </usr/share/nginx/html/env.template.js >/usr/share/nginx/html/env.js
echo ""
echo ""
cat /usr/share/nginx/html/env.js
echo ""
echo ""
exec nginx -g 'daemon off;'
