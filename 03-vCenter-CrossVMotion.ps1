#################################################
#                                               #
#    	   VM VMotion CrossVMotion              #
#                                               #
#  This script moves all VM's inside the csv    #
#                                               #
#         Created by Carlos Lucas               #
#                                               #
#################################################

# GETTING CREDENTIALS

$credential = Get-Credential

# CONNECTING TO VCENTERS

$vcenters = 'vcsa-01a', 'vcsa-01b' #CHANGE VCENTER NAME

Connect-VIServer -Server $vcenters -Credential $credential

# IMPORTING THE CSV

$CrossVMotion = Import-Csv "C:\script\CrossVMotion.csv"

##### DO NOT CHANGE ANYTHING BEYOND HERE #####

# GETTING VM AND HOST INFORMATION

foreach ($VMS in $CrossVMotion){

$vm = Get-VM $VMS.NAME -Location $VMS.SOURCECLUSTER
$networkAdapter = Get-NetworkAdapter -VM $vm
$destinationPortGroup = @()
$destinationPortGroup += Get-VDPortgroup -VDSwitch $VMS.VMVDS01 -Name $VMS.NETWORK1
$destinationPortGroup += Get-VDPortgroup -VDSwitch $VMS.VMVDS01 -Name $VMS.NETWORK2
$destinationPortGroup += Get-VDPortgroup -VDSwitch $VMS.VMVDS01 -Name $VMS.NETWORK3
$destinationDatastore = Get-Datastore $VMS.DATASTORE

$vm | Move-VM -Destination (Get-VMHost $VMS.DESTHOST) -NetworkAdapter $networkAdapter -PortGroup $destinationPortGroup -Datastore $destinationDatastore -DiskStorageFormat 'EagerZeroedThick'

Move-VM -VM $VMS.NAME -InventoryLocation (Get-Folder -Name $VMS.CUSTOMERSUBFOLDER -Location $VMS.CUSTOMERFOLDER)


}
