<?php

global $project;
$project = 'mysite';

global $databaseConfig;

// Use _ss_environment.php file for configuration
require_once("conf/ConfigureFromEnv.php");

//Unset cache if flushing
if (isset($_GET['flush'])) {
	SS_Cache::set_cache_lifetime('any', -1, 100);
}

