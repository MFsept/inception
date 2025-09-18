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