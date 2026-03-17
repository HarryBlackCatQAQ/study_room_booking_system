# keep the frontend build stage on a modern node runtime for vite and pnpm
FROM node:22-alpine AS builder

# keep the frontend workspace root explicit
WORKDIR /frontend

# enable corepack so pnpm can be used directly
RUN corepack enable

# copy the package metadata first for better docker cache reuse
COPY frontend/package.json frontend/pnpm-lock.yaml frontend/pnpm-workspace.yaml /frontend/

# install the frontend dependencies exactly as locked
RUN pnpm install --frozen-lockfile

# copy the full frontend source tree after dependency resolution is cached
COPY frontend /frontend

# allow the public api base url to be injected at build time when needed
ARG VITE_API_BASE_URL

# write a production env file only when the public api base url is set
RUN if [ -n "${VITE_API_BASE_URL:-}" ]; then printf 'VITE_API_BASE_URL=%s\n' "${VITE_API_BASE_URL}" > /frontend/.env.production; fi

# build the production frontend assets
RUN pnpm build

# keep the runtime image on a lightweight nginx distribution
FROM nginx:1.27-alpine

# copy the spa nginx site config into the runtime image
COPY docker_file/public_server/frontend/default.conf /etc/nginx/conf.d/default.conf

# copy the built frontend assets into the default html directory
COPY --from=builder /frontend/dist /usr/share/nginx/html
