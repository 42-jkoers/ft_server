<?php
// from: <https://docs.phpmyadmin.net/>

declare(strict_types=1);
// @package PhpMyAdmin

// length 32
$cfg['blowfish_secret'] = 'verysecurewayofstoringthissupersecret';

$i = 0;
$i++;
$cfg['Servers'][$i]['auth_type'] = 'cookie';

$cfg['Servers'][$i]['host'] = 'localhost';
$cfg['Servers'][$i]['compress'] = false;

// definitely not a security risk
$cfg['Servers'][$i]['AllowNoPassword'] = true;

$cfg['Servers'][$i]['controlhost'] = '';
$cfg['Servers'][$i]['controlport'] = '';
$cfg['Servers'][$i]['controluser'] = 'joppe';
$cfg['Servers'][$i]['controlpass'] = 'definitelynotasecurityrisk';

$cfg['UploadDir'] = '';
$cfg['SaveDir'] = '';

