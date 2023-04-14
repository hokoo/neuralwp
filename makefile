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

tests.run:
	docker-compose -p neuralwp exec php bash -c "cd ./neuralseo && composer phpunit"