Param (
		[string]$sourceUrl = "https://download.microsoft.com/download/B/0/0/B00291D0-5A83-4DE7-86F5-980BC00DE05A/AzureADConnect.msi"
		[string]$filePath = "C:\AzureADConnect.msi"
    )

if(!(Split-Path -parent $filepath) -or !(Test-Path -pathType Container (Split-Path -parent $filepath))) { 
      $filepath = Join-Path $pwd (Split-Path -leaf $path) 
    } 


    Invoke-WebRequest https://download.microsoft.com/download/B/0/0/B00291D0-5A83-4DE7-86F5-980BC00DE05A/AzureADConnect.msi -Outfile $FilePath
