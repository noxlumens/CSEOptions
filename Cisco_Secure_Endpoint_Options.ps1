$question = Read-Host "`nWhat do you want to do?`n`n1:Start Amp`n2:Stop Amp`n3:Update Signatures`n4:Check Behavior Protection Engine Version`n`nOPTION" 

if ($question -eq '1') {
    $credential = Read-Host 'Enter The Administrator Password' -AsSecureString
    $plainPwd =[Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($credential))
    $start = "C:\'Program Files'\Cisco\AMP\8.2.3.30119\sfc.exe -s $plainPwd"
    Invoke-Expression $start
    $checker = Get-Service CiscoAMP
    if ($checker.Status -eq 'Running') {
        Write-Host 'Cisco Secure Endpoint is Running'
    } else {
        Write-Host "`nIncorrect Password or  Something is Preventing Service from Starting, Try Again!"
    }
    }elseif ($question -eq '2') {
    $credential = Read-Host 'Enter The Administrator Password' -AsSecureString
    $plainPwd =[Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($credential))
    $stop = "C:\'Program Files'\Cisco\AMP\8.2.3.30119\sfc.exe -k $plainPwd"
    Invoke-Expression $stop
    sleep 5
    $checker = Get-Service CiscoAMP
    if ($checker.Status -ne 'Running') {
        Write-Host 'Cisco Secure Endpoint is Stopped.'
    } else {
        Write-Host "`nIncorrect Password or Something is Preventing Service from Stopping, Try Again!"
    }
    } elseif ($question -eq '3')
{
    $credential = Read-Host 'Enter The Administrator Password' -AsSecureString
    $plainPwd =[Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($credential))
    $forceApdeUpdate = "C:\'Program Files'\Cisco\AMP\8.2.3.30119\sfc.exe -forceApdeUpdate"
    Write-Host 'Signatures Updating'
    Invoke-Expression $forceApdeUpdate
    } elseif ($question -eq '4')
{
    $AmpCLI = "C:\'Program Files'\Cisco\AMP\8.2.3.30119\AmpCLI.exe posture"
    Invoke-Expression $AmpCLI
    }else {
    Write-Host '!!! You Entered an Invalid Command!!!'
}




##### check if CIsco Secure Endpoint 8.2.3 service is "Running"
