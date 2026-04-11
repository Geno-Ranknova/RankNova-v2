FROM node:22-alpine
LABEL "language"="nodejs"
LABEL "framework"="next.js"

WORKDIR /app

# Install system dependencies including curl and bash for Claude CLI installation
RUN apk add --no-cache curl bash

# Install Claude CLI
RUN curl -fsSL https://install.anthropic.com | bash

COPY . .

RUN npm install -g pnpm && pnpm install

RUN pnpm run build

EXPOSE 3100

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["node", "--import", "./server/node_modules/tsx/dist/loader.mjs", "server/dist/index.js"]
