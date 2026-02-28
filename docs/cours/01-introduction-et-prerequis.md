# Chapitre 1 : Introduction et Prérequis

Bienvenue dans ce cours complet pas à pas sur la conteneurisation d'une application Laravel avec Docker !

## Objectifs du cours

À la fin de ce tutoriel, vous serez capable de :

1. Installer un projet Laravel de zéro.
2. Configurer une base de données MySQL/MariaDB.
3. Écrire et comprendre un `Dockerfile` pour un environnement PHP/Apache.
4. Paramétrer un hôte virtuel (VirtualHost) Apache spécifique à Laravel.
5. Orchestrer votre environnement complet avec `docker-compose`.

## Pourquoi utiliser Docker pour Laravel ?

- **Reproductibilité** : Fini le "ça marche sur ma machine". Avec Docker, l'environnement de développement est identique pour tous les développeurs et similaire à la production.
- **Isolation** : Chaque élément (Serveur Web, Base de données) est isolé dans son propre conteneur sans polluer votre système hôte.
- **Simplicité** : Vous n'avez plus besoin d'installer PHP, Apache ou MySQL directement sur votre ordinateur.

## Prérequis

Avant de commencer, assurez-vous d'avoir installé sur votre machine :

- **Docker** : Le moteur de conteneurisation.
- **Docker Compose** : L'outil pour définir et exécuter des applications Docker multi-conteneurs.
- **Composer** (optionnel mais recommandé sur l'hôte) ou vous pouvez utiliser un conteneur temporaire pour l'installation initiale.
- Un éditeur de code comme **VS Code** ou **PhpStorm**.

Dans le prochain chapitre, nous commencerons par l'installation du projet Laravel.
