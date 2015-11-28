# XChat

## Installation

### Minimum

Necessite d'avoir installé:
- Ruby 2.0 ou supérieur
- PostgreSQL 8 ou supérieur
- Imagemagick (permet le traitement d'image)

### Configuration

- Creer un fichier `config/database.yml`, utiliser `config/database.yml.example` comme base.
- Modifier la configuration du `host` dans `config/jt-toolbox.yml`

### Installation

- `gem install bundler` si `bundle` n'est pas installé 
- `bundle install` pour installer les dépendances
- `rake db:create` pour créer la base de donnée
- `rake db:migrate` pour construire les tables de la base de donnée
- `rake db:seed` pour créer des données de tests
- `rake tmp:create` permet de creer certains repertoire necessaire au fonctionnement en production

## Lancement du serveur

### Mode développement

`rails s -b 0.0.0.0` lance le serveur en mode développement accessible sur le port 3000 par défaut.

### Mode production

`./restart_production.sh` à la racine du projet pour lancer le serveur sur un socket unix `/tmp/sockets/puma.sock` et ne délivre pas les resources statiques présentes dans le dossier `public`.
Les fichiers statiques doivent etre renvoyé par nginx ou autre, sinon vous pouvez faire `export RAILS_SERVE_STATIC_FILES=true` pour forcer le serveur Rails à délivrer ces fichiers.
