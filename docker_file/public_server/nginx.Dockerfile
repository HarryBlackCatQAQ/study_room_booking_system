# keep the edge proxy on the lightweight official nginx runtime
FROM nginx:1.27-alpine

# copy the main nginx configuration into the image
COPY docker_file/public_server/nginx/nginx.conf /etc/nginx/nginx.conf

# copy the templated site configuration for docker env substitution
COPY docker_file/public_server/nginx/templates/studyroom.conf.template /etc/nginx/templates/default.conf.template
