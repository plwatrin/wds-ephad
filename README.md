# WDS EHPAD — réseau WordPress Multisite

Restauration de quatre sites d'établissements avec une **installation WordPress partagée** : Le Prieuré, Clémenceau, Fensch, Thionvillois.

Objectif : conserver **Visual Composer Starter** comme thème commun et reconstruire chaque site à partir des sources historiques, sans modifier les sauvegardes d'origine.

## Démarrage local
Prérequis : Docker Engine, Docker Compose v2, GNU Make, Bash.

```bash
make init
# Modifier .env (mots de passe) et ajouter WP_ADMIN_USER, WP_ADMIN_PASSWORD, WP_ADMIN_EMAIL.
make up
make network-install
make network-sites
```

Adresse locale : http://localhost:8080 (réseau sous-répertoires). L'environnement utilise MariaDB 10.11, WordPress/PHP 8.3 et WP-CLI. Ce n'est pas une reproduction exacte des anciens serveurs.

```bash
make status
make logs
make backup-db
make validate
```

Lire impérativement [docs/RESTAURATION.md](docs/RESTAURATION.md) avant toute importation. **Ne pas importer un dump SQL mono-site directement dans la DB Multisite** : une migration avec remappage est nécessaire.

Les sauvegardes SQL, HTML, XML, les médias privés et les secrets restent **hors du dépôt public**. `main` reste stable ; changements par pull requests.
