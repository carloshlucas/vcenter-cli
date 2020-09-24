###############################################################################################
#                                                                                             #
#              Script to get pCPU x pCPU Ratio | Overcommit - Exporting to CSV                #
#                                                                                             #
#                              Ajusted by Carlos Lucas                                        #
#                                                                                             #
#              Reference: https://communities.vmware.com/thread/499845                        #
#                                                                                             #
###############################################################################################


&{ForEach ($esx in Get-VMHost) { 

     $vCPU = Get-VM -Location $esx | Measure-Object -Property NumCpu -Sum | select -ExpandProperty Sum 

     $esx | Select Name, 

   @{N='pCPU cores available';E={$_.NumCpu}}, 

         @{N='vCPU assigned to VMs';E={$vCPU}}, 

         @{N='Ratio';E={[math]::Round($vCPU/$_.NumCpu,1)}}, 

   @{N='CPU Overcommit (%)';E={[Math]::Round(100*(($vCPU - $_.NumCpu) / $_.NumCpu), 1)}} 

}} | Export-Csv pCPU-vCPU-ratio.csv -NoTypeInformation -UseCulture
