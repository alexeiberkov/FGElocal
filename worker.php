<?php
set_time_limit(120);
ob_start();
if ($_POST['branchName'] && $_POST['config']) {
//1. Change the working directory
    chdir("build");


    $branchName = trim($_POST['branchName']);
    $useTestConf = $_POST['config'] === "tsrv";
    $runNPMInstall = false;


///////////////////////////////////////////////////////////////////////////


//2. Clone git branch
    $gitCommands = [
        "git checkout develop",
        "git branch -d " . $branchName,
        "git checkout --force -b " . $branchName . " origin/" . $branchName,
        "git pull"
    ];

    foreach ($gitCommands as $command) {
        echo exec($command);
        echo "<br/>";
    }

//3. Set configuration file
    $testConfigFile = $useTestConf ? 'config/test.js' : 'config/dev.js';
    $devConfigFile = 'config/prod.js';
    copy($testConfigFile, $devConfigFile);

//4. Change branch name for Console info

    $versionFileContent = file("build/version.js");
    $versionFileContent[1] = "'branch': '" . $branchName . "',";
    file_put_contents("build/version.js", implode('', $versionFileContent));
    $indexTemplateContent = file("app/index_template.html");
    file_put_contents("app/index_template.html", str_replace("{%=o.htmlWebpackPlugin.options.title%}", $branchName.'_'.$testConfigFile, $indexTemplateContent));


//5. Build the branch
    $npmCommands = [];

    if ($runNPMInstall) {
        $npmCommands[] = "npm install";
    }

    $npmCommands[] = "npm run build";

    foreach ($npmCommands as $command) {
        echo exec($command);
        echo "<br/>";
    }

    ob_clean();

    header("Location: http://localhost:2992/index.html?_k=" . time());
    exit();
}
?>