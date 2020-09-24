##################################################
#
#
#	 Creating PORTGROUP and PRIVATE VLAN
#
#
##################################################
--------------------------------------------------------------------------

#ADD VDS PRIVATE VLAN
Get-VDSwitch -Name "MyVDSwitch" | New-VDSwitchPrivateVlan -PrimaryVlanId 3000 -SecondaryVlanId 3000 -PrivateVlanType Promiscuous
Get-VDSwitch -Name "MyVDSwitch" | New-VDSwitchPrivateVlan -PrimaryVlanId 3000 -SecondaryVlanId 3003 -PrivateVlanType Isolated

#ADD VDS PORT GROUP AND SETTING THE PRIVATE VLAN ID
Get-VDSwitch -Name "MyVDSwitch" | New-VDPortgroup -Name "MyVDPortGroup" -NumPorts 512 | Set-VDPortgroup -Name "MyVDPortGroup" -PrivateVlanId 3003
