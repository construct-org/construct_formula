$OLD_PATH=$Env:PATH
$Env:PATH="{{ latest_dir }}\Scripts;$OLD_PATH"

Invoke-Expression "{{ latest_dir }}\Scripts\construct.ps1 $args"

$Env:PATH=$OLD_PATH
Remove-Variable -name OLD_PATH
