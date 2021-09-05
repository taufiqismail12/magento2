# Readme
This repo is used to learn magento 2 

### Stack
- Magento 2.4.3
- PHP 7.4 
- Mariadb 10.14
- Elasticsearch 7.9.3
- Nginx 1.18
- Redis (TBD)

### Prerequisites
1. PHP 7.4 with extension must be enabled:
   - opcache
   - xml
   - bcmath
   - calendar
   - ctype
   - curl
   - gd
   - intl
   - json
   - mbstring
   - mysqli
   - pdo_mysql
   - phar
   - xsl
   - zip 
2. composer 
3. php-cs-fixer
4. docker
5. gnu make (for running Makefile)  
6. Magento account (you can read in [here](https://devdocs.magento.com/guides/v2.3/install-gde/prereq/connect-auth.html))


## Environment 
Before start, you need to install the library
```
make init-setup
```
or, if you want to using sample data
```
make init-sample-data-setup
```
when installing the library, you will be ask to input username and password for magento account  
insert username with `public-key` and password with `private-key`. 


### Dev environment
The following step for installation for dev environment  
1. ``make init-dev``(for initialize setup environment)  
2. ``make start-app``
3. open new terminal and run ``make install-magento``


### setup php-cs-fixer in vs code
install globally php-cs-fixer:
```make install-php-cs-fixer```

open vscode, and install `php cs fixer`
open vscode setting and add this:
```
 "php-cs-fixer.config": ".php_cs.dist",
 "php-cs-fixer.onsave": true,
 "[php]": {
      "editor.defaultFormatter": "junstyle.php-cs-fixer"
  },
```