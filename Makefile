# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gude-jes <gude-jes@student.42porto.com>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/05 10:46:37 by gude-jes          #+#    #+#              #
#    Updated: 2025/02/06 09:16:22 by gude-jes         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

DOCKER_COMPOSE=docker compose

DOCKER_COMPOSE_FILE = ./srcs/docker-compose.yml

all : build

build:
	@$(DOCKER_COMPOSE)  -f $(DOCKER_COMPOSE_FILE) up --build -d
kill:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) kill
down:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down
clean:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down -v

status : 
	@docker ps

fclean: clean
	docker system prune -a -f

restart: clean build

.PHONY: kill build down clean restart