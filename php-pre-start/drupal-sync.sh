#/bin/bash

set -e

if [ ! -f website/web/sites/default/settings.php ];then
  echo "Sync la distribution Drupal dans le dossier website, merci de patienter..."
  rsync -a /opt/app-root/drupal-dist/* website/
  fix-permissions ./
fi

echo "Sync de la customisation su site"
rsync -av web/* website/web/
echo "On fixe les permissions dans le dossier web"
fix-permissions website/web/

# Apres une installation reussie, on bloque l'acces en ecriture a settings.php
if [ -d website/web/sites/default/files/languages ] && [ -w website/web/sites/default/settings.php ]; then
  chmod 440 website/drupal/web/sites/default/settings.php
fi

