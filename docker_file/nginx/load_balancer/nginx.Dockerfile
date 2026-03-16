# keep the frontend build stage on a modern node runtime that works well with vite and pnpm
FROM node:22-alpine AS frontend_builder

# keep the frontend workspace root explicit inside the build stage
WORKDIR /frontend

# enable corepack so pnpm can be used without a separate global install step
RUN corepack enable

# copy the frontend package metadata first so dependency installation can use docker caching
COPY frontend/package.json frontend/pnpm-lock.yaml frontend/pnpm-workspace.yaml /frontend/

# install the frontend dependencies exactly as locked in the repository
RUN pnpm install --frozen-lockfile

# copy the full frontend source tree after the dependency layer is ready
COPY frontend /frontend

# build the production frontend assets that nginx will serve directly
RUN pnpm build

# keep the runtime image on the official lightweight nginx distribution
FROM nginx:1.27-alpine

# copy the main nginx configuration with websocket and proxy settings
COPY docker_file/nginx/load_balancer/nginx/nginx.conf /etc/nginx/nginx.conf

# copy the templated site configuration so nginx can inject compose environment values on startup
COPY docker_file/nginx/load_balancer/nginx/templates/studyroom.conf.template /etc/nginx/templates/default.conf.template

# copy the built frontend assets into the default nginx html directory
COPY --from=frontend_builder /frontend/dist /usr/share/nginx/html
