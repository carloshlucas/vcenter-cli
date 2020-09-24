###############################################                 
#                                             #  
#                POWERON VM                   #      
#                                             #
###############################################

foreach($vmlist in (Get-Content -Path C:\poweron\vmlist.txt)){
$vm = Get-VM -Name $vmlist
Start-VM -VM $vm -Confirm:$false
}
