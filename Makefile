# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gude-jes <gude-jes@student.42porto.com>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/05 10:46:37 by gude-jes          #+#    #+#              #
#    Updated: 2025/02/05 10:47:35 by gude-jes         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

DOCKER_COMPOSE=docker compose

DOCKER_COMPOSE_FILE = ./srcs/docker-compose.yml

.PHONY: kill build down clean restart

build:
	mkdir -p /home/gude-jes/data/mysql
	mkdir -p /home/gude-jes/data/wordpress
	@$(DOCKER_COMPOSE)  -f $(DOCKER_COMPOSE_FILE) up --build -d
kill:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) kill
down:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down
clean:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down -v

fclean: clean
	rm -r /home/gude-jes/data/mysql
	rm -r /home/gude-jes/data/wordpress
	docker system prune -a -f

restart: clean build