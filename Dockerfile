FROM ubuntu:20.04
ENV LD_LIBRARY_PATH=/lib:/usr/lib
ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    apt update && \
    apt install -y  ca-certificates \
                    bash \
                    jq \
                    wget \                    
                    dnsutils \
                    git \
                    curl \
                    openssh-client \
                    build-essential \
                    libpng-dev \
                    python2.7 \
                    zip \
                    ansible \
                    net-tools \
                    nginx && \
                    rm -rf /var/cache/apt && rm -rf /var/lib/apt/lists/*

RUN wget https://releases.hashicorp.com/terraform/0.14.0/terraform_0.14.0_linux_amd64.zip && \
    unzip terraform_0.14.0_linux_amd64.zip && \
    rm terraform_0.14.0_linux_amd64.zip && \
    mv terraform /bin && \
    mkdir -p /root/.terraform.d/plugins 
    
RUN curl -LO https://download.docker.com/linux/static/stable/x86_64/docker-19.03.13.tgz &&  \
    tar xvf docker-19.03.13.tgz &&  \
    mv docker/docker /bin/docker && \
    rm -rf docker-19.03.13.tgz docker 
    
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.19.4/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /bin/kubectl
    
RUN curl -sL https://get.helm.sh/helm-v3.4.1-linux-amd64.tar.gz | tar xzvf - && \
    chmod +x linux-amd64/helm && \
    mv linux-amd64/helm /bin/ &&  \
    rm -rf linux-amd64

ENTRYPOINT ["/usr/sbin/nginx" "-g" "daemon off;"]
