FROM debian:bullseye

RUN apt update -y && apt install redis-server -y

#Max of 256MB of memory
RUN echo "maxmemory 256mb" >> /etc/redis/redis.conf
#Specifies the policy when max mem has been reached - Allkeys-lru will remove the least recently used keys to free memory
RUN echo "maxmemory-policy allkeys-lru" >> /etc/redis/redis.conf
#Comments the directive which specifies the IP address that the Redis server should listen on. This will listen to all avaiable network directives
RUN sed -i -r "s/bind 127.0.0.1/#bind 127.0.0.0/" /etc/redis/redis.conf

#Start redis-server - Persistent key-value that can store strings, hashes, ...
#Protected mode specifies if the redis server should run on protected mode(In this case is a no.).
#Protected mode is used to accept/refuse connections from clients (not) running on the same host as the server
CMD ["redis-server",  "--protected-mode", "no"]