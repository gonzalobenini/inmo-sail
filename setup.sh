# Crear el proyecto de laravel de cero
:'
### primero correro estos dos comandos. notar que donde dice inmo, es el nombre del proyecto y se puede reemplazar por cualquier nombre (alfanumerico)
curl -s https://laravel.build/inmo | bash
cd inmo
./vendor/bin/sail up

### una vez que el contenedor este andando en una terminal nueva en la carpeta inmo correr:
./vendor/bin/sail artisan migrate
'

# Instalar Filament y livewire
:'
cd inmo

./vendor/bin/sail composer require filament/filament:"^3.2" -W

### yo registro el panel como 'admin'
./vendor/bin/sail php artisan filament:install --panels

./vendor/bin/sail composer require livewire/livewire
'

# No te levanta el proyecto
:'
docker stop $(docker ps -aq) # detiene TODOS los contenedores
sudo systemctl restart apache2 # reinicia apache
sudo systemctl restart nginx # reinicia ngnix, si no lo tenes da error
'

# Al clonar el repositorio
:'
cd inmo

### si falta la carpeta vendor
docker run --rm \
    -u "$(id -u):$(id -g)" \
    -v "$(pwd):/var/www/html" \
    -w /var/www/html \
    laravelsail/php83-composer:latest \
    composer install --ignore-platform-reqs

################################### correr solo si tira error las proximas lineas
#sail build --no-cache
###################################

./vendor/bin/sail composer install
./vendor/bin/sail up -d

./vendor/bin/sail artisan migrate
'
