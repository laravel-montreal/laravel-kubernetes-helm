#!/bin/bash

docker-compose up --build -d

APP_NAME="laravel_php_fpm"

docker-compose exec $APP_NAME composer install

docker-compose exec $APP_NAME php artisan key:generate

docker-compose exec $APP_NAME php artisan optimize

docker-compose exec $APP_NAME php artisan migrate --seed --force

docker-compose exec $APP_NAME node -v

docker-compose exec $APP_NAME npm install

docker-compose exec $APP_NAME npm run dev

