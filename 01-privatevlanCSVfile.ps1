####################################################################
#
# 	 Creating PRIVATE VLAN AND PORTGROUP CONSULTING A CSV FILE
#                   Created by Carlos Lucas
#
####################################################################

#### INSTRUCTIONS
### Create a csv file following these instructions below:

##NAME,PID,SID,MODE,PGNAME
#MyVDS,3000,3000,Primiscuous,PrivateVLAN-PG01
#MyVDS,3000,3003,Isolated,PrivateVLAN-PG01


#NAME = VDSName
#PID = PrimaryVlanId
#SID = SecondaryVlanId
#MODE = PrivateVlanType
#PGNAME = Portgroup

$SWITCHLIST = Import-Csv "C:\PrivateVLAN.csv"

foreach ($VDS in $SWITCHLIST){

Get-VDSwitch -Name $VDS.Name | New-VDSwitchPrivateVlan -PrimaryVlanId $VDS.PID -SecondaryVlanId $VDS.SID -PrivateVlanType $VDS.MODE
Get-VDSwitch -Name $VDS.Name | New-VDPortgroup -Name $VDS.PGNAME -NumPorts 512 | Set-VDPortgroup -Name $VDS.PGNAME -PrivateVlanId $VDS.PID
}
