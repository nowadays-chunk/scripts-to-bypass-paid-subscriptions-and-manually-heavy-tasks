param(
    [string]$InputFile,
    [string]$OutputFile
)

if (-not (Test-Path $InputFile)) {
    Write-Host "Input file not found."
    exit
}

Write-Host "Converting image..."

magick "$InputFile" "$OutputFile"

Write-Host "Done."
