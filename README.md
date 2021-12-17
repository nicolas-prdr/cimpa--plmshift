# Déploiement de Drupal

## Prérequis

- Installer le CLI selon son OS : https://plmshift.math.cnrs.fr/command-line-tools
- Découvrir le CLI : https://plmshift.pages.math.cnrs.fr/Foire_aux_Questions/cli/

## Deploiement

Aller dans le Catalog, choisir le Template LAMP (with repository)

- Donner un nom significatif à *APPLICATION_NAME* 
- Mettre l'URL de ce dépôt : https://plmlab.math.cnrs.fr/cimpa/drupal.git dans *LAMP_REPOSITORY_URL*

Comme le dépôt est privé, il faut ajouter le "secret token" qui autorise à lire le dépôt :

```
oc patch bc/<nom_application> -p '{"spec":{"source":{"sourceSecret":{"name":"plmlab"}}}}'
```

Puis relancer le Build (Start Build)
