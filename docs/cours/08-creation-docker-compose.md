# Chapitre 8 : Création du docker-compose.yml

Nous avons maintenant un `Dockerfile` prêt pour compiler notre application Web. Plutôt que de lancer notre image Docker via des commandes terminal interminables et complexes, nous utilisons le puissant outil de configuration **Docker Compose**.

## Le fichier docker-compose.yml

Créez un fichier nommé exactement `docker-compose.yml` à la racine de votre projet Laravel, au même endroit que le `Dockerfile`.

Voici le contenu de notre fichier :

```yaml
version: "2"

services:
    web:
        build:
            context: .
            dockerfile: Dockerfile
        image: laravel-docker
        ports:
            - "8000:80"
        volumes:
            - .:/var/www/html
            - /var/www/html/storage
            - /var/www/html/bootstrap/cache
            - ./.docker/apache/default.config:/etc/apache2/sites-available/000-default.conf
        working_dir: /var/www/html
        user: "www-data"
```

Ce fichier se charge d'orchestrer le montage de notre serveur Web "web", de relier son port à notre ordinateur local, et de brancher les fichiers partagés (volumes).

_(Par ailleurs, vous constaterez qu'une balise `version` est présente au début. C'était un standard autrefois, mais cela lève désormais un simple avertissement lors du lancement dans les versions modernes de Docker.)_
