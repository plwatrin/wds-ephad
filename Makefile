.PHONY: init up down logs status cli network-install network-sites backup-db validate
init:
	@test -f .env || cp .env.example .env
	@mkdir -p backups reference wp-content/uploads
	@echo "Edit .env: database passwords, WP_BASE_URL and local admin credentials."
up:
	docker compose up -d db wordpress
down:
	docker compose down
logs:
	docker compose logs -f wordpress db
status:
	docker compose ps
cli:
	docker compose --profile tools run --rm wpcli $(filter-out $@,$(MAKECMDGOALS))
network-install:
	@bash scripts/network-install.sh
network-sites:
	@docker compose --profile tools run --rm wpcli site list --fields=blog_id,url,registered
backup-db:
	@mkdir -p backups
	@docker compose exec -T db sh -c 'exec mariadb-dump -u"$$MARIADB_USER" -p"$$MARIADB_PASSWORD" "$$MARIADB_DATABASE"' > "backups/wordpress-$$(date +%Y%m%d-%H%M%S).sql"
validate:
	docker compose config --quiet
	bash -n scripts/*.sh
%:
	@:
