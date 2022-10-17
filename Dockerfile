FROM elixir:1.14-alpine
COPY sobelow.sh /sobelow.sh
COPY merge_sarif.exs /merge_sarif.exs

ENV DIR=GITHUB_WORKSPACE

WORKDIR ${DIR}

ENTRYPOINT ["/sobelow.sh"]