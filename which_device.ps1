# Detects new and removed devices

Write-Host "`n`nAwaiting device additions/removals..." -ForegroundColor Green
$CurrentState = $null
$NewState = $null
 
while($true) {
    if(-not($CurrentState)) {
        $CurrentState = Get-PnpDevice -Status OK
    } else {
        $NewState = Get-PnpDevice -Status OK
        $Changes = $null
        $Changes = Compare-Object -ReferenceObject $CurrentState -DifferenceObject $NewState
        if($Changes) {
            $Additions = @()
            $Removals = @()
            foreach($Change in $Changes) {
                if($Change.SideIndicator -eq "=>") {
                    $Additions += @($Change.InputObject)
                } elseif ($Change.SideIndicator -eq "<=") {
                    $Removals += @($Change.InputObject)
                }
            }
            if($Additions) {
                Write-Host "`n`nNew devices detected..." -ForegroundColor Green
                Write-Output $("="*50)
                $Additions
                Write-Output $("="*50) 
            }
           
            if($Removals) {
                Write-Host "`nDevices removed since last check..." - -ForegroundColor Red
                Write-Output $("="*50)
                $Removals
                Write-Output $("="*50)
            }
            
        }
        $CurrentState = $NewState
    }  
    Start-Sleep -Seconds 2
}