FROM --platform=$BUILDPLATFORM curlimages/curl:7.81.0 AS jar
ARG BUILDPLATFORM
ARG VERSION
WORKDIR /tmp
RUN curl -f -k -O https://colossus.kruemel.home/nexus/repository/astro/ch/guengel/astro/cli/astro-cli/${VERSION}/astro-cli-${VERSION}-jar-with-dependencies.jar

FROM --platform=$BUILDPLATFORM ghcr.io/graalvm/graalvm-ce:21.3 AS executable
ARG BUILDPLATFORM
ARG VERSION
WORKDIR /tmp
RUN gu install native-image
COPY --from=jar /tmp/astro-cli-${VERSION}-jar-with-dependencies.jar astro-cli.jar
RUN native-image --verbose -jar astro-cli.jar

FROM --platform=$BUILDPLATFORM debian:11.2-slim AS runnable
ARG BUILDPLATFORM
ARG USERID=10000
RUN apt install libstdc++6 &&\
    useradd -U -m -u $USERID astro &&\
    install -d -o $USERID -g $USERID /data &&\
    rm -rf /var/lib/apt/*

COPY --from=executable /tmp/astro-cli /home/astro

WORKDIR /home/astro
USER $USERID
ENV XDG_DATA_HOME=/data
ENV XDG_CONFIG_HOME=/data
VOLUME /data
ENTRYPOINT ["/home/astro/astro-cli"]

