# WDS EHPAD — La Résidence Le Prieuré

Projet de remise en service du site WordPress historique. Source SQL et copie HTML disponibles séparément, **hors du dépôt Git**.

## Développement local
Prérequis : Docker Engine + plugin Docker Compose, GNU Make, Bash.

```bash
cp .env.example .env
# Modifier les mots de passe locaux dans .env
make up
```

Accès local : http://localhost:8080 (port personnalisable dans `.env`).

```bash
make import-db FILE=backups/prieure.sql
make urls
make status
make logs
make backup-db
```

**Ne pas pousser le SQL d'origine ni l'archive HTML sur le dépôt public** : ils peuvent contenir des informations personnelles et des données sensibles. Consultez [le guide de restauration](docs/RESTAURATION.md).

Branches : `main` stable, `develop` intégration, `feature/*` par pull request.
