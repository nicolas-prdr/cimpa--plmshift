<?php

if (getenv('OPENSHIFT_BUILD_NAME')) {
  if (file_exists($app_root . '/' . $site_path . '/settings.openshift.php')) {
    include $app_root . '/' . $site_path . '/settings.openshift.php';
  }
}

