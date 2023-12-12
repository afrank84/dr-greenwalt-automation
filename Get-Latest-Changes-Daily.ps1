#Invoke-WebRequest -Uri https://github.com/afrank84/dr-greenwalt-automation/archive/refs/heads/main.zip -OutFile C:\stash\dr-greenwalt-automation-main.zip

# Define the URL of the GitHub ZIP file
$githubZipUrl = 'https://github.com/afrank84/dr-greenwalt-automation/archive/refs/heads/main.zip'

# Define the destination folder
$destinationFolder = 'C:\stash\'

# Define the path for the ZIP file
$zipFilePath = Join-Path -Path $destinationFolder -ChildPath 'dr-greenwalt-automation-main.zip'

# Define the extraction subfolder
$extractionSubFolder = Join-Path -Path $destinationFolder -ChildPath 'dr-greenwalt-automation-main'

# Check and create the destination folder if it does not exist
if (-not (Test-Path -Path $destinationFolder)) {
    New-Item -Path $destinationFolder -ItemType Directory
}

# Check if the extraction subfolder exists, and if so, delete it
if (Test-Path -Path $extractionSubFolder) {
    Remove-Item -Path $extractionSubFolder -Recurse -Force
}

# Download the ZIP file
Invoke-WebRequest -Uri $githubZipUrl -OutFile $zipFilePath

# Unzip the file
Expand-Archive -Path $zipFilePath -DestinationPath $destinationFolder

# Remove the ZIP file
Remove-Item -Path $zipFilePath

# Output message
Write-Host "ZIP file downloaded and extracted to $destinationFolder"


