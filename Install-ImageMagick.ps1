$magickUrl = "https://imagemagick.org/archive/binaries/ImageMagick-7.1.1-32-portable-Q16-x64.zip"
$zipPath = "$env:TEMP\imagemagick.zip"
$installDir = "C:\imagemagick"

Write-Host "Creating directory..."
New-Item -ItemType Directory -Path $installDir -Force | Out-Null

Write-Host "Downloading ImageMagick..."
Invoke-WebRequest $magickUrl -OutFile $zipPath

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

Write-Host "ImageMagick installed."
Write-Host "Restart PowerShell then test: magick -version"
