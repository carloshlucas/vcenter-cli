#################################################
#                                               #
#    	          VM VMotion                    #
#                                               #
#  This script moves all VM's inside the csv    #
#                                               #
#         Created by Carlos Lucas               #
#                                               #
#################################################

$VMVMotion = Import-Csv "C:\VMVMotion.csv"

foreach ($VM in $VMVMotion){

Get-VM -Name $VM.Name | Move-VM -Destination $VM.host

}

Write-Host "All VM's were moved successufuly"
