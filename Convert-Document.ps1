param(
    [string]$InputFile,
    [string]$OutputFile
)

if (-not (Test-Path $InputFile)) {
    Write-Host "File not found."
    exit
}

Write-Host "Converting document..."

pandoc "$InputFile" -o "$OutputFile"

Write-Host "Done."
