FROM node:22-alpine
LABEL "language"="nodejs"
LABEL "framework"="next.js"

WORKDIR /app

COPY . .

RUN npm install -g pnpm && pnpm install

RUN pnpm run build

EXPOSE 8080

CMD ["pnpm", "run", "start"]

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["node", "--import", "./server/node_modules/tsx/dist/loader.mjs", "server/dist/index.js"]
