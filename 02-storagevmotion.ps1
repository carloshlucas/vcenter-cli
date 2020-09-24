#######################################################
#													                            #
#     Script developed to perform Storage VMotion	    #
#        	   Adjusted by Carlos Lucas                 #
#                                                     #
#######################################################

$Datastore = Read-Host Get-Datastore -Name
$Customer = Read-Host "Customer"
$VMs = get-vm | Where-Object {$_.Name -match $Customer}

Foreach ($VM in $VMs)
{

Write-Host "Relocating VM:" $VM.Name "to" $Datastore
$VM | Move-VM -datastore $Datastore > $null

}

Write-Host "The VMotion was finished!"

_______________________________________________________

Another way to do the same thing.

#################################################
#												                        #
#     	      Storage VMotion		          			#
# 												                    #
# This script moves all VM's inside the csv		#
#       										#
#         Created by Carlos Lucas				#
#												#
#################################################

$SVMotion = Import-Csv "C:\SVMotion.csv"

foreach ($VM in $SVMotion){

Get-VM -Name $VM.Name | Move-VM -Datastore $VM.Datastore

}

Write-Host "All VM's were moved successufuly"
