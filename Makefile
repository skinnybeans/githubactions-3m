# cleanDocker remove all containers/network created by Compose
cleanDocker:
	docker-compose down --remove-orphans

# clean cleans the current directory
clean: cleanDocker
	rm -f .env


.PHONY: test
test: .env
	printenv | grep -i tf_input || true
	docker-compose run --rm alpine sh -c 'printenv'

.env:
	touch .env
	docker-compose run --rm envvars validate
	docker-compose run --rm envvars envfile --overwrite
	docker-compose run --rm envvars ensure
.PHONY: .env