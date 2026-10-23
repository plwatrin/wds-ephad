# Migration vers un réseau WordPress Multisite

## Sites
- Résidence Le Prieuré : SQL + aspiration HTML
- Résidence Clémenceau : SQL + aspiration HTML
- Prieuré de la Fensch : SQL + aspiration HTML
- Prieuré du Thionvillois : export WordPress WXR XML

Les références source restent locales (répertoire `reference/` ignoré par Git). Les sauvegardes peuvent contenir des données personnelles.

## Thème et plugins
Conserver en priorité **Visual Composer Starter**, avec une seule installation partagée et des options distinctes par site. Les contenus utilisent possiblement **WPBakery Page Builder**, produit distinct de Visual Composer ; vérifier sa version, compatibilité et licence. Ne pas supposer que les fichiers du thème et des plugins sont présents dans l'aspiration HTML.

## Création du réseau
1. `make init`
2. Modifier les deux mots de passe DB dans `.env`, et ajouter `WP_ADMIN_USER`, `WP_ADMIN_PASSWORD`, `WP_ADMIN_EMAIL`. Réserver ces identifiants à la machine de développement.
3. `make up`
4. `make network-install` — réseau local en sous-répertoires
5. `make network-sites` ; accéder à `http://localhost:8080/wp-admin/network/`.

Le premier site du réseau est créé par WordPress. Il peut être attribué au Prieuré. Pour les trois autres, utiliser `make cli site create --slug=clemenceau --title='Résidence Clémenceau'`, etc. Les commandes sont à exécuter seulement après avoir confirmé le schéma de migration.

## NE PAS importer les anciennes bases directement dans MariaDB réseau
Chaque ancienne base contient ses tables `wp_*` et ses propres utilisateurs. Les collisions de noms et d'identifiants sont inévitables. Le script mono-site d'import a été retiré.

Procédure future :
1. Charger chaque dump dans une **base temporaire isolée**, non dans la base multisite.
2. Recenser les contenus, images, options, menus, identifiants, comptes, shortcodes et données sérialisées.
3. Migrer chaque établissement dans les tables de son site, en remappant les identifiants et URLs.
4. Importer le WXR de Thionvillois sur son sous-site (WordPress Importer), vérifier l'accessibilité réelle des médias référencés.
5. Comparer les pages reconstruites aux captures HTML. Tester formulaires, menus, liens, WPBakery et droits d'accès.

## Sécurité
Le service Apache n'écoute que sur `127.0.0.1`. Utiliser un tunnel SSH pour l'accès distant. Ne pas exposer une restauration d'anciens plugins à Internet. Aucune sauvegarde, aucun secret et aucune donnée utilisateur ne doivent être commités.

## À valider
- Les archives source et leur cohérence.
- La capacité de WPBakery historique à fonctionner avec PHP 8.3 et WordPress actuel.
- La disponibilité des images de chaque site et les droits/licences des extensions.
- Les domaines définitifs, HTTPS et architecture de déploiement.
