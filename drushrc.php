<?php

$command_specific['up']['no-backup'] = TRUE;

function determineDomain() {
  static $SITES_DIR = '/Users/yorirou/Sites/';
  $cwd = getcwd();
  if (stripos($cwd, $SITES_DIR) === 0) {
    $relpath = substr($cwd, strlen($SITES_DIR));
    $slashpos = strpos($relpath, '/');
    if ($slashpos === FALSE) {
      $domain = $relpath;
    }
    else {
      $domain = substr($relpath, 0, $slashpos);
    }

    if (stripos($relpath, "$domain/sites/")) {
      return FALSE;
    }

    return "$domain.127.0.0.1.xip.io";
  }

  return FALSE;
}

if ($domain = determineDomain()) {
  $options['l'] = $domain;
}
