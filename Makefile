stop-dev:
	docker-compose down

start-dev:
	docker-compose up -d

init-dev:
	docker-compose exec app bin/magento setup:config:set --backend-frontname=admin --db-host=mysql --db-name=magentodb --db-user=myuser --db-password=test123
	docker-compose exec app bin/magento setup:install --elasticsearch-host=elastic --elasticsearch-port=9200
	docker-compose exec app bin/magento module:disable Magento_TwoFactorAuth
	docker-compose exec app bin/magento indexer:reindex catalogsearch_fulltext

clear-cache:
	docker-compose exec app bin/magento cache:clean
	docker-compose exec app bin/magento cache:flush