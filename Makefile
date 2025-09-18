up:
	@cd srcs/ && docker compose up -d

down:
	@cd srcs/ && docker compose down

build:
	@cd srcs/ && docker compose build

logs:
	@cd srcs/ && docker compose logs -f

restart:
	@cd srcs/ && docker compose restart

ps:
	@cd srcs/ && docker compose ps

exec: build up 

dexec: down exec

clear:
	@docker stop $(docker ps -qa) 2>/dev/null || true
	@docker rm $(docker ps -qa) 2>/dev/null || true
	@docker rmi -f $(docker images -qa) 2>/dev/null || true
	@docker volume rm $(docker volume ls -q) 2>/dev/null || true
	@docker network rm $(docker network ls -q) 2>/dev/null || true