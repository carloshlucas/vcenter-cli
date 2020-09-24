#################################################
#                                               #
#    	   VM VMotion CrossVMotion              #
#                                               #
#  This script list all VM's TO THE             #
#            CORRECT VM GROUP                   #
#                                               #
#         Created by Carlos Lucas               #
#                                               #
#################################################

# GETTING CREDENTIALS

$credential = Get-Credential

# CONNECTING TO VCENTERS

$vcenters = 'chlabvcsa01.chlab.local' #CHANGE VCENTER NAME

Connect-VIServer -Server $vcenters -Credential $credential

# IMPORTING THE CSV

$checklist = Import-Csv "C:\carlos\scripts\W17\KPN SAP\KPN-W17-VM-DRS-RULES-vMotion-22-04.csv"

##### DO NOT CHANGE ANYTHING BEYOND HERE #####

# GETTING VM AND HOST INFORMATION

foreach ($VMS in $checklist){

$vm = Get-VM $VMS.NAME -Location $VMS.SOURCECLUSTER

Get-DrsClusterGroup -Name DC1-VM -Type VMGroup -Cluster $VMS.SOURCECLUSTER | Set-DrsClusterGroup -VM $VMS.Name -remove

Get-DrsClusterGroup -Name DC2-VM -Type VMGroup -Cluster $VMS.SOURCECLUSTER | Set-DrsClusterGroup -VM $VMS.Name -add

}