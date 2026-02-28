# Chapitre 9 : Explication détaillée du docker-compose.yml

Docker Compose semble magique, mais tout est basé sur une stricte logique pure. Étudions notre fichier ligne par ligne.

### `version: '2'`

C'était, historiquement, le moyen d'indiquer à Docker quelle version du parseur de règles YAML utiliser. Aujourd'hui, cette balise est devenue obsolète et ignorée par Docker Compose (c'est ce qui provoque l'avertissement _the attribute `version` is obsolete_ lors du lancement), la norme étant de retirer totalement cette ligne.

### `services: web:`

C'est ici que nous définissons nos différents logiciels/conteneurs. Nous n'avons déclaré qu'un seul service ici : le serveur web que nous nommons `web`.

### `build:` -> `context: .` et `dockerfile: Dockerfile`

Indique à Docker Compose qu'il ne doit pas télécharger une image toute prête sur internet, mais qu'il doit construire l'image en utilisant notre `Dockerfile` qui se trouve dans le projet courant (`.`).

### `image: laravel-docker`

On demande à ce que l'image compilée localement à partir de notre Dockerfile soit taggée "laravel-docker", la rendant plus facilement repérable dans notre dépôt local d'images Docker.

### `ports: - "8000:80"`

Ouvre un tunnel. Fait correspondre le port virtuel 8000 de votre ordinateur hôte pour le rediriger vers le port 80 (Apache HTTP) du conteneur. Quand vous irez sur `http://localhost:8000`, la requête tombera directement sur le serveur Web interfacé avec Laravel.

### `volumes:`

Les volumes sont vitaux dans Docker. Ils permettent de projeter ou de persister des dossiers.

- `- .:/var/www/html` : Synchronise en temps réel votre dossier local de code source (`.`) avec le webroot `/var/www/html` dans le conteneur. Vous codez sur VS Code, le résultat se reflète en temps réel sans re-build !
- `- /var/www/html/storage` et `- /var/www/html/bootstrap/cache` : Ce sont des "_volumes anonymes_". Leur particularité est de protéger le contenu et les permissions de ces 2 dossiers internes au conteneur afin qu'ils ne soient pas écrasés ou corrompus par le montage du projet hôte au-dessus (qui annulerait le `chown` ou les permissions écrites dans le Dockerfile).
- `- ./.docker/apache/default.config:/etc/apache2/sites-...` : Ce montage insère la configuration ciblée d'Apache (pointant sur le dossier `public/` de Laravel) à l'intérieur du serveur, écrasant de force la configuration native d'Apache.

### `working_dir: /var/www/html`

Force le conteneur, à l'allumage ou quand l'on tape des commandes `docker compose exec`, à systématiquement s'initialiser dans ce dossier racine.

### `user: "www-data"`

On impose formellement que toutes les actions principales et le point d'entrée du conteneur se fassent sous l'utilisateur Unix propriétaire de base `www-data` (utilisateur standard d'Apache), évitant des conflits de droits dramatiques de fichiers entre l'hôte root et le système Docker.
