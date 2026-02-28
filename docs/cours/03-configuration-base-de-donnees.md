# Chapitre 3 : Configuration de la Base de Données

Une fois le projet Laravel initialisé, il est essentiel de configurer les accès à la base de données. Dans Laravel, ces informations sont stockées dans le fichier `.env` situé à la racine du projet. Ce fichier n'est généralement pas versionné sur Git pour des raisons de sécurité.

## Édition du fichier `.env`

Ouvrez le fichier `.env` dans votre éditeur de code. Cherchez la section qui commence par `DB_`. Elle devrait ressembler à ceci par défaut :

```env
DB_CONNECTION=sqlite
# DB_HOST=127.0.0.1
# DB_PORT=3306
# DB_DATABASE=laravel
# DB_USERNAME=root
# DB_PASSWORD=
```

_(Note : Selon la version de Laravel, il se peut que SQLite soit configuré par défaut)._

Pour utiliser une base de données MySQL ou MariaDB au sein de notre architecture Docker, modifiez ou décommentez ces lignes ainsi :

```env
DB_CONNECTION=mysql
DB_HOST=db
DB_PORT=3306
DB_DATABASE=laravel_db
DB_USERNAME=laravel_user
DB_PASSWORD=secret
```

## Pourquoi ces valeurs ?

1. **`DB_CONNECTION=mysql`** : Indique à Laravel que nous allons utiliser le driver MySQL/MariaDB au lieu de SQLite ou PostgreSQL.
2. **`DB_HOST=db`** : C'est la partie la plus importante ! Avec Docker Compose, les conteneurs communiquent entre eux en utilisant leur nom de service sur le réseau interne. Au lieu de `127.0.0.1` (qui pointerait vers l'intérieur du conteneur Laravel lui-même), nous utiliserons le mot `db` qui sera le nom de notre conteneur de base de données.
3. **`DB_PORT=3306`** : Le port par défaut standard de MySQL.
4. **`DB_DATABASE`**, **`DB_USERNAME`**, **`DB_PASSWORD`** : Les identifiants de la base de données. Nous fournirons ces exactes mêmes valeurs à notre conteneur MySQL dans le docker-compose.yml pour qu'il crée cette base automatiquement au premier démarrage.

Maintenant que Laravel est configuré pour s'attendre à une base de données sur l'hôte "db", nous sommes prêts à écrire notre infrastructure Docker à commencer par le `Dockerfile` !
