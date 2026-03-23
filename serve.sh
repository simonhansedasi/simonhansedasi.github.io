#!/usr/bin/env bash
set -e

PORT=4000
DIR="$(cd "$(dirname "$0")" && pwd)"

cd "$DIR"

echo "==> Building site..."
bundle exec ruby build.rb

echo "==> Starting server at http://localhost:$PORT"

# Open browser after a short delay (so the server is up first)
(sleep 0.8 && xdg-open "http://localhost:$PORT" 2>/dev/null \
  || open "http://localhost:$PORT" 2>/dev/null \
  || true) &

ruby -run -e httpd _site -p $PORT
