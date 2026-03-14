$ffmpegUrl = "https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-essentials.zip"
$zipPath = "$env:TEMP\ffmpeg.zip"
$installDir = "C:\ffmpeg"

Write-Host "Creating folder..."
New-Item -ItemType Directory -Path $installDir -Force | Out-Null

Write-Host "Downloading FFmpeg..."
Invoke-WebRequest $ffmpegUrl -OutFile $zipPath

Write-Host "Extracting..."
Expand-Archive $zipPath -DestinationPath $installDir -Force

$ffmpegFolder = Get-ChildItem $installDir | Where-Object {$_.PSIsContainer} | Select-Object -First 1
$binPath = "$($ffmpegFolder.FullName)\bin"

$currentPath = [Environment]::GetEnvironmentVariable("Path","User")

if ($currentPath -notlike "*$binPath*") {
    [Environment]::SetEnvironmentVariable(
        "Path",
        "$currentPath;$binPath",
        "User"
    )
}

Write-Host "FFmpeg installed."
Write-Host "Restart PowerShell and run: ffmpeg -version"
