# Chapitre 5 : Explication détaillée du Dockerfile

Prenons le temps de comprendre chaque ligne du `Dockerfile` que nous venons de créer. C'est l'essence même de l'apprentissage de Docker.

### `FROM php:8.4-apache`

C'est le point de départ de notre image. Nous nous basons sur l'image officielle maintenue par Docker, qui contient le système d'exploitation, la dernière version de PHP (8.4), et le serveur web Apache 2 pré-configuré.

### `WORKDIR /var/www/html`

Cette commande change le répertoire de travail par défaut. Toutes les commandes qui suivent s'exécuteront à partir de ce dossier `/var/www/html`, qui est le dossier par défaut configuré par Apache pour servir les sites webs.

### `RUN apt-get update && apt-get install -y ...`

La commande `RUN` exécute des commandes shell Linux pendant le processus de construction de l'image (le "build").
Ici, nous mettons à jour la liste des paquets (`apt-get update`) et installons `unzip` et `libzip-dev` qui sont nécessaires pour diverses opérations PHP.
Ensuite, la commande `docker-php-ext-install pdo_mysql` est un script utile fourni par l'image officielle PHP : il installe et active l'extension MySQL dont Laravel a besoin pour se connecter à la base de données.

### `COPY . /var/www/html`

Nous copions l'intégralité des fichiers de notre projet Laravel de notre machine hôte (le `.`) vers le dossier `/var/www/html` du conteneur. Ainsi, le code source de l'application est "scellé" dans l'image.

### `RUN chown -R www-data:www-data /var/www/html`

Cette directive modifie récursivement (`-R`) les droits de propriété de tous les fichiers copiés. Le serveur Apache s'exécute sous l'utilisateur Linux système `www-data`. Nous lui donnons donc la propriété globale des fichiers du projet.

### `RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache`

Pour assurer spécifiquement que certains dossiers sensibles soient pleinement possédés par le serveur Apache. En effet, par de multiples opérations, Laravel doit pouvoir écrire dans les dossiers `storage/` (pour les logs, les sessions, les fichiers uploadés) et `bootstrap/cache/` (pour la performance).

### `RUN chown -R 777 /var/www/html/storage /var/www/html/bootstrap/cache`

_(À noter : habituellement, la commande pour modifier les permissions de lecture/écriture publique est `chmod -R 777` plutôt que `chown`)._
Le but poursuivi par cette ligne est de s'assurer de manière radicale qu'il n'y a aucun blocage de droits d'écriture sur ces deux dossiers vitaux pour Laravel en assignant l'identifiant 777, de cette façon on efface totalement les redoutables erreurs de permissions sur les logs.

### `EXPOSE 80`

Ceci documente formellement le fait que le conteneur est conçu pour écouter sur le port 80 (le port HTTP standard). C'est indicatif pour celui qui lira le Dockerfile.
