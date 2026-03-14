param(
    [string]$InputFile,
    [string]$OutputFile
)

if (-not (Test-Path $InputFile)) {
    Write-Host "File not found."
    exit
}

$ext = [System.IO.Path]::GetExtension($OutputFile)

if ($ext -eq ".pdf") {

    Write-Host "Creating PDF..."

    gswin64c `
        -dBATCH `
        -dNOPAUSE `
        -sDEVICE=pdfwrite `
        -sOutputFile="$OutputFile" `
        "$InputFile"

}
else {

    Write-Host "Converting PDF..."

    gswin64c `
        -dBATCH `
        -dNOPAUSE `
        -sDEVICE=png16m `
        -r300 `
        -sOutputFile="$OutputFile" `
        "$InputFile"

}

Write-Host "Done."
