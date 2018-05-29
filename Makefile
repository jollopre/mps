build:
	docker-compose -f development.yml run --rm api bash after-start-postgres.sh rails db:setup

api_tests:
	docker-compose -f test.yml run --rm api_test rspec

ui_tests:
	docker-compose -f development.yml run --rm ui npm test

up:
	docker-compose -f development.yml up --remove-orphans -d

down:
	docker-compose -f development.yml down

default:	up

