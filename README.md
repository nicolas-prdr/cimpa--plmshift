# Déploiement de Drupal

## Prérequis

- Installer le CLI selon son OS : https://plmshift.math.cnrs.fr/command-line-tools
- Découvrir le CLI : https://plmshift.pages.math.cnrs.fr/Foire_aux_Questions/cli/

## Préparation (se fait une fois) 

Si le dépôt git est privé, il faut créer un secret contenant un API Token Gitlab.

### Créer un API Token gitlab : 

Dans gitlab, allez dans Settings->Repository->Access Token. Ensuite, choisir un nom simple (à mémoriser), cocher *read_repository* et bien conserver la valeur du token (ne s'affiche qu'une seule fois)

### Créer le secret correspondant dans OKD

Dans le menu *Secrets* ->Create->Source Secret. Donner un nom au secret (ici on a choisit *plmlab*). Mettre dans le champ username le nom du Tokan, et dans password, la valeur du Token générée par Gitlab.

Ou bien en ligne de commande :

```
oc create secret generic <secret_name> \
--from-literal=username=<nom du token> \ 
--from-literal=password=<valeur du token>
```

## Deploiement

### Via la cosnole web

Aller dans le Catalog, choisir le Template LAMP (with repository)

- Donner un nom significatif à *APPLICATION_NAME* 
- Mettre l'URL de ce dépôt : https://plmlab.math.cnrs.fr/cimpa/drupal.git dans *LAMP_REPOSITORY_URL*

Comme le dépôt est privé, il faut ajouter le "secret token" qui autorise à lire le dépôt :

```
oc patch bc/<nom_application> -p '{"spec":{"source":{"sourceSecret":{"name":"plmlab"}}}}'
```

### En ligne de commande

```
oc new-app lamp-repository -pLAMP_REPOSITORY_URL=https://plmlab.math.cnrs.fr/cimpa/drupal.git --source-secret=plmlab -p APPLICATION_NAME=<un-nom-significatif>
```

### Supprimer l'application

```
oc delete all --selector=app=<un-nom-significatif>
```

Remarque: la suppression ne supprime pas les stockages persistants (PVC applicatif et Mysql). En reprenant le même nom d'application, on retrouve les données.
