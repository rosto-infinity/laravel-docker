# Chapitre 7 : Explication détaillée de la configuration Apache

La configuration Apache que nous venons de créer est la pierre angulaire qui permet à Laravel de fonctionner correctement et de façon sécurisée derrière notre serveur web Docker.

Examinons ce fichier `default.conf` ligne par ligne :

### `<VirtualHost *:80>`

Ceci définit un "Hôte Virtuel" (VirtualHost) qui écoute sur le port 80 (le port HTTP standard). L'astérisque `*` signifie qu'il accepte les requêtes web provenant de n'importe quelle adresse IP.

### `ServerName localhost`

Ceci définit le nom de domaine principal pour cet hôte virtuel. Typiquement, en environnement Docker de développement local sur notre ordinateur, c'est tout simplement `localhost`.

### `DocumentRoot /var/www/html/public`

**C'est la ligne la plus cruciale pour Laravel !**
Par défaut, le DocumentRoot d'Apache est `/var/www/html`. Nous lui disons explicitement que le répertoire public (celui qui doit être accessible depuis le navigateur web) est le sous-dossier spécifique `public/` de Laravel.
Cela protège automatiquement, de façon radicale, tous les autres dossiers sensibles de Laravel (`app/`, `config/`, `.env`, etc.) contre l'accès direct par le web. Ils sont inaccessibles car situés au-dessus du `DocumentRoot`.

### `<Directory /var/www/html/public>`

Ce bloc définit les règles et permissions d'Apache qui s'appliquent uniquement à ce dossier (et ses sous-dossiers).

### `Options Indexes FollowSymLinks`

- `Indexes` : Permet au serveur de lister le contenu du répertoire s'il n'y a pas de fichier `index.php` ou `index.html` (rarement désiré en production, mais standard en dev).
- `FollowSymLinks` : Indique au serveur d'Apache de suivre les liens symboliques. Laravel utilise abondamment les liens symboliques, notamment pour exposer le dossier de stockage avec `php artisan storage:link`.

### `AllowOverride All`

**Une autre ligne vitale !**
Cette directive autorise l'utilisation et la prise en compte intégrale du fichier caché `.htaccess` présent par défaut dans le dossier `public/` de Laravel. C'est le `.htaccess` qui contient la magie des règles de réécriture d'URL (les belles URL de Laravel). Si c'était réglé sur `None`, Laravel afficherait des erreurs 404 sur toutes vos routes SAUF sur la racine `/`.

### `Require all granted`

Ceci est la directive moderne d'autorisation d'Apache (version 2.4+). Elle autorise de façon globale l'accès à ce dossier à tous les visiteurs internet. Sans elle, vous obtiendriez instantanément l'erreur tant redoutée "403 Forbidden" sur votre site.

### `ErrorLog ${APACHE_LOG_DIR}/error.log` et `CustomLog ...`

Ces lignes indiquent à Apache où il doit archiver les journaux d'erreurs (les plantages PHP par exemple) et les accès au site. La variable `${APACHE_LOG_DIR}` est définie nativement dans l'image Docker Debian/Apache. Très utile si vous avez besoin de déboguer une "White Screen of Death" avec `docker compose logs`.
