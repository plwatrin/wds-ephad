# Restauration du site Le Prieuré

## Sources connues
- `prieure.sql` : export SQL de l'ancien WordPress (non versionné).
- `laresidenceleprieure.fr.zip` : aspiration HTML du site (non versionnée).
- Ancien WordPress observé dans le HTML : 5.3.20.
- Ancien thème : Visual Composer Starter ; constructeur de pages WPBakery.

## Environnement
Docker Compose fournit WordPress (PHP 8.3), MariaDB 10.11 et WP-CLI. Il s'agit d'un **environnement moderne de reconstruction**, pas d'une reproduction exacte de l'hébergement historique. Certaines anciennes extensions peuvent être incompatibles : les tester au cas par cas.

## Mise en route
1. Copier `.env.example` vers `.env`, remplacer les mots de passe.
2. `make up` puis ouvrir http://localhost:8080.
3. Déposer le SQL **localement** dans `backups/prieure.sql`, sans le committer.
4. `make import-db FILE=backups/prieure.sql`.
5. `make urls` (script prévu pour le port local par défaut 8080).
6. Depuis l'archive HTML, récupérer les images utiles et les copier dans `wp-content/uploads` en préservant autant que possible l'arborescence d'origine.
7. Installer et auditer le thème et les extensions nécessaires avant toute activation.

## Précautions
- L'import n'a pas encore été exécuté : la compatibilité de ce dump avec MariaDB 10.11 reste à tester.
- Ne pas committer les sauvegardes SQL, les archives, les uploads privés, les mots de passe ou les données des utilisateurs.
- Les mots de passe d'origine ne sont pas nécessaires à l'ouverture du site : si besoin, réinitialiser le mot de passe de l'administrateur via WP-CLI.
- Ne pas exposer un WordPress ancien/non corrigé sur Internet. Le service web est limité à 127.0.0.1.
- Pour ouvrir depuis une autre machine : tunnel SSH vers le port 8080.
- Tester en priorité le rendu des pages WPBakery et des formulaires.
