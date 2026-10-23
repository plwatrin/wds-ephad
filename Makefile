.PHONY: init up down logs status cli import-db urls backup-db reset
init:
	@test -f .env || cp .env.example .env
	@mkdir -p backups reference wp-content/uploads
	@echo "Edit .env and change the two database passwords before starting."
up:
	docker compose up -d db wordpress
down:
	docker compose down
logs:
	docker compose logs -f wordpress db
status:
	docker compose ps
cli:
	docker compose --profile tools run --rm wpcli wp $(filter-out $@,$(MAKECMDGOALS))
import-db:
	@test -n "$(FILE)" || (echo "Usage: make import-db FILE=backups/prieure.sql" && exit 1)
	@./scripts/import-db.sh "$(FILE)"
urls:
	@./scripts/localize-urls.sh
backup-db:
	@mkdir -p backups
	@docker compose exec -T db sh -c 'exec mariadb-dump -u"$$MARIADB_USER" -p"$$MARIADB_PASSWORD" "$$MARIADB_DATABASE"' > "backups/wordpress-$$(date +%Y%m%d-%H%M%S).sql"
reset:
	@echo "To erase local WordPress and database volumes: docker compose down -v"
%:
	@:
