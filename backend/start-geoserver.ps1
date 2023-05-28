$GeoServerDownloadURL = "https://sourceforge.net/projects/geoserver/files/latest/download"
$GeoServerFilename = "geoserver.zip"

## Defaults
$ProgressPreference = 'SilentlyContinue'

## Functions 
function Download-From ($url, $target) {
    if (Test-Path -Path $target) {
        Write-Host "$target already exists, skip downloading."
    }else {
        Write-Host "Downloading $url..."
        Invoke-WebRequest $url -outfile $target -UserAgent "Wget"
    }
}

function Extract-To ($archive, $target) {
    if (Test-Path -Path $target) {
        Write-Host "$target already exists, skip extraction."
    } else {
        Write-Host "Extracting $archive..."
        Expand-Archive -Path $archive -DestinationPath $target
    }
}
## Downloads
Download-From -url $GeoServerDownloadURL -target "$PSScriptRoot\$GeoServerFilename"

## Extractions
Extract-To -archive "$PSScriptRoot\$GeoServerFilename" -target "$PSScriptRoot\geoserver"

## Set environment variable
Set-Item -Path Env:GEOSERVER_HOME -Value "$PSScriptRoot\geoserver"

## Start
Invoke-Item -Path "$PSScriptRoot\geoserver\bin\startup.bat"

## Wait for Geoserver to start
Start-Sleep -Seconds 60

## Open console
Start-Process http://localhost:8080/geoserver