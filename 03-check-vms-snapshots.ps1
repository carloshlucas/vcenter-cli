#################################################
#                                               #
#    	                                        #
#                                               #
#  This script list all VM's within SNAPSHOTS   #
#                                               #
#         Created by Carlos Lucas               #
#                                               #
#################################################

# GETTING CREDENTIALS

$credential = Get-Credential

# CONNECTING TO VCENTERS

$vcenters = 'chlabvcsa01.chlab.local', 'chlabvcsa02.chlab.local' #CHANGE VCENTER NAME

Connect-VIServer -Server $vcenters -Credential $credential

# IMPORTING THE CSV

$checklist = Import-Csv "C:\carlos\scripts\snapshots.csv"

##### DO NOT CHANGE ANYTHING BEYOND HERE #####

# GETTING VM AND HOST INFORMATION

foreach ($VMS in $checklist){

Get-VM -Name $VMS.NAME | Get-Snapshot | Format-Table -Property VM,Name,Created 

}
