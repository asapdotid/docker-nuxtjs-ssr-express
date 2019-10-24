FROM node:${NODE_IMAGE_VER:-10-alpine}

LABEL maintainer Asapdotid <asapdotid@gmail.com>

WORKDIR /app

ENV ASAPDOTID_APP_NAME "nuxtjs-start-development"
ENV PROJECT_DIR ${PROJECT_DIR} \
    BUILD_FLAG ${BUILD_FLAG} \
    NODE_PORT ${NODE_PORT} \
    PM2_NAME ${PM2_NAME} \
    PM2_INSTANCES ${PM2_INSTANCES} \
    PM2_PATH ${PM2_PATH}

# Setup timezone data.
RUN apk --no-cache update && \
    apk --no-cache upgrade && \
    apk --no-cache add tzdata

ENV TZ ${TZ}

ENV HOST 0.0.0.0

EXPOSE ${NODE_PORT}

COPY ./scripts /scripts
RUN find /scripts -type f -iname "*.sh" -exec chmod a+x {} \;

ENTRYPOINT ["/scripts/entrypoint.sh"]
CMD [ "npm", "run", "start" ]
