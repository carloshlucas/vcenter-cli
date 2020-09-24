###################################################################################################################################
#   																  #
#                           	 Script to add a new disk hot to VMware with these flags enabled				  #
#																  #
#                   Independent_Persistent | Multi-Writer | Controller Number | Unit Disk Number | EagerZeroed	       	          #
#				                                                                                                  #
#                                                      Adjusted by Carlos Lucas                                                   #
#  																  #
# Reference: http://longwhiteclouds.com/2014/06/16/gotcha-adding-disk-to-virtual-oracle-rac-cluster-with-vmware-multi-writer-flag #
#																  #
###################################################################################################################################


$vmname = Read-Host "VM Name" #VM that will receive the disk
$vmdk = Read-Host "[Datastore Path]" #Example: [Datastore1] /VM/VM_1.vmdk
[int]$busnumber = Read-Host "Controller Number"
[int]$unitnumber = Read-Host "Disk Number"

#DON'T CHANGE ANYTHING BEYOND HERE"

$vm = Get-VM $vmname
Write-Host "adding Disk "$vmdk" to "$vm" at SCSI ID "$busnumber":"$unitnumber
$ctrll = Get-ScsiController -VM $vm | ?{$_.extensiondata.busNumber -eq $busNumber}
Write-Host "Controller Key "$ctrll.extersiondata.key "$vmname"

$spec = New-Object VMware.Vim.VirtualMachineConfigSpec
$spec.deviceChange = New-Object Vmware.Vim.VirtualDeviceConfigSpec[] (1)
$spec.deviceChange[0] = New-Object Vmware.Vim.VirtualDeviceConfigSpec
$spec.deviceChange[0].operation = "add"
$spec.deviceChange[0].device = New-Object VMware.Vim.VirtualDisk
$spec.deviceChange[0].device.key = -100
$spec.deviceChange[0].device.backing = New-Object VMware.Vim.VirtualDiskFlatVer2BackingInfo
$spec.deviceChange[0].device.backing.filename = ""+$vmdk
$spec.deviceChange[0].device.backing.diskMode = "independent_persistent"
$spec.deviceChange[0].device.connectable = New-Object VMware.Vim.VirtualDeviceConnectInfo
$spec.deviceChange[0].device.connectable.startConnected = $true
$spec.deviceChange[0].device.connectable.allowGuestControl = $false
$spec.deviceChange[0].device.connectable.connected = $true
$spec.deviceChange[0].device.controllerKey = [int]$ctrll.extensiondata.Key
$spec.deviceChange[0].device.unitNumber = [int]$unitNumber
$spec.extraConfig = New-Object VMware.Vim.OptionValue[] (1)
$spec.extraConfig[0] = New-Object VMware.Vim.OptionValue
$spec.extraConfig[0].key = "scsi" + $busnumber + ":" + $unitnumber + ".sharing"
$spec.DeviceChange[0].device.Backing.Sharing = "sharingMultiWriter"
$vm.ExtensionData.ReconfigVM($spec)
