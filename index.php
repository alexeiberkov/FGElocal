<?php
//composer install
require __DIR__ . '/vendor/autoload.php';
$smarty = new Smarty();

ob_start();

set_time_limit(120);

chdir("build");

$currentBranch = trim(shell_exec("git symbolic-ref --short HEAD"));
$remoteBranches = explode("\n", shell_exec("git branch -r"));
$branches = [];
foreach ($remoteBranches as $branchName) {
    if (!strpos($branchName, "origin/develop") &&
        !strpos($branchName, "origin/master") &&
        !strpos($branchName, "HEAD") &&
        $branchName) {
        $branches[] = trim(substr($branchName, 9));
    }
}
ob_clean();
chdir("..");

$smarty->assign('currentBranch', $currentBranch);
$smarty->assign('allBranches', $branches);
$smarty->assign('appURL', "http://localhost:2992/index.html");
$smarty->assign('workerURL', "http://localhost:8001/worker.php");
$smarty->display('main.tpl');
?>