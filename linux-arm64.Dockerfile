FROM hotio/base@sha256:fdc426859521d9243b013274378d38db5b9848368742b475d377fc84e2abc237
ENV TAUTULLI_DOCKER="True"
EXPOSE 8181

RUN apk add --no-cache python3 py3-lxml py3-openssl py3-setuptools && \
    apk add --no-cache --virtual=build-dependencies py3-pip make gcc g++ python3-dev && \
    pip3 install --no-cache-dir --upgrade plexapi pycryptodomex && \
    apk del --purge build-dependencies

ARG VERSION
ARG GIT_BRANCH
RUN curl -fsSL "https://github.com/Tautulli/Tautulli/archive/v${VERSION}.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    chmod -R u=rwX,go=rX "${APP_DIR}" && \
    echo "v${VERSION}" > "${APP_DIR}/version.txt" && \
    echo "${GIT_BRANCH}" > "${APP_DIR}/branch.txt"

COPY root/ /
