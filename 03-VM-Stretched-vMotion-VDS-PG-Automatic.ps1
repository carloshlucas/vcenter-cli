#################################################
#                                               #
#    	  VM VMotion - Different VDS            #
#                                               #
#  This script moves all VM's inside the csv    #
#                                               #
#         Created by Carlos Lucas               #
#                                               #
#################################################


# GETTING CREDENTIALS

$credential = Get-Credential

# CONNECTING TO VCENTERS

$vcenters = 'vcsa01.chlab.local' #CHANGE VCENTER NAME

Connect-VIServer -Server $vcenters -Credential $credential

# IMPORTING THE CSV

$CrossVMotion = Import-Csv "C:\VM-Stretched-vMotion-VDS-1802.csv"

##### DO NOT CHANGE ANYTHING BEYOND HERE #####

# GETTING VM AND HOST INFORMATION

foreach ($VMS in $CrossVMotion){

$vm = Get-VM $VMS.NAME -Location $VMS.SOURCECLUSTER
$networkAdapter = Get-NetworkAdapter -VM $vm
$destinationPortGroup = @()
$destinationPortGroup += Get-VDPortgroup -VDSwitch $VMS.DESTVDS -Name $networkAdapter[0].networkname
$destinationPortGroup += Get-VDPortgroup -VDSwitch $VMS.DESTVDS -Name $networkAdapter[1].networkname
$destinationPortGroup += Get-VDPortgroup -VDSwitch $VMS.DESTVDS -Name $networkAdapter[2].networkname

$vm | Move-VM -Destination (Get-VMHost $VMS.DESTHOST) -NetworkAdapter $networkAdapter -PortGroup $destinationPortGroup




}
