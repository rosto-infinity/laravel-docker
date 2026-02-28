# Chapitre 10 : Lancement et gestion du projet

Et voilà ! L'infrastructure est terminée et paramétrée. Il est temps de voir le serveur s'allumer.

## 1. Démarrer l'infrastructure

Ouvrez un terminal à la racine absolue de votre projet (où se trouve le fichier `docker-compose.yml`) et propulsez la commande :

```bash
docker compose up -d --build
```

Que se passe-t-il ici ?

- `up` : Ordonne à Docker d'invoquer et de lier l'univers déclaré dans le YML.
- `-d` (detached mode) : Permet aux processus de serveur de tourner silencieusement en arrière-plan.
- `--build` : Ordonne de relire en détail le `Dockerfile` et de recompiler l'image.

**Vérification de l'état :**
Pour s'assurer que notre conteneur tourne parfaitement bien, on peut vérifier la liste des processus Docker actifs en tapant :

```bash
devinsto@devinsto:~/Sites/laravel-docker$ docker ps
CONTAINER ID   IMAGE            COMMAND                  CREATED              STATUS              PORTS                                     NAMES
fa6a620e6b58   laravel-docker   "docker-php-entrypoi…"   About a minute ago   Up About a minute   0.0.0.0:8000->80/tcp, [::]:8000->80/tcp   laravel-docker-web-1
```

Tout est au vert ! Le statut est `Up` et notre port `8000` est bien réacheminé vers le conteneur.

## 2. Accéder à votre application visuellement

Ouvrez votre navigateur favori et naviguez vers :
👉 [http://localhost:8000](http://localhost:8000)

Vous contemplez la majesté moderne : la page d'accueil Laravel s'affiche sur un socle Docker flambant neuf.

## 3. Lancer les commandes internes (Artisan / Composer)

Pour exécuter une commande locale au cœur de Docker (comme vider le cache, ou migrer la BDD) sans posséder PHP sur votre ordinateur :

```bash
docker compose exec web php artisan migrate
```

- `exec web` : Exécute de force et de l'extérieur vers l'intérieur du conteneur `web`.
- `php artisan...` : La commande effective à lancer.

## 4. Astuces et Commandes Vitales

Voici votre ceinture à outils quotidienne pour dompter la bête :

**Sonder les logs (Errors Apache / PHP dumper) en flux continu Temps-Réel :**

```bash
docker compose logs -f web
```

_(Frappez Ctrl+C pour quitter les logs)_

**Entrer physiquement dans le conteneur en mode ligne de commande :**

```bash
docker compose exec web bash
```

**Annihiler et purger le cluster :**
Si vous avez terminé de travailler sur le projet, ou que la configuration est corrompue, vous pouvez arrêter et effacer totalement le conteneur et son réseau associé proprement via cette commande stricte :

```bash
devinsto@devinsto:~/Sites/laravel-docker$ docker compose down
WARN[0000] /home/devinsto/Sites/laravel-docker/docker-compose.yml: the attribute `version` is obsolete, it will be ignored, please remove it to avoid potential confusion
[+] Running 2/2
 ✔ Container laravel-docker-web-1  Removed                                          1.4s
 ✔ Network laravel-docker_default  Removed                                          0.3s
```

Pour vous prouver l'efficacité radicale de cette opération de nettoyage :

```bash
devinsto@devinsto:~/Sites/laravel-docker$ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

Le conteneur est intégralement effacé de l'écosystème actif (les données montées dans les volumes persistants sont toutefois sauves quant à elles !).

### 🏆 Félicitations Solennelles !

Vous avez paramétré avec succès une architecture de conteneurisation PHP moderne qui répond parfaitement aux exigences de l'industrie. Bon code !
