FROM node:lts-alpine3.18

RUN apk update && apk add curl envsubst yq

ARG GH_OWNER
ARG GH_REPO 
ARG GH_TOKEN
ARG WEBHOOK_SECRET
WORKDIR /smee

COPY ./webhook-config-template.yml ./webhook-config-template.yml

RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/community'>>/etc/apk/repositories && \
    apk add github-cli

# Install smee-client and jq
RUN npm install -g smee-client && \
    npm cache clean --force && \
    apk add --no-cache jq

RUN export SMEE_URL=$(curl https://smee.io/new | grep -o 'https://[^ ]*') && \
    envsubst < webhook-config-template.yml > webhook-config.yml && \
    yq eval -o=json webhook-config.yml  > webhook-config.json

RUN gh api repos/${GH_OWNER}/${GH_REPO}/hooks --input webhook-config.json > webhook-details.json

ENTRYPOINT ["sh", "-c", "smee -u $(yq e '.config.url' webhook-config.yml) -t $API_URL"]
# ENTRYPOINT [ "sleep", "infinity" ]