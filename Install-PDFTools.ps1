$gsUrl = "https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/latest/download/gswin64.zip"
$zipPath = "$env:TEMP\ghostscript.zip"
$installDir = "C:\ghostscript"

Write-Host "Creating directory..."
New-Item -ItemType Directory -Path $installDir -Force | Out-Null

Write-Host "Downloading Ghostscript..."
Invoke-WebRequest $gsUrl -OutFile $zipPath

Write-Host "Extracting..."
Expand-Archive $zipPath -DestinationPath $installDir -Force

$gsFolder = Get-ChildItem $installDir | Where-Object {$_.PSIsContainer} | Select-Object -First 1
$binPath = "$($gsFolder.FullName)\bin"

$currentPath = [Environment]::GetEnvironmentVariable("Path","User")

if ($currentPath -notlike "*$binPath*") {
    [Environment]::SetEnvironmentVariable(
        "Path",
        "$currentPath;$binPath",
        "User"
    )
}

Write-Host "Ghostscript installed."
