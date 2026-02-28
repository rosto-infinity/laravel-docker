# Chapitre 2 : Installation du projet Laravel

La première étape de notre projet consiste à générer l'architecture de base d'une application Laravel.

## Méthode 1 : Via Composer sur votre machine (Hôte)

Si vous avez déjà PHP et Composer d'installés sur votre machine, la méthode la plus rapide pour générer les fichiers est d'utiliser `composer create-project`.

Ouvrez votre terminal et exécutez la commande suivante :

```bash
composer create-project laravel/laravel mon-projet-laravel
```

Une fois l'installation terminée, déplacez-vous dans le dossier du projet :

```bash
cd mon-projet-laravel
```

## Méthode 2 : Via Docker (sans PHP sur l'hôte)

Si vous ne souhaitez _absolument pas_ installer PHP sur votre ordinateur, vous pouvez utiliser une image Docker temporaire pour exécuter Composer et générer le projet :

```bash
docker run --rm -v $(pwd):/app composer create-project laravel/laravel mon-projet-laravel
```

Cette commande signifie :

- `docker run --rm` : Lance un conteneur de manière temporaire (il se détruit à la fin).
- `-v $(pwd):/app` : Monte le dossier courant de votre machine dans le dossier `/app` du conteneur.
- `composer` : L'image Docker officielle de Composer.
- `create-project laravel/laravel mon-projet-laravel` : La commande exécutée à l'intérieur du conteneur.

## Structure du projet

Que vous ayez utilisé la méthode 1 ou 2, vous devriez maintenant avoir un dossier `mon-projet-laravel` avec la structure standard :

- `/app` : Contient le code principal de l'application (Models, Controllers, etc.).
- `/public` : Le point d'entrée pour les requêtes web (`index.php`), c'est ce dossier que notre serveur Apache pointera.
- `/routes` : Les définitions des routes de votre API ou de vos pages web.
- `.env` : Fichier contenant vos variables d'environnement.

Dans le prochain chapitre, nous allons voir comment préparer le fichier `.env` pour la base de données.
