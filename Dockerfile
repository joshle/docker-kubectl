FROM alpine:3.7

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV KUBE_VERSION v1.9.7
ENV HELM_VERSION v2.8.2
ENV HOME=/config

RUN apk upgrade --update \
    && apk add --no-cache bash tzdata curl ca-certificates \
    && wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && wget -q http://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && adduser kubectl -Du 2342 -h /config \
    && rm -rf /var/cache/apk/*

USER kubectl

CMD bash
