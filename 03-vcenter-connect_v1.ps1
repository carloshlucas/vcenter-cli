############################################################################################
#                                                                                          #
#                      Script to connect to vCenter using user and password                #
#                                                                                          #
#                                                                                          #
#                                  Created by Carlos Lucas                                 #
#                                                                                          #
############################################################################################


$vcname = "192.168.10.10"
$vcuser = "administrator@chlab.local"
$vcpass = "VMware1!"


$server = Connect-VIServer -Server $vcname -User $vcuser -Password $vcpass
