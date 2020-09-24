###############################################                 
#                                             #  
#         CREATING VDS PORTGROUP              #      
#                                             #
###############################################

Get-VDSwitch -Name "MyVDSwitch" | New-VDPortgroup -Name "MyVDPortGroup_1" -NumPorts 512 -VLanId 1
Get-VDSwitch -Name "MyVDSwitch" | New-VDPortgroup -Name "MyVDPortGroup_2" -NumPorts 512 -VLanId 2
Get-VDSwitch -Name "MyVDSwitch" | New-VDPortgroup -Name "MyVDPortGroup_3" -NumPorts 512 -VLanId 3
Get-VDSwitch -Name "MyVDSwitch" | New-VDPortgroup -Name "MyVDPortGroup_4" -NumPorts 512 -VLanId 4
Get-VDSwitch -Name "MyVDSwitch" | New-VDPortgroup -Name "MyVDPortGroup_5" -NumPorts 512 -VLanId 5
