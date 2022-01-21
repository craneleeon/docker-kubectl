FROM alpine

ARG HELM_VERSION=2.17.0
ARG KUBECTL_VERSION=1.17.5
ARG KUSTOMIZE_VERSION=v3.8.1
ARG KUBESEAL_VERSION=v0.15.0
ENV BASE_URL="https://get.helm.sh"
ENV TAR_FILE="helm-v${HELM_VERSION}-linux-amd64.tar.gz"
ENV HELM_HOME="/root/.helm"
RUN apk add --update --no-cache curl ca-certificates openssl bash zsh git jq git vim cmatrix procps
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
RUN echo "source ~/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc
RUN curl -sSL https://github.com/shyiko/kubetpl/releases/download/0.9.0/kubetpl-0.9.0-$( \
    bash -c '[[ $OSTYPE == darwin* ]] && echo darwin || echo linux' \
  )-amd64 -o kubetpl && chmod a+x kubetpl && mv kubetpl /usr/local/bin/

# Install helm
RUN mkdir -p $HELM_HOME/plugins
# RUN curl -L https://git.io/get_helm.sh | bash
RUN curl -sL ${BASE_URL}/${TAR_FILE} | tar -xvz && \
    mv linux-amd64/helm /usr/bin/helm && \
    chmod +x /usr/bin/helm && \
    rm -rf linux-amd64

# add helm-diff
RUN helm plugin install https://github.com/databus23/helm-diff && rm -rf /tmp/helm-*

# add helm-unittest
RUN helm plugin install https://github.com/quintush/helm-unittest && rm -rf /tmp/helm-*

# add helm-push
RUN helm plugin install https://github.com/chartmuseum/helm-push && rm -rf /tmp/helm-*

# Install kubectl (same version of aws esk)
RUN curl -sLO https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
    mv kubectl /usr/bin/kubectl && \
    chmod +x /usr/bin/kubectl

# Install kustomize (latest release)
RUN curl -sLO https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2F${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_amd64.tar.gz && \
    tar xvzf kustomize_${KUSTOMIZE_VERSION}_linux_amd64.tar.gz && \
    mv kustomize /usr/bin/kustomize && \
    chmod +x /usr/bin/kustomize

# Install eksctl (latest version)
RUN curl -sL "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp && \
    mv /tmp/eksctl /usr/bin && \
    chmod +x /usr/bin/eksctl

# Install awscli
RUN apk add --update --no-cache python3 && \
    python3 -m ensurepip && \
    pip3 install --upgrade pip && \
    pip3 install awscli && \
    pip3 cache purge

# Install jq
RUN apk add --update --no-cache jq

# Install for envsubst
RUN apk add --update --no-cache gettext

# Install kubeseal
RUN curl -sL https://github.com/bitnami-labs/sealed-secrets/releases/download/${KUBESEAL_VERSION}/kubeseal-linux-amd64 -o kubeseal && \
    mv kubeseal /usr/bin/kubeseal && \
    chmod +x /usr/bin/kubeseal

# Other tools
RUN apk add --update --no-cache fzf nodejs nerd-fonts
COPY .vimrc /root/.vimrc

CMD ["zsh"]

