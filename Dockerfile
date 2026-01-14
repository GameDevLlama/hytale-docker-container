FROM eclipse-temurin:25-ubi10-minimal

WORKDIR /opt/hytale

COPY HytaleServer.jar .
COPY HytaleServer.aot .

RUN mkdir -p /data

WORKDIR /data

ENV ASSETS_PATH="/assets/Assets.zip" \
    JAVA_OPTS="" \
    HYTALE_OPTS=""

EXPOSE 5520/udp

CMD ["sh", "-c", "java $JAVA_OPTS -XX:AOTCache=/opt/hytale/HytaleServer.aot -jar /opt/hytale/HytaleServer.jar --assets \"$ASSETS_PATH\" $HYTALE_OPTS"]
