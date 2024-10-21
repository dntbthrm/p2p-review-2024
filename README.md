# p2p-review-2024

## Клонирование репозитория

`git clone https://github.com/dntbthrm/p2p-review-2024.git` 

`git submodule init`

`git submodule update`

## Запуск 

Для обновления и запуска:

`sh ./update.sh`

Пересборка

`sudo docker-compose up --build`

### Запуск без обновления и пересборки:

`docker-compose start`

## Остановка

С удалением ресурсов

`docker-compose down -v`

Без удаления

`docker-compose stop`