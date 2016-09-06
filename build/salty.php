<?php

$salts_url = 'https://api.wordpress.org/secret-key/1.1/salt/';
$output = '# salts - ' . $salts_url . "\n";
$str = file_get_contents($salts_url);
$arr = explode("\n", $str);

$numItems = count($arr);
$i = 0;
foreach ($arr as $string) {
  $string = str_replace(' ', '', $string);
  $string = str_replace("define('", '', $string);
  $string = str_replace("','", '=', $string);
  $string = str_replace("');", '', $string);

  $output .= $string;

  if(++$i !== $numItems) {
    $output .= "\n";
  }
}

file_put_contents('salts.txt', $output);
