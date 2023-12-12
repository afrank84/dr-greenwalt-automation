# Define the URL of the file to download
$url = "https://raw.githubusercontent.com/afrank84/dr-greenwalt-automation/main/Automate-Desktop.ps1"

# Define the path where the file will be saved
$destination = "C:\stash\dr-greenwalt-automation\Automate-Desktop.ps1"  # Change the path as needed

# Use Invoke-WebRequest to download the file
Invoke-WebRequest -Uri $url -OutFile $destination
