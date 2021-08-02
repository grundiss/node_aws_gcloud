FROM ubuntu:18.04

RUN apt-get update -qq && apt-get install -qqy \
    apt-transport-https \
    ca-certificates \
    curl \
    lxc \
    iptables

RUN (curl -sL https://deb.nodesource.com/setup_16.x | bash -) \
    && (curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -) \
    && (echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list) \
    && export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" \
    && (echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list) \
    && (curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -)
RUN apt-get update \
    && apt-get install -y nodejs yarn google-cloud-sdk kubectl python python-pip \
    && pip install awscli \
    && (curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash)
