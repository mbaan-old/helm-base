FROM ubuntu:latest

ARG VCS_REF
ARG BUILD_DATE

LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.name="helm-base" \
      org.label-schema.url="https://hub.docker.com/r/mrgrumble/helm-base/" \
      org.label-schema.vcs-url="https://github.com/mbaan/helm-base" \
      org.label-schema.build-date=$BUILD_DATE

ENV KUBE_LATEST_VERSION="v1.9.4"
ENV HELM_VERSION="v2.8.2"
ENV FILENAME="helm-${HELM_VERSION}-linux-amd64.tar.gz"

COPY vaultenv /usr/local/bin/vaultenv

RUN apt update \
    && apt -y install curl \
    && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && curl -L http://storage.googleapis.com/kubernetes-helm/${FILENAME} -o /tmp/${FILENAME} \
    && tar -zxvf /tmp/${FILENAME} -C /tmp \
    && mv /tmp/linux-amd64/helm /bin/helm \
    && rm -rf /tmp/* \
    && chmod +x /usr/local/bin/vaultenv


WORKDIR /config

CMD bash
