#/bin/bash

set -e

if [ ! -f sites/default/settings.php ];then
  echo "Sync la distribution Drupal dans le dossier website, merci de patienter..."
  rsync -av /opt/app-root/drupal-dist/ .
  fix-permissions ./
fi

# Apres une installation reussie, on bloque l'acces en ecriture a settings.php
if [ -d sites/default/files/languages ] && [ -w sites/default/settings.php ]; then
  chmod 440 website/drupal/web/sites/default/settings.php
fi
