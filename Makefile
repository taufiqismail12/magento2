#########################################################################
## Make file
## @author: Taufiq ismail <taufiqismail04@gmail.com>
## @since: 2021/08/28
#########################################################################

DOCKER_COMPOSE=docker-compose
DOCKER_EXEC_MAGENTO=docker-compose exec app bin/magento

define setup_env
	@echo " - setup env"
	$(eval include .env)
	$(eval export sed 's/=.*//' .env)
endef

#### Basic Command
start-app:
	@$(DOCKER_COMPOSE) up -d
	@echo "Wait for 30 seconds for database and es up and running properly"
	@sleep 30

stop-app:
	@$(DOCKER_COMPOSE) stop

clear-cache:
	@$(DOCKER_EXEC_MAGENTO) cache:clean
	@$(DOCKER_EXEC_MAGENTO) cache:flush


### Magento Instalation for dev environment

init-dev:
	rm -rf app/etc/env.php
	rm -rf .env
	@cp .env.local .env
	@make install-magento

install-magento:
	$(call setup_env,local)
	@echo "Starting App......"
	@make start-app
	@echo "Setup magento start"
	@$(DOCKER_EXEC_MAGENTO) setup:config:set --backend-frontname=${BACKEND_FRONTNAME} --db-host=${MYSQL_HOST} --db-name=${MYSQL_DATABASE} --db-user=${MYSQL_USER} --db-password=${MYSQL_PASSWORD}
	@$(DOCKER_EXEC_MAGENTO) setup:install --elasticsearch-host=${ELASTICSEARCH_HOST} --elasticsearch-port=${ELASTICSEARCH_PORT}
	@$(DOCKER_EXEC_MAGENTO) admin:user:create --admin-user='${ADMIN_USER}' --admin-password='${ADMIN_PASSWORD}' --admin-email='${ADMIN_EMAIL}' --admin-firstname='${ADMIN_FIRSTNAME}' --admin-lastname='${ADMIN_LASTNAME}'
	@$(DOCKER_EXEC_MAGENTO) module:disable Magento_TwoFactorAuth
	@$(DOCKER_EXEC_MAGENTO) indexer:reindex catalogsearch_fulltext
	@make clear-cache
	@echo "Setup magento Finish"
