up:
	@cd srcs/ && docker compose up -d

down:
	@cd srcs/ && docker compose down

build:
	@cd srcs/ && docker compose build

nbuild:
	@cd srcs/ && docker compose build --no-cache
logs:
	@cd srcs/ && docker compose logs -f

restart:
	@cd srcs/ && docker compose restart

ps:
	@cd srcs/ && docker compose ps

exec: build up 

reset: nbuild up

dexec: down exec

clear:
	@cd srcs && docker stop $$(docker ps -qa) 2>/dev/null || true
	@cd srcs && docker rm $$(docker ps -qa) 2>/dev/null || true
	@cd srcs && docker rmi -f $$(docker images -qa) 2>/dev/null || true
	@cd srcs && docker volume rm $$(docker volume ls -q) 2>/dev/null || true
	@cd srcs && docker network rm $$(docker network ls -q) 2>/dev/null || true