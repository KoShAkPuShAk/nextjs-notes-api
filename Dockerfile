FROM node:24-alpine AS builder

WORKDIR /app

COPY package.json pnpm-lock.yaml ./

RUN corepack enable && pnpm install --no-frozen-lockfile

COPY nest-cli.json tsconfig.build.json tsconfig.json ./
COPY src ./src

RUN pnpm run build && pnpm prune --prod --ignore-scripts

FROM node:24-alpine AS runner

WORKDIR /app

USER node

COPY --from=builder --chown=node:node /app/dist ./dist
COPY --from=builder --chown=node:node /app/node_modules ./node_modules
COPY --from=builder --chown=node:node /app/package.json ./package.json

EXPOSE 3000

CMD ["node", "dist/main.js"]