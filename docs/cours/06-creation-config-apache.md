# Chapitre 6 : Création de la configuration Apache

Par défaut, un serveur Apache va chercher les fichiers à servir à la racine de son `DocumentRoot`, qui est généralement `/var/www/html`. Mais dans une application Laravel, le point d'entrée public est strictement le dossier `public/` (où se trouve le fichier `index.php`).

Si nous n'indiquons pas à Apache de pointer spécifiquement vers `/var/www/html/public`, notre site ne fonctionnera pas correctement et affichera peut-être le contenu de nos dossiers protégés au monde externe.

## L'arborescence

Afin de garder notre projet Docker propre et organisé, nous allons créer un dossier `.docker` à la racine de notre projet Laravel, puis un sous-dossier `apache`.

```bash
mkdir -p .docker/apache
```

## Création du fichier `default.conf`

Dans ce dossier `.docker/apache/`, créez un fichier nommé `default.conf`.

Collez-y le contenu suivant :

```apache
<VirtualHost *:80>
    ServerName localhost

    DocumentRoot /var/www/html/public

    <Directory /var/www/html/public>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```

Rappelez-vous le chapitre 4 : C'est ce fichier précis que notre Dockerfile va copier pour écraser la configuration par défaut d'Apache via cette instruction :
`COPY .docker/apache/default.conf /etc/apache2/sites-available/000-default.conf`

Dans le prochain chapitre, nous allons voir pourquoi chaque ligne de ce fichier de configuration est absolument essentielle pour le bon fonctionnement de Laravel.
