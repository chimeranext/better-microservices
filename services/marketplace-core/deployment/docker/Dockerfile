ARG NODE_VERSION=22-alpine

FROM docker.io/library/node:${NODE_VERSION} AS builder
WORKDIR /app
COPY package.json package-lock.json tsconfig.json tsup.config.ts ./
RUN npm ci --no-audit --no-fund
COPY src ./src
RUN npm run build

FROM docker.io/library/node:${NODE_VERSION} AS runner
WORKDIR /app
ENV NODE_ENV=production
COPY package.json package-lock.json ./
RUN npm ci --omit=dev --no-audit --no-fund && npm cache clean --force
COPY --from=builder /app/dist ./dist
COPY proto ./proto
RUN addgroup -S app && adduser -S app -G app && chown -R app:app /app
USER app
EXPOSE 50051
CMD ["node", "dist/index.js"]
