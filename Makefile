#########################################################################
## Make file
## @author: Taufiq ismail <taufiqismail04@gmail.com>
## @since: 2021/08/28
#########################################################################

DOCKER_COMPOSE_APP=docker-compose -f docker-compose.yml -p magento
DOCKER_COMPOSE_DATA=docker-compose -f docker-compose.data.yml -p magento
DOCKER_EXEC_MAGENTO=docker-compose -f docker-compose.yml -p magento exec app bin/magento

define setup_env
	@echo " - setup env"
	$(eval include .env)
	$(eval export sed 's/=.*//' .env)
endef

#### Basic Command

data-service-start:
	@$(DOCKER_COMPOSE_DATA) up -d

data-service-stop:
	@$(DOCKER_COMPOSE_DATA) stop

data-service-remove:
	@$(DOCKER_COMPOSE_DATA) down

start-app:
	@make data-service-start
	@echo "Wait for 30 seconds for database and es up and running properly"
	@sleep 30
	@$(DOCKER_COMPOSE_APP) up

stop-app:
	@make data-service-stop
	@$(DOCKER_COMPOSE_APP) stop

down-app:
	@$(DOCKER_COMPOSE_APP) down --remove-orphans

clear-cache:
	@$(DOCKER_EXEC_MAGENTO) cache:clean
	@$(DOCKER_EXEC_MAGENTO) cache:flush

init-setup-env:
	cd src/
	@composer install

### Magento Instalation 

install-magento:
	$(call setup_env,local)
	@echo "Setup magento start"
	@$(DOCKER_EXEC_MAGENTO) setup:config:set --backend-frontname=${BACKEND_FRONTNAME} --db-host=${MYSQL_HOST} --db-name=${MYSQL_DATABASE} --db-user=${MYSQL_USER} --db-password=${MYSQL_PASSWORD}
	@$(DOCKER_EXEC_MAGENTO) setup:install --elasticsearch-host=${ELASTICSEARCH_HOST} --elasticsearch-port=${ELASTICSEARCH_PORT}
	@$(DOCKER_EXEC_MAGENTO) admin:user:create --admin-user='${ADMIN_USER}' --admin-password='${ADMIN_PASSWORD}' --admin-email='${ADMIN_EMAIL}' --admin-firstname='${ADMIN_FIRSTNAME}' --admin-lastname='${ADMIN_LASTNAME}'
	@$(DOCKER_EXEC_MAGENTO) module:disable Magento_TwoFactorAuth
	@$(DOCKER_EXEC_MAGENTO) indexer:reindex catalogsearch_fulltext
	@make clear-cache
	@echo "Finish.."

### Environment Initialization

remove-env:
	@echo "Remove current environment"
	rm -rf ./src/app/etc/env.php
	rm -rf .env

init-dev:
	@make remove-env
	@cp ./etc/env/.env.local .env


####