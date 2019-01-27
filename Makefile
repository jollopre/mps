.PHONY: dev dev_down test_api test_ui test prod_build prod deploy
dev:
	@docker-compose -f docker-compose.yml up -d
dev_down:
	@docker-compose -f docker-compose.yml down
test_api:
	@docker-compose -f docker-compose.test.yml run --rm api
test_ui:
	@docker-compose -f docker-compose.test.yml run --rm ui
test:	test_api test_ui
	@docker-compose -f docker-compose.test.yml down
prod_build:
	@bash ./infra/ui/production/build.sh
prod:	prod_build
	@bash -c "set -a && source ./infra/credentials/apache.env && docker-compose -f docker-compose.production.yml up -d"
prod_down:
	@bash -c "set -a && source ./infra/credentials/apache.env && docker-compose -f docker-compose.production.yml down"
deploy:
	@bash ./infra/deploy/push.sh
