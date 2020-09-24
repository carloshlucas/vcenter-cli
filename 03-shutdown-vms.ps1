###############################################                 
#                                             #  
#              SHUTDOWN-GUEST VM              #      
#                                             #
###############################################

foreach($vmlist in (Get-Content -Path C:\Shutdown\vmlist.txt)){
$vm = Get-VM -Name $vmlist
Shutdown-VMGuest -VM $vm -Confirm:$false
}

