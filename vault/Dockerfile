# base image
FROM alpine:3.11

# set vault version
ENV VAULT_VERSION 1.4.0

# set envconsul version
ENV ENVCONSUL_VERSION 0.9.3

# create a new directory
RUN mkdir /vault 

# download dependencies
RUN apk --no-cache add \
      bash \
      ca-certificates wget curl python py-pip python-dev mysql-dev musl-dev gcc

# download and set up vault
RUN wget --quiet --output-document=/tmp/vault.zip https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip && \
    unzip /tmp/vault.zip -d /vault && \
    rm -f /tmp/vault.zip && \
    chmod +x /vault

# download and set up envconsul
RUN wget --quiet --output-document=/tmp/envconsul.zip https://releases.hashicorp.com/envconsul/${ENVCONSUL_VERSION}/envconsul_${ENVCONSUL_VERSION}_linux_amd64.zip && \
    unzip /tmp/envconsul.zip -d /usr/local/bin && \
    rm -f /tmp/envconsul.zip && \
    chmod +x /usr/local/bin/envconsul

# install python packages
RUN pip install requests==2.23.0 \
	mysqlclient==1.4.6

# update PATH
ENV PATH="PATH=$PATH:$PWD/vault"

# add the config file
COPY ./config/vault-config.hcl /vault/config/vault-config.hcl

# add the scripts
RUN mkdir /scripts
COPY ./bin/*.* /scripts/
RUN chmod +x /scripts/*.sh

# expose port 8200
EXPOSE 8200

# run vault
ENTRYPOINT ["vault"]