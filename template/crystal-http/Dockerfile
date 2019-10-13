FROM openfaas/of-watchdog:0.7.2 as watchdog

FROM crystallang/crystal:0.31.1

COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog
RUN chmod +x /usr/bin/fwatchdog

ARG ADDITIONAL_PACKAGE
RUN apt-get update \
  && apt-get install -qy --no-install-recommends ${ADDITIONAL_PACKAGE}

WORKDIR /home/app

COPY . .
COPY function/shard.yml shard.yml
RUN shards install
RUN crystal build main.cr -o handler --release

# Create a non-root user
RUN addgroup --system app \
    && adduser --system --ingroup app app

RUN chown app:app -R /home/app

USER app

WORKDIR /home/app

ENV fprocess="./handler"
EXPOSE 8080

HEALTHCHECK --interval=2s CMD [ -e /tmp/.lock ] || exit 1

ENV upstream_url="http://127.0.0.1:5000"
ENV mode="http"

CMD ["fwatchdog"]
