FROM elixir:1.14-alpine
RUN apk add gcc g++ zlib-dev make python3-dev py3-pip jpeg-dev && pip3 install wheel && pip3 install sarif-tools
COPY sobelow.sh /sobelow.sh

ENV DIR=GITHUB_WORKSPACE

WORKDIR ${DIR}

ENTRYPOINT ["/sobelow.sh"]