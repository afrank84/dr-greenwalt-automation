#Invoke-WebRequest -Uri https://github.com/afrank84/dr-greenwalt-automation/archive/refs/heads/main.zip -OutFile C:\stash\dr-greenwalt-automation-main.zip

$owner = "username"
$repo = "repository"
$branch = "main"
$localFile = "path\to\local\commitSHA.txt"

# Function to get the latest commit SHA from GitHub
function Get-LatestCommitSHA {
    $uri = "https://api.github.com/repos/$owner/$repo/commits/$branch"
    $response = Invoke-RestMethod -Uri $uri -Headers @{ "User-Agent" = "PowerShell" }
    return $response.sha
}

# Read the last known commit SHA
$lastKnownSHA = ""
if (Test-Path $localFile) {
    $lastKnownSHA = Get-Content $localFile
}

# Get the latest commit SHA from GitHub
$latestSHA = Get-LatestCommitSHA

# Compare and download if different
if ($latestSHA -ne $lastKnownSHA) {
    $downloadUrl = "https://github.com/$owner/$repo/archive/$branch.zip"
    $outputFile = "$repo-$branch.zip"
    Invoke-WebRequest -Uri $downloadUrl -OutFile $outputFile
    # Optionally, extract the ZIP file as shown in previous answer
    # Update the local commit SHA file
    $latestSHA | Set-Content $localFile
    Write-Host "Repository updated and downloaded."
} else {
    Write-Host "Repository is up-to-date. No download required."
}

