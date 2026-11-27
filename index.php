<?php
use App\Utils\AccessLogger;

#################################################################################
##              -= YOU MAY NOT REMOVE OR CHANGE THIS NOTICE =-                 ##
## --------------------------------------------------------------------------- ##
##  Filename       : index.php                      	                       ##
##  Type           : In Game Index Page                                        ##
## --------------------------------------------------------------------------- ##
##  Developed by   : Dzoki 						                               ##
##  Refactored by  : Shadow                                                    ##
##  Redesign by    : Shadow                                                    ##
## --------------------------------------------------------------------------- ##
##  Contact        : cata7007@gmail.com                                        ##
##  Project        : TravianZ                                                  ##
##  URLs:          : https://travianz.org                                      ##
##  GitHub         : https://github.com/Shadowss/TravianZ                      ##
## --------------------------------------------------------------------------- ##
##  License        : TravianZ Project                                          ##
##  Copyright      : TravianZ (c) 2010-2026. All rights reserved.              ##
## --------------------------------------------------------------------------- ##
#################################################################################

if(!file_exists('var/installed') && @opendir('install')) {
    header("Location: install/");
    exit;
}

include_once("GameEngine/config.php");
/*
if($_SERVER['HTTP_HOST'] != '.SERVER.')
{
    header('location: '.SERVER.'');
    exit;
}
*/

// delete the /* and the */ if you not use localhost.

error_reporting(E_ALL || E_NOTICE);

if(file_exists('Security/Security.class.php'))
{
    require 'Security/Security.class.php';
    Security::instance();
}
else
{
    die('Security: Please activate security class!');
}

include_once "GameEngine/Database.php";
require_once __DIR__ . "/GameEngine/Lang/loader.php";
tz_load_language(LANG);

AccessLogger::logRequest();
?>
<?php
// Player numbers for the hero. Same queries as the classic page.
$tzStats = ['total' => 0, 'active' => 0, 'online' => 0];
$tribes = "tribe IN(1, 2, 3, 6, 7, 8, 9)";
$tzQueries = [
    'total'  => "SELECT COUNT(*) AS Total FROM " . TB_PREFIX . "users WHERE $tribes",
    'active' => "SELECT COUNT(*) AS Total FROM " . TB_PREFIX . "users WHERE timestamp > " . (time() - 3600 * 24) . " AND $tribes",
    'online' => "SELECT COUNT(*) AS Total FROM " . TB_PREFIX . "users WHERE timestamp > " . (time() - 60 * 10) . " AND $tribes",
];
foreach ($tzQueries as $key => $sql) {
    $return = mysqli_query($link, $sql);
    $tzStats[$key] = !empty($return) ? (int) mysqli_fetch_assoc($return)['Total'] : 0;
}
$tzl = $lang['landing'];

// Old links like index.php?signup / ?login go straight to the forms.
if (isset($_GET['signup'])) { header('Location: anmelden.php'); exit; }
if (isset($_GET['login']))  { header('Location: login.php');    exit; }
?>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<title><?php echo htmlspecialchars(SERVER_NAME, ENT_QUOTES, 'UTF-8'); ?></title>
	<meta name="description" content="<?php echo htmlspecialchars($tzl['lead'], ENT_QUOTES, 'UTF-8'); ?>" />
	<meta name="theme-color" content="#172232" />
	<link rel="shortcut icon" href="favicon.ico" />
	<link rel="icon" type="image/svg+xml" href="img/tz/logo.svg" />
	<link rel="preload" as="image" href="img/tz/hero.svg" />
<?php require_once __DIR__ . '/GameEngine/Lang/i18n_head.php'; tz_i18n_head('', 'landing'); ?>
	<link rel="stylesheet" type="text/css" href="css/tz-landing.css?v=1" />
</head>
<body class="tzl">
<?php include __DIR__ . '/Templates/landing.tpl'; ?>
</body>
</html>
