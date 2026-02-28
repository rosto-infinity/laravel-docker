# Chapitre 4 : Création du Dockerfile

Pour faire tourner l'application Laravel, nous voulons créer une image sur-mesure contenant PHP et le serveur web Apache, ainsi que toutes les extensions PHP nécessaires (comme pdo_mysql pour la base de données).

C'est le rôle du `Dockerfile`, qui est en quelque sorte la "recette de cuisine" ou le "plan de construction" de notre image.

## Création du fichier

Créez un fichier nommé exactement `Dockerfile` (avec une majuscule et sans aucune extension de fichier) à la racine de votre projet Laravel.

## Le code du Dockerfile

Ouvrez ce fichier et insérez le code suivant. C'est le fichier exact utilisé pour ce projet :

```dockerfile
FROM php:8.4-apache

WORKDIR /var/www/html

RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    && docker-php-ext-install pdo_mysql

COPY . /var/www/html

RUN chown -R www-data:www-data /var/www/html
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache
RUN chown -R 777 /var/www/html/storage /var/www/html/bootstrap/cache

EXPOSE 80
```

Dans le prochain chapitre, nous allons décortiquer ce fichier ligne par ligne pour que vous compreniez précisément chaque étape de cette construction.
