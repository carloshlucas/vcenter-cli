$vm = Get-Content C:\vmlist\vmstatelist.txt
$VMfile = Get-vm $vm
 
foreach($active in $VMfile){
if($active.PowerState -eq "PoweredOn"){
Stop-VM -VM $active -Confirm:$false -RunAsync | Out-Null} 
}

Start-Sleep -Seconds 10
 
foreach($delete in $VMfile){
Remove-VM -VM $delete -DeleteFromDisk -Confirm:$false -RunAsync | Out-Null}
