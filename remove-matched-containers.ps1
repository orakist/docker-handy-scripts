# Author: Orhan Ak

# This is a windows powershell script that can help to easily remove matched containers.
# This script can be very useful if want to remove all containers whose name starts with a spesific query string. 
# Example usage: .\remove-matched-containers.ps1 container-name

# Get container name parameter
param ([string]$containerName)

Write-Host "[+] Check Matched Containers ($containerName): Busy" -NoNewLine
$matchedContainers = docker container ls -a -f "name=$containerName" --format "{{.Names}}\t{{.ID}}" |
                        ConvertFrom-CSV -Delimiter "`t" -Header ("Name","Id")
$objectCount = ($matchedContainers | Measure-Object).Count
Write-Host "`r[+] Remove Matched Containers ($containerName): -$objectCount-"

if ($objectCount -gt 0)
{
    $maxLength = ($matchedContainers | select -ExpandProperty Name | Measure-Object -Maximum -Property Length).Maximum + 15
    foreach($container in $matchedContainers)
    {
        $name = $container.Name
        Write-Host ("{0,-$maxLength}{1,0}" -f " - Container $name", "Stopping") -NoNewLine
        docker container stop $container.Id > $null 2>&1
        Write-Host ("{0,-$maxLength}{1,0}" -f "`r - Container $name", " Removing") -NoNewLine
        docker container rm $container.Id > $null 2>&1
        Write-Host ("{0,-$maxLength}{1,0}" -f "`r - Container $name", " Removed ")
    }
}
else
{
    Write-Host " - There is not any matched containers."
}
