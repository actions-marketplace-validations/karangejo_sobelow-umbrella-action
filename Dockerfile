FROM elixir:1.11.2
ARG MIX_HOME=/.mix
ENV MIX_HOME=$MIX_HOME
ARG MIX_ENV=test
ENV MIX_ENV=$MIX_ENV

RUN mix local.rebar --force
RUN mix local.hex --force

COPY sobelow.sh /sobelow.sh

ENV DIR=GITHUB_WORKSPACE

WORKDIR ${DIR}

ENTRYPOINT ["/sobelow.sh"]

