Aula 01

-Construir a Imagem
    docker build -t mysql-image -f services\db\DockerFile .

-Iniciar a Imagem
    docker run -d --rm --name mysql-container mysql-image

-Executar o script do Mysql
    docker exec -i mysql-container mysql -uroot -pimpacta < services/db/scripts.sql   #não roda no shell

-Acessar o Container
    docker exec -it mysql-container /bin/bash

-Acessar o Mysql
    mysql -uroot -pimpacta

-MYSQL
    show databases;
    use IMPACTA_DATABASE;
    show tables;
    SELECT * FROM CLIENTE;
    exit;


-Volume
    docker run -d -v C:/Users/Noses/Desktop/Impacta/LABDocker/Aula1/services/db/data:/var/lib/mysql --rm --name mysql-container mysql-image

-Inspecioanr container
    docker inspect mysql-container

-Liberação da porta
    docker run -d -v $(pwd)/services/db/data:/var/lib/mysql -p 3306:3306  --rm --name mysql-container mysql-image    