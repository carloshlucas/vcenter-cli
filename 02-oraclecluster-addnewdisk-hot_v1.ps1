###################################################################################################################################
#   																  #	
#                           	   Script to add a new disk hot to VMware with these flags enabled				  #    																															  #		
#																  #	
#                   Independent_Persistent | Multi-Writer | Controller Number | Unit Disk Number | EagerZeroed	       	          #
#																  #
#                                                     Adjusted by Carlos Lucas                                                    #
#  																  #				
#  Reference: https://www.virtuallyghetto.com/2015/10/new-method-of-enabling-multiwriter-vmdk-flag-in-vsphere-6-0-update-1.html   #  			
#																  #
###################################################################################################################################

$vmName = Read-Host "VM Name"
$vmdkFileNamePath = Read-Host "Datastore Name"
[int]$diskSizeGB = Read-Host "Disk Size"
$diskControllerNumber = Read-Host "Controller Number"
$diskUnitNumber = Read-Host "Disk Number"


#### DON'T CHANGE HERE ####

# Retrieve VM and only its Devices
$vm = Get-View -Server $server -ViewType VirtualMachine -Property Name,Config.Hardware.Device -Filter @{"Name" = $vmName}

# Converting GB to KB
$diskSizeInKB = (($diskSizeGB * 1024 * 1024 * 1024)/1KB)
$diskSizeInKB = [Math]::Round($diskSizeInKB,4,[MidPointRounding]::AwayFromZero)

# Devices on VM
$vmDevices = $vm.Config.Hardware.Device

# Find the SCSI Controller we care about
foreach ($device in $vmDevices) {
	if($device -is [VMware.Vim.VirtualSCSIController] -and $device.BusNumber -eq $diskControllerNumber) {
		$diskControllerKey = $device.key
        break
	}
}

# Create a disk: Multi-Writer Flag Enabled, Eager Zeroed, Independent_Persistent
$spec = New-Object VMware.Vim.VirtualMachineConfigSpec
$spec.deviceChange = New-Object VMware.Vim.VirtualDeviceConfigSpec
$spec.deviceChange[0].operation = 'add'
$spec.DeviceChange[0].FileOperation = 'create'
$spec.deviceChange[0].device = New-Object VMware.Vim.VirtualDisk
$spec.deviceChange[0].device.key = -1
$spec.deviceChange[0].device.ControllerKey = $diskControllerKey
$spec.deviceChange[0].device.unitNumber = $diskUnitNumber
$spec.deviceChange[0].device.CapacityInKB = $diskSizeInKB
$spec.DeviceChange[0].device.backing = New-Object VMware.Vim.VirtualDiskFlatVer2BackingInfo
$spec.DeviceChange[0].device.Backing.fileName = $vmdkFileNamePath
$spec.DeviceChange[0].device.Backing.diskMode = "independent_persistent"
$spec.DeviceChange[0].device.Backing.eagerlyScrub = $True
$spec.DeviceChange[0].device.Backing.Sharing = "sharingMultiWriter"

Write-Host "`nAdding new VMDK w/capacity $diskSizeGB GB to VM: $vmname"
$task = $vm.ReconfigVM_Task($spec)
$task1 = Get-Task -Id ("Task-$($task.value)")
$task1 | Wait-Task
