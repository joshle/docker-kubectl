FROM alpine:3.7

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV KUBE_VERSION v1.9.3
ENV HOME=/config

RUN apk upgrade --update \
    && apk add --no-cache bash tzdata curl ca-certificates \
    && curl https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl --output /usr/local/bin/kubectl --silent \
    && chmod +x /usr/local/bin/kubectl \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && adduser kubectl -Du 2342 -h /config \
    && rm -rf /var/cache/apk/*

USER kubectl

CMD ["/bin/bash"]
