setup.all:
	bash ./install/setup.sh

setup.env:
	bash ./install/setup-env.sh

git.wpc:
	bash ./install/gitwpc.sh

sync:
	bash ./install/sync.sh $(filter-out $@,$(MAKECMDGOALS))

clear.all:
	bash ./install/clear.sh

php.connect:
	docker-compose -p neuralwp exec php bash

php.connect.root:
	docker-compose -p neuralwp exec --user=root php bash

# Tests

# tests.prepare [mysqluser] [mysqlpass] [mysqlhost]
tests.prepare:
	. ./.env && \
	docker-compose -p neuralwp exec tests bash -c \
	"cd ./neuralseo && bash tests/bin/install-wp-tests.sh $$DB_TESTS_NAME $$DB_ROOT_USER $$DB_ROOT_PASSWORD $$DB_HOST"

tests.run:
	docker-compose -p neuralwp exec tests bash -c "cd ./neuralseo && vendor/bin/phpunit -c phpunit.xml.dist"

tests.connect:
	docker-compose -p neuralwp exec tests bash