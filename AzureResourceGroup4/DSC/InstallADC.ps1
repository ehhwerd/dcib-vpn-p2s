Configuration GetADConnect {

Import-DSCResource -ModuleName 'PSDesiredStateConfiguration'

node localhost {
    Script script1
    {
        GetScript = {
            $File = 'C:\GetADConnect.ps1'
            $Content = 'wget https://download.microsoft.com/download/B/0/0/B00291D0-5A83-4DE7-86F5-980BC00DE05A/AzureADConnect.msi -O "C:\AzureADConnect.msi" ; Start-Process C:\AzureADConnect.msi'
            $Results = @{}
            $Results['FileExists'] = Test-path $File
            $Results['ContentMatches'] = Select-String -Path $File -SimpleMatch $Content -Quiet
 
            $Results
        }
        SetScript = {
            'wget https://download.microsoft.com/download/B/0/0/B00291D0-5A83-4DE7-86F5-980BC00DE05A/AzureADConnect.msi -O "C:\AzureADConnect.msi" ; Start-Process C:\AzureADConnect.msi' | Out-File C:\GetADConnect.ps1
        }
        TestScript = {
            $File = 'C:\GetADConnect.ps1'
            $Content = 'wget https://download.microsoft.com/download/B/0/0/B00291D0-5A83-4DE7-86F5-980BC00DE05A/AzureADConnect.msi -O "C:\AzureADConnect.msi" ; Start-Process C:\AzureADConnect.msi'
 
            If ((Test-path $File) -and (Select-String -Path $File -SimpleMatch $Content -Quiet)) {
                Write-Verbose 'Both File and Content Match'
                $True
            }
            Else {
                Write-Verbose 'Either File and/or content do not match'
                $False
            }
 
        }
    }

       Script script2
    {
        DependsOn = "[Script]script1"
        GetScript = {
            $File = 'C:\AzureADConnect.msi'
            $Results = @{}
            $Results['FileExists'] = Test-path $File
             
            $Results
        }
        SetScript = {
            Invoke-Expression C:\GetADConnect.ps1
        }
        TestScript = {
            $File = 'C:\AzureADConnect.msi'
             
            If ((Test-path $File)) {
                Write-Verbose 'AzureADConnect.msi Exists'
                $True
            }
            Else {
                Write-Verbose 'AzureADConnect.msi does not exist'
                $False
            }
 
        }
    }

    Script script3
    {
        DependsOn = "[Script]script2"
        GetScript = {
            $File = 'C:\Program Files\Microsoft Azure Active Directory Connect\AzureADConnect.exe'
            $Results = @{}
            $Results['FileExists'] = Test-path $File
             
            $Results
        }
        SetScript = {
            Start-Process C:\AzureADConnect.msi
        }
        TestScript = {
            $File = 'C:\Program Files\Microsoft Azure Active Directory Connect\AzureADConnect.exe'
             
            If ((Test-path $File)) {
                Write-Verbose 'AzureADConnect.exe Exists'
                $True
            }
            Else {
                Write-Verbose 'AzureADConnect.exe does not exist'
                $False
            }
 
        }
    }
    }
}