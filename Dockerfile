FROM debian:stable
USER root
RUN apt-get update && \
apt-get -y install apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    watch \
    software-properties-common && \
apt-get update
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list && \
apt-get update && \
apt-get install -y kubectl
RUN curl -sSL https://github.com/shyiko/kubetpl/releases/download/0.9.0/kubetpl-0.9.0-$( \
    bash -c '[[ $OSTYPE == darwin* ]] && echo darwin || echo linux' \
  )-amd64 -o kubetpl && chmod a+x kubetpl && mv kubetpl /usr/local/bin/
RUN curl -L https://git.io/get_helm.sh | bash
