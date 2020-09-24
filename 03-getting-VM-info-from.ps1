###############################################                 
#                                             #  
#              LIST VM FROM TXT               #      
#                                             #
###############################################

$vmList = Get-Content C:\vmlist\vmstatelist.txt
foreach ($vmName in $vmList) {Get-VM $vmName | Select-Object -Property Name,Memory,PowerState,Folder | FT -AutoSize}
