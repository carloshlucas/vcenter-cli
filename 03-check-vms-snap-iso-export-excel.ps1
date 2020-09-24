Import-Module VMware.VimAutomation.Core
$credentials = Get-Credential
$outputfile = '.\Snapshot&CD.csv'


$vcenters = 'vcsa01.chlab.local'
foreach ($vcenter in $vcenters){
    Connect-VIServer -Server $vCenter -Credential $credentials -ErrorAction SilentlyContinue
}

 $Computer = Get-Content "E:\path\Snapshot\VM list.txt"

$output = @()
# foreach ($VM in Get-VM)
 foreach ($VM in $Computer)
{
    $VMName = $VM      
    $snapshot = Get-VM -Name $VM | Get-Snapshot | select-object -ExpandProperty Name
    $CD = Get-VM -Name $VM |Get-CDDrive | select-object -ExpandProperty IsoPath

    if ($snapshot -eq $null) {$SnapshotAvilable = "No"}
        else {$SnapshotAvilable =  "Yes"}
    if ($CD -eq $null) {$ISOattached = "No"}
        else {$ISOattached =  "Yes"}

    $output += New-Object PsObject -property @{
        'VM Name' = $VMName
        'Snapshot Avilable' = $SnapshotAvilable
        'ISO Attached' = $ISOattached
        }
}
$output | export-csv -NoTypeInformation $outputfile
