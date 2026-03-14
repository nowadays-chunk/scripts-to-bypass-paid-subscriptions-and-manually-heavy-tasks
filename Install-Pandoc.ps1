$pandocUrl = "https://github.com/jgm/pandoc/releases/latest/download/pandoc-3.2-windows-x86_64.zip"
$zipPath = "$env:TEMP\pandoc.zip"
$installDir = "C:\pandoc"

Write-Host "Creating folder..."
New-Item -ItemType Directory -Path $installDir -Force | Out-Null

Write-Host "Downloading Pandoc..."
Invoke-WebRequest $pandocUrl -OutFile $zipPath

Write-Host "Extracting..."
Expand-Archive $zipPath -DestinationPath $installDir -Force

$folder = Get-ChildItem $installDir | Where-Object {$_.PSIsContainer} | Select-Object -First 1
$binPath = $folder.FullName

$currentPath = [Environment]::GetEnvironmentVariable("Path","User")

if ($currentPath -notlike "*$binPath*") {
    [Environment]::SetEnvironmentVariable(
        "Path",
        "$currentPath;$binPath",
        "User"
    )
}

Write-Host "Pandoc installed."
Write-Host "Restart terminal then run: pandoc -v"
