#!/bin/sh
set -e

if [ ! -f "$ASSETS_PATH" ]; then
  echo "ERROR: Assets.zip not found at $ASSETS_PATH"
  echo "Please download Assets.zip from the official Hytale documentation."
  exit 1
fi

exec java $JAVA_OPTS \
  -XX:AOTCache=/opt/hytale/HytaleServer.aot \
  -jar /opt/hytale/HytaleServer.jar \
  --assets "$ASSETS_PATH" \
  $HYTALE_OPTS
