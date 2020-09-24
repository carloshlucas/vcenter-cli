###############################################                 
#                                             #  
#                ADD DISKS                    #      
#                                             #
###############################################

### Variable

$VM = get-vm -name VMName #my case chlabvm01
$VM2 = get-vm -name VMname #my case chlabvm02


### Add a New Disk
New-HardDisk -VM $VM -CapacityGB 1 -StorageFormat EagerZeroedThick -Persistence "IndependentPersistent" -Controller "SCSI Controller 1" -Datastore $data
New-HardDisk -VM $VM -CapacityGB 200 -StorageFormat EagerZeroedThick -Persistence "IndependentPersistent" -Controller "SCSI Controller 2" -Datastore CHLABDS01_DATASTORE_01
New-HardDisk -VM $VM -CapacityGB 6 -StorageFormat EagerZeroedThick -Persistence "IndependentPersistent" -Controller "SCSI Controller 3" -Datastore CHLABDS02_DATASTORE_02
New-HardDisk -VM $VM -CapacityGB 6 -StorageFormat EagerZeroedThick -Persistence "IndependentPersistent" -Controller "SCSI Controller 3" -Datastore CHLABDS02_DATASTORE_02
New-HardDisk -VM $VM -CapacityGB 6 -StorageFormat EagerZeroedThick -Persistence "IndependentPersistent" -Controller "SCSI Controller 3" -Datastore CHLABDS01_DATASTORE_01


### Add an existent disk
New-HardDisk -VM $VM2 -DiskPath "[CHLABDS02_DATASTORE_02] chlabvm02/server1_2.vmdk" -Persistence "IndependentPersistent" -Controller "SCSI Controller 1"
New-HardDisk -VM $VM2 -DiskPath "[CHLABDS01_DATASTORE_01] chlabvm02/server1_2.vmdk" -Persistence "IndependentPersistent" -Controller "SCSI Controller 1"
New-HardDisk -VM $VM2 -DiskPath "[CHLABDS02_DATASTORE_02] chlabvm02/server1_2.vmdk" -Persistence "IndependentPersistent" -Controller "SCSI Controller 1"
New-HardDisk -VM $VM2 -DiskPath "[CHLABDS02_DATASTORE_02] chlabvm02/server1_2.vmdk" -Persistence "IndependentPersistent" -Controller "SCSI Controller 1"
New-HardDisk -VM $VM2 -DiskPath "[CHLABDS01_DATASTORE_01] chlabvm02/server1_2.vmdk" -Persistence "IndependentPersistent" -Controller "SCSI Controller 1"
