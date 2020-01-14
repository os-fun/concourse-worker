FROM opensuse/leap:15.2 AS deps

RUN zypper in -y wget tar gzip openssh
RUN wget https://github.com/concourse/concourse/releases/download/v5.8.0/concourse-5.8.0-linux-amd64.tgz
RUN mkdir /concourse
RUN tar zxf concourse-*.tgz -C /concourse

FROM opensuse/leap:15.2
COPY --from=deps /concourse/* /usr/local/
RUN mkdir /concourse-keys
#COPY --from=deps /concourse/concourse/bin/concourse /usr/local/bin/
ENV CONCOURSE_WORK_DIR=/opt/concourse/worker

RUN mkdir -p $CONCOURSE_WORK_DIR
ADD run.sh /run.sh
ENTRYPOINT ["/run.sh"]
