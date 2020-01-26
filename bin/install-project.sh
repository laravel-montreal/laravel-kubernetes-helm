#!/bin/bash

rm -rf docker/laravel

# Clone your existing project
git clone https://github.com/laravel-montreal/Laravel-Appointments.git laravel
cp laravel/.env.example laravel/.env
mv laravel docker/laravel

# Create image
docker-compose up --build -d

# Perform series of action in container
APP_NAME="laravel_php_fpm"

docker-compose exec $APP_NAME composer install

docker-compose exec $APP_NAME php artisan key:generate

docker-compose exec $APP_NAME php artisan optimize

docker-compose exec $APP_NAME php artisan migrate --seed --force

docker-compose exec $APP_NAME node -v

docker-compose exec $APP_NAME npm install

docker-compose exec $APP_NAME npm run dev

