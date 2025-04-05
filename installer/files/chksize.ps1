param([string]$dir) 
Set-Location $dir
$totalsize = [long]0
Get-ChildItem -File -Recurse -Force -ErrorAction SilentlyContinue | % {$totalsize += $_.Length}
$totalsize
exit
