# start from the official lightweight redis image
FROM redis:7.4-alpine

# copy the local redis config into the container
COPY redis.conf /usr/local/etc/redis/redis.conf

# start redis with the copied config file
CMD ["redis-server", "/usr/local/etc/redis/redis.conf"]
