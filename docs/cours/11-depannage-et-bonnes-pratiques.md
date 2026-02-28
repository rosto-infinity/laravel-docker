# Chapitre 11 : Dépannage et bonnes pratiques Docker

Maintenant que votre application Laravel tourne sous Docker, vous allez probablement devoir effectuer des commandes récurrentes ou rencontrer quelques messages d'avertissement. Ce chapitre va résoudre les cas les plus fréquents.

## 1. Comprendre l'avertissement "version is obsolete"

Si, en lançant une commande `docker compose`, vous voyez ce message en jaune :

```text
WARN[0000] /home/devinsto/Sites/.../docker-compose.yml: the attribute `version` is obsolete, it will be ignored, please remove it to avoid potential confusion
```

**Explication :**
Historiquement, les fichiers `docker-compose.yml` commençaient toujours par définir une version (ex: `version: '2'` ou `version: '3.8'`). Depuis les versions récentes de Docker Compose V2, cette ligne n'est plus du tout analysée car le format est désormais unifié selon la `Compose Specification`.

**Solution :**
Il vous suffit d'ouvrir le fichier `docker-compose.yml` et de totalement **supprimer** la toute première ligne `version: '2'`. Le message d'avertissement disparaîtra instantanément.

## 2. Erreur : "service is not running" lors d'une commande exec

Si vous tentez d'exécuter une migration (ou toute autre commande Artisan) et obtenez cette erreur :

```text
service "laravel-docker-web-1" is not running
```

**Explication de la subtilité :**
Il y a souvent une confusion entre le **nom du conteneur** (généré automatiquement par Docker) et le **nom du service** (celui que vous avez écrit dans le `docker-compose.yml`).

Si vous utilisez `docker compose exec`, la commande attend obligatoirement le nom du **service** tel que déclaré dans votre fichier (ici `web`).

❌ Incorrect : `docker compose exec laravel-docker-web-1 php artisan migrate`
✅ Correct : `docker compose exec web php artisan migrate`

Si vous vouliez absolument utiliser le nom complet du conteneur (`laravel-docker-web-1`), vous devriez utiliser la commande native `docker` (et non `docker compose`) :
✅ Alternative : `docker exec -it laravel-docker-web-1 php artisan migrate`

## 3. Exécuter un shell bash ou sh

Lorsque vous devez naviguer physiquement à l'intérieur de votre serveur web ou base de données pour vérifier un fichier ou faire une modification manuelle :

```bash
docker compose exec web bash
```

_(Si `bash` n'est pas disponible selon l'image de base, utilisez simplement `sh` à la place)._

Tapez `exit` ou `Ctrl+D` pour quitter le conteneur quand vous avez terminé.

## 4. Reconstruire une image après une modification du Dockerfile

Lorsque vous modifiez le code source de l'application (PHP, Vue, routes), ces changements sont visibles immédiatement grâce au "volume" que nous avons configuré.
Cependant, si vous modifiez le `Dockerfile` (pour ajouter une nouvelle extension PHP par exemple) ou ajoutez un package Linux, il **faut forcer la reconstruction de l'image** :

```bash
docker compose up -d --build
```

Le serveur redémarrera silencieusement avec les nouvelles configurations.

## 5. Détruire complètement l'environnement et les données (Hard Reset)

Parfois, votre base de données se retrouve dans un état corrompu, ou vous souhaitez repartir de zéro comme au premier jour. Il faut alors détruire les conteneurs **et** les volumes associés (où sont stockées les données MySQL notamment).

Pour ce faire, on exécute :

```bash
docker compose down -v
```

Voici ce que vous verrez en résultat :

```text
WARN[0000] /home/devinsto/Sites/.../docker-compose.yml: the attribute `version` is obsolete...
[+] Running 4/4
 ✔ Container laravel-docker-web-1  Removed
 ✔ Container laravel-docker-db-1   Removed
 ✔ Volume laravel-docker_dbase     Removed
 ✔ Network laravel-docker_default  Removed
```

**Que fait cette commande ?**

- `down` : Arrête et supprime tous les **Conteneurs** et les **Réseaux** (Network) définis dans votre `docker-compose.yml`.
- `-v` (ou `--volumes`) : C'est le drapeau (flag) crucial. Il ordonne la suppression totale de tous les **Volumes** persistants (comme `laravel-docker_dbase` ici).

⚠️ **Attention :** En exécutant cette commande avec `-v`, votre base de données sera **intégralement effacée**. C'est l'option "Nucléaire" idéale pour le développement !

Une fois l'environnement détruit, pour repartir sur des bases saines, il suffit de relancer l'infrastructure :

```bash
docker compose up -d
```

Vous obtiendrez une sortie vous confirmant la recréation des volumes, réseaux et conteneurs :

```text
WARN[0000] /home/devinsto/Sites/.../docker-compose.yml: the attribute `version` is obsolete...
[+] Running 4/4
 ✔ Network laravel-docker_default  Created
 ✔ Volume laravel-docker_dbase     Created
 ✔ Container laravel-docker-db-1   Started
 ✔ Container laravel-docker-web-1  Started
```

Désormais, vous repartez avec un serveur propre et une base de données MySQL complètement vide, qu'il faudra bien entendu remigrer (`php artisan migrate`).

---

### Résumé des commandes essentielles

| Action                          | Commande                                          |
| :------------------------------ | :------------------------------------------------ |
| Voir le statut des conteneurs   | `docker compose ps`                               |
| Exécuter une migration BDD      | `docker compose exec web php artisan migrate`     |
| Vider le cache de l'application | `docker compose exec web php artisan cache:clear` |
| Redémarrer les conteneurs       | `docker compose restart`                          |
| Afficher les logs (erreurs)     | `docker compose logs -f web`                      |
