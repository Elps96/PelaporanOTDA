web: bash -c "composer install && php artisan key:generate && npm install && npm run build && php artisan migrate --force && php artisan serve --host 0.0.0.0 --port $PORT"
