<#
.SYNOPSIS

This script downloads a nominated file and saves it in the file system at a nominated location.
.DESCRIPTION

More comprehensive description to go here.
.PARAMETER sourceURL

The sourceURL parameter specifies the file that is to be downloaded and must be a valid url with an URI of HTTP or HTTPS.
.PARAMETER filePath

The filePath specifies the location where the file will be saved on the file system.

If only a filename is provided without a path, the file will be saved in the working folder.
.EXAMPLE

Example to go here
.EXAMPLE
Second example to go here.
#>


Param (
		[string]$sourceUrl = "https://download.microsoft.com/download/B/0/0/B00291D0-5A83-4DE7-86F5-980BC00DE05A/AzureADConnect.msi",
		[string]$filePath = "C:\temp\AzureADConnect.msi"
    )

if(!(Split-Path -parent $filePath) -or !(Test-Path -pathType Container (Split-Path -parent $filePath))) { 

	# No path has been provided or the path is not a container.
      Write-Output "INFORMATION: No target path provided. Saving file to current folder."
      Write-EventLog -LogName Application -Source "GetADConnect" -EntryType Information -EventId 1 -Message "No target path provided. Saving file to current folder."

      $filePath = Join-Path $pwd (Split-Path -leaf $filePath) 
    } 


if(!(Test-Path $filePath)) {

    Invoke-WebRequest $sourceUrl -Outfile $filePath
    }
else {
    Write-Output "INFORMATION: Target file exists. No download performed."
    Write-EventLog -LogName Application -Source "GetADConnect" -EntryType Information -EventId 2 -Message "Target file exists. No download performed."
    }
    
