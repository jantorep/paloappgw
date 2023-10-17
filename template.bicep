@description('If creating a new VNET, anything not specified in the template will be deleted.')
@allowed([
  'Create new VNET'
  'Use existing VNET'
])
param VNETOption string = 'Create new VNET'

@description('If you are deploying a VNET to a different resource than the firewalls, the resource group MUST exist before launch.  If deploying a VNET to the same resource group as the firewalls, leave the field blank or enter the main resource group name.')
param VNETResourceGroup string = ''

@description('Enter a name for the virtual network.')
param VNETName string = 'vmseries-vnet'

@description('Enter a prefix for the virtual network.')
param VNETPrefix string = '10.0.0.0/16'

@description('Enter a subnet name for the firewall\'s management interface.')
param subnetName_Management string = 'mgmt-subnet'

@description('Enter a subnet name for the firewall\'s first dataplane interface.')
param subnetName_Dataplane1 string = 'untrust-subnet'

@description('Enter a subnet name for the firewall\'s second dataplane interface.')
param subnetName_Dataplane2 string = 'trust-subnet'

@description('Enter the subnet name for the internal load balancer.')
param subnetName_InternalLB string = 'lb-subnet'

@description('Enter a subnet prefix for the firewall\'s management interface.')
param subnetPrefix_Management string = '10.0.0.0/24'

@description('Enter a subnet prefix for the firewall\'s first dataplane interface.')
param subnetPrefix_Dataplane1 string = '10.0.1.0/24'

@description('Enter a subnet prefix for the firewall\'s second dataplane interface.')
param subnetPrefix_Dataplane2 string = '10.0.2.0/24'

@description('Enter a subnet prefix for the internal load balancer.')
param subnetPrefix_InternalLB string = '10.0.3.0/24'

@description('Enter a name for the public load balancer.')
param publicLBName string = 'vmseries-public-lb'

@description('In a comma separated list, enter the ports you want to allow in the public load balancer\'s rule base.  Every port entered will create an additional rule (i.e. 4 ports = 4 rules).')
param publicLBAllowedPorts string = '80, 443, 22, 3389'

@description('Enter a name for the internal load balancer.')
param internalLBName string = 'vmseries-internal-lb'

@description('Enter the frontend private IP of the internal load balancer.  The address must be within the load balancer subnet prefix.')
param internalLBAddress string = '10.0.3.100'

@description('Select a TCP port for the load balancer\'s health monitoring.')
@allowed([
  '80'
  '443'
])
param healthProbePort string = '80'

@description('Enter a name for the first firewall.')
param FW1_Name string = 'vmseries-fw-vm1'

@description('Enter a private IP address for firewall-1\'s management interface.')
param FW1_IPManagement string = '10.0.0.4'

@description('Enter a private IP address for firewall-1\'s first dataplane interface.')
param FW1_IPDataplane1 string = '10.0.1.4'

@description('Enter a private IP address for firewall-1\'s second dataplane interface.')
param FW1_IPDataplane2 string = '10.0.2.4'

@description('Enter a name for the second firewall.')
param FW2_Name string = 'vmseries-fw-vm2'

@description('Enter a private IP address for firewall-2\'s management interface.')
param FW2_IPManagement string = '10.0.0.5'

@description('Enter a private IP address for firewall-2\'s first dataplane interface.')
param FW2_IPDataplane1 string = '10.0.1.5'

@description('Enter a private IP address for firewall-2\'s second dataplane interface.')
param FW2_IPDataplane2 string = '10.0.2.5'

@description('More info: https://docs.paloaltonetworks.com/vm-series/8-1/vm-series-deployment/license-the-vm-series-firewall/license-typesvm-series-firewalls')
@allowed([
  'byol'
  'bundle1'
  'bundle2'
])
param licenseType string = 'byol'

@description('Select the PAN-OS version to deploy.  Selecting \'Latest\' deploys the latest available image on the Azure Marketplace. 10.1.0')
@allowed([
  'latest'
  '10.0.6'
])
param PANOSVersion string = '10.0.6'

@description('Select a VM size for the firewalls.')
@allowed([
  'Standard_D3'
  'Standard_D4'
  'Standard_D3_v2'
  'Standard_D4_v2'
  'Standard_A4'
  'Standard_DS3_v2'
  'Standard_DS4_v2'
  'Standard_DS5_v2'
])
param VMSize string = 'Standard_DS3_v2'

@description('Select the storage type for the firewall\'s OS disk. More info: https://docs.microsoft.com/en-us/azure/virtual-machines/windows/managed-disks-overview')
@allowed([
  'Standard_LRS'
  'Premium_LRS'
])
param OSDiskType string = 'Standard_LRS'

@description('Select an option for the firewall\'s availability set.  The availability set uses \'aligned\' as the SKU.')
@allowed([
  'Create new availability set'
  'Use existing availability set - Must be in firewall/main resource group'
  'Do not use availability set'
])
param availabilitySetOption string = 'Create new availability set'

@description('Enter a name for the firewall\'s availability set.  If you are not using an availability set, enter any string.')
param availabilitySetName string = 'vmseries-fw-as'

@description('Enable accelerated networking on the firewall\'s interfaces.  Only enable if you are deploying PAN-OS 9.0 or greater.')
@allowed([
  'enable (Only supported on PAN-OS 9.0 or greater)'
  'disable'
])
param acceleratedNetworking string = 'disable'

@description('Select \'Yes\' to add a public IP to the firewall\'s management interface.')
@allowed([
  'Yes'
  'No'
])
param applyPublicIPToManagement string = 'Yes'

@description('Select \'Yes\' to add a public IP to the firewall\'s first dataplane interface (i.e. untrust-interface).')
@allowed([
  'Yes'
  'No'
])
param applyPublicIPToDataplane1 string = 'Yes'

@description('Enter a name for firewall NSG.  The name entered will have \'-mgmt\' appended for the mangement NSG and \'-data\' for the dataplane NSG.')
param NSGName string = 'vmseries-nsg'

@description('Enter a valid address prefix. This address will be able to access the firewall\'s management interface over TCP/443 (GUI), and TCP/22 (Terminal).')
param NSGSourcePrefix string = '0.0.0.0/0'

@description('Enter the firewall\'s administrator username. DO NOT USE ADMIN OR ROOT.')
param username string = 'paloalto'

@description('Enter the firewall\'s administrator password. Password must be 12-72 characters and must have 3 of the following: 1 lower case character, 1 upper case character, 1 number, and 1 special character that is not slash or hyphen.')
@minLength(12)
@maxLength(72)
@secure()
param password string

@description('(Optional) To bootstrap the firewalls, enter the Azure storage account name that contains the bootstrap file share.')
param optional_BootstrapStorageAccount string = ''

@description('(Optional) To bootstrap the firewalls, enter the Azure storage account access key.')
@secure()
param optional_BootstrapAccessKey string = ''

@description('(Optional) To bootstrap the firewalls, enter the name of the Azure storage account file share that contains the bootstrap configuration.')
param optional_BootstrapFileShareName string = ''

@description('(Optional) To bootstrap from multiple bootstrap directories within the same file share, enter the subdirectory hosting the bootstrap files.')
param optional_BootstrapShareDirectory string = ''

@description('If the NAME and CONFIGURATION of the created LBs/NSGs/VMs/AVSET/VNET match an existing LBs/NSGs/VMs/AVSET/VNET in the SAME resource group, the template will its skip creation.  If the new resource NAME matches, but the resource CONFIGURATION does not, the template will fail or will overwrite the existing resource.')
param optional_AppendStringToResources string = ''

var COMMENT_global = 'GLOBAL VARIABLES SHARED AMONG DEPLOYED RESOURCES'
var global_var_resource_group = resourceGroup().name
var global_var_appendedString = ((optional_AppendStringToResources == '') ? '' : optional_AppendStringToResources)
var global_var_idleTimeoutInMinutes = 4
var global_var_allocationMethod = 'Static'
var global_var_networkVersion = 'IPv4'
var global_var_apiVersion = '2018-06-01'
var global_var_tier = 'Regional'
var global_var_sku = 'Standard'
var global_vnet_name = ((VNETOption == 'Use existing VNET') ? VNETName : take(replace(concat(VNETName, global_var_appendedString), ' ', ''), 64))
var global_vnet_resource_group = ((VNETResourceGroup == '') ? global_var_resource_group : VNETResourceGroup)
var global_vnet_option = VNETOption
var global_vnet_subnet0_name = take(replace(subnetName_Management, ' ', ''), 80)
var global_vnet_subnet1_name = take(replace(subnetName_Dataplane1, ' ', ''), 80)
var global_vnet_subnet2_name = take(replace(subnetName_Dataplane2, ' ', ''), 80)
var global_vnet_subnet3_name = take(replace(subnetName_InternalLB, ' ', ''), 80)
var global_fw_mgmtnsg_name = take(replace('${NSGName}-mgmt${global_var_appendedString}', ' ', ''), 80)
var global_fw_dataNsg_name = take(replace('${NSGName}-data${global_var_appendedString}', ' ', ''), 80)
var global_fw_interface0_pip_option = applyPublicIPToManagement
var global_fw_interface1_pip_option = applyPublicIPToDataplane1
var global_fw_storageAccountType = OSDiskType
var global_fw_adminUsername = username
var global_fw_adminPassword = password
var global_fw_diskSizeGB = 60
var global_fw_bootstrap = 'storage-account=${optional_BootstrapStorageAccount},access-key=${optional_BootstrapAccessKey},file-share=${optional_BootstrapFileShareName},share-directory=${optional_BootstrapShareDirectory}'
var global_fw_publisher = 'paloaltonetworks'
var global_fw_license = licenseType
var global_fw_version = PANOSVersion
var global_fw_product = 'vmseries-flex'
var global_fw_vmSize = VMSize
var global_fw_enableAcceleratedNetworking = ((acceleratedNetworking == 'enable (Only supported on PAN-OS 9.0 or greater)') ? 'true' : 'false')
var global_fw_avset_option = availabilitySetOption
var global_fw_avset_name = ((availabilitySetOption == 'Use existing availability set - Must be in firewall/main resource group') ? availabilitySetName : take(replace(concat(availabilitySetName, global_var_appendedString), ' ', ''), 80))
var global_fw_avset_id = {
  id: resourceId('Microsoft.Compute/availabilitySets', global_fw_avset_name)
}
var COMMENT_nsg = 'NSG TEMPLATE VARIABLES'
var nsg_mgmt_inbound_rule_name = 'allow-inbound-https-ssh'
var nsg_mgmt_inbound_rule_sourceAddress = NSGSourcePrefix
var nsg_mgmt_inbound_rule_ports = [
  '22'
  '443'
]
var nsg_data_inbound_rule_name = 'allow-all-inbound'
var nsg_data_outbound_rule_name = 'allow-all-outbound'
var COMMENT_vnet = 'NEW VNET TEMPLATE VARIABLES'
var vnet_cidr = VNETPrefix
var vnet_subnet0_cidr = subnetPrefix_Management
var vnet_subnet1_cidr = subnetPrefix_Dataplane1
var vnet_subnet2_cidr = subnetPrefix_Dataplane2
var vnet_subnet3_cidr = subnetPrefix_InternalLB
var COMMENT_publicLb = 'PUBLIC LB TEMPLATE VARIABLES'
var publicLb_name = take(replace(concat(publicLBName, global_var_appendedString), ' ', ''), 80)
var publicLb_resource_group = resourceGroup().name
var publicLb_frontend_name = 'LoadBalancerFrontEnd'
var publicLb_pool_name = 'LoadBalancerBackendPool'
var publicLb_rule_name = 'rule-'
var publicLb_rule_delimiters = [
  ','
  ';'
]
var publicLb_rule_port = split(publicLBAllowedPorts, publicLb_rule_delimiters)
var publicLb_rule_protocol = 'Tcp'
var publicLb_rule_enableTcpReset = 'false'
var publicLb_rule_loadDistribution = 'Default'
var publicLb_rule_enableFloatingIP = true
var publicLb_rule_disableOutboundSnat = 'false'
var publicLb_probe_name = 'HealthProbe'
var publicLb_probe_port = healthProbePort
var publicLb_probe_protocol = 'Tcp'
var publicLb_probe_intervalInSeconds = 5
var publicLb_probe_numberOfProbes = 2
var publicLb_pip_name = take(replace('${publicLBName}-pip${global_var_appendedString}', ' ', ''), 80)
var COMMENT_internalLb = 'INTERNAL LB TEMPLATE VARIABLES'
var internalLb_name = take(replace(concat(internalLBName, global_var_appendedString), ' ', ''), 80)
var internalLb_resource_group = resourceGroup().name
var internalLb_frontend_name = 'LoadBalancerFrontEnd'
var internalLb_frontend_ip = internalLBAddress
var internalLb_pool_name = 'LoadBalancerBackendPool'
var internalLb_rule_name = 'ha-ports'
var internalLb_rule_port = 0
var internalLb_rule_protocol = 'All'
var internalLb_rule_enableTcpReset = 'false'
var internalLb_rule_loadDistribution = 'Default'
var internalLb_rule_enableFloatingIP = true
var internalLb_rule_disableOutboundSnat = 'false'
var internalLb_probe_name = 'HealthProbe'
var internalLb_probe_port = healthProbePort
var internalLb_probe_protocol = 'Tcp'
var internalLb_probe_intervalInSeconds = 5
var internalLb_probe_numberOfProbes = 2
var COMMENT_avset = 'AV SET NESTED TEMPLATE VARIABLES (L. 805-834)'
var avset_sku = 'Aligned'
var avset_platformUpdateDomainCount = 5
var avset_platformFaultDomainCount = 2
var COMMENT_fw1 = 'FW1 TEMPLATE VARIABLES'
var fw1_computerName = take(replace(replace(concat(FW1_Name, global_var_appendedString), ' ', ''), '_', ''), 64)
var fw1_interface0_name = take(replace('${FW1_Name}-nic0${global_var_appendedString}', ' ', ''), 80)
var fw1_interface1_name = take(replace('${FW1_Name}-nic1${global_var_appendedString}', ' ', ''), 80)
var fw1_interface2_name = take(replace('${FW1_Name}-nic2${global_var_appendedString}', ' ', ''), 80)
var fw1_interface0_ip = FW1_IPManagement
var fw1_interface1_ip = FW1_IPDataplane1
var fw1_interface2_ip = FW1_IPDataplane2
var fw1_interface0_pip_name = take(replace('${FW1_Name}-nic0-pip${global_var_appendedString}', ' ', ''), 80)
var fw1_interface1_pip_name = take(replace('${FW1_Name}-nic1-pip${global_var_appendedString}', ' ', ''), 80)
var fw1_interface0_pip_id = {
  id: resourceId('Microsoft.Network/publicIPAddresses', fw1_interface0_pip_name)
}
var fw1_interface1_pip_id = {
  id: resourceId('Microsoft.Network/publicIPAddresses', fw1_interface1_pip_name)
}
var COMMENT_fw2 = 'FW2 TEMPLATE VARIABLES'
var fw2_computerName = take(replace(replace(concat(FW2_Name, global_var_appendedString), ' ', ''), '_', ''), 64)
var fw2_interface0_name = take(replace('${FW2_Name}-nic0${global_var_appendedString}', ' ', ''), 80)
var fw2_interface1_name = take(replace('${FW2_Name}-nic1${global_var_appendedString}', ' ', ''), 80)
var fw2_interface2_name = take(replace('${FW2_Name}-nic2${global_var_appendedString}', ' ', ''), 80)
var fw2_interface0_ip = FW2_IPManagement
var fw2_interface1_ip = FW2_IPDataplane1
var fw2_interface2_ip = FW2_IPDataplane2
var fw2_interface0_pip_name = take(replace('${FW2_Name}-nic0-pip${global_var_appendedString}', ' ', ''), 80)
var fw2_interface1_pip_name = take(replace('${FW2_Name}-nic1-pip${global_var_appendedString}', ' ', ''), 80)
var fw2_interface0_pip_id = {
  id: resourceId('Microsoft.Network/publicIPAddresses', fw2_interface0_pip_name)
}
var fw2_interface1_pip_id = {
  id: resourceId('Microsoft.Network/publicIPAddresses', fw2_interface1_pip_name)
}

module CREATE_NSGS './nested_CREATE_NSGS.bicep' = {
  name: 'CREATE_NSGS'
  scope: resourceGroup(resourceGroup().name)
  params: {
    variables_global_fw_mgmtnsg_name: global_fw_mgmtnsg_name
    variables_global_var_apiVersion: global_var_apiVersion
    variables_nsg_mgmt_inbound_rule_name: nsg_mgmt_inbound_rule_name
    variables_nsg_mgmt_inbound_rule_sourceAddress: nsg_mgmt_inbound_rule_sourceAddress
    variables_nsg_mgmt_inbound_rule_ports: nsg_mgmt_inbound_rule_ports
    variables_global_fw_dataNsg_name: global_fw_dataNsg_name
    variables_nsg_data_inbound_rule_name: nsg_data_inbound_rule_name
    variables_nsg_data_outbound_rule_name: nsg_data_outbound_rule_name
  }
}

module CREATE_VNET './nested_CREATE_VNET.bicep' = if (global_vnet_option == 'Create new VNET') {
  name: 'CREATE_VNET'
  scope: resourceGroup(global_vnet_resource_group)
  params: {
    variables_global_vnet_name: global_vnet_name
    variables_global_var_apiVersion: global_var_apiVersion
    variables_vnet_cidr: vnet_cidr
    variables_global_vnet_subnet0_name: global_vnet_subnet0_name
    variables_vnet_subnet0_cidr: vnet_subnet0_cidr
    variables_global_vnet_subnet1_name: global_vnet_subnet1_name
    variables_vnet_subnet1_cidr: vnet_subnet1_cidr
    variables_global_vnet_subnet2_name: global_vnet_subnet2_name
    variables_vnet_subnet2_cidr: vnet_subnet2_cidr
    variables_global_vnet_subnet3_name: global_vnet_subnet3_name
    variables_vnet_subnet3_cidr: vnet_subnet3_cidr
  }
}

module CREATE_PUBLICLB './nested_CREATE_PUBLICLB.bicep' = {
  name: 'CREATE_PUBLICLB'
  scope: resourceGroup(publicLb_resource_group)
  params: {
    resourceId_variables_publicLb_resource_group_Microsoft_Network_publicIPAddresses_variables_publicLb_pip_name: resourceId(publicLb_resource_group, 'Microsoft.Network/publicIPAddresses', publicLb_pip_name)
    resourceId_variables_publicLb_resource_group_Microsoft_Network_loadBalancers_variables_publicLb_name: resourceId(publicLb_resource_group, 'Microsoft.Network/loadBalancers', publicLb_name)
    variables_global_var_sku: global_var_sku
    variables_global_var_tier: global_var_tier
    variables_publicLb_pip_name: publicLb_pip_name
    variables_global_var_apiVersion: global_var_apiVersion
    variables_global_var_networkVersion: global_var_networkVersion
    variables_global_var_allocationMethod: global_var_allocationMethod
    variables_global_var_idleTimeoutInMinutes: global_var_idleTimeoutInMinutes
    variables_publicLb_name: publicLb_name
    variables_publicLb_frontend_name: publicLb_frontend_name
    variables_publicLb_pool_name: publicLb_pool_name
    variables_publicLb_rule_port: publicLb_rule_port
    variables_publicLb_rule_name: publicLb_rule_name
    variables_publicLb_rule_port_copyIndex_loadBalancingRules: publicLb_rule_port
    variables_publicLb_rule_enableFloatingIP: publicLb_rule_enableFloatingIP
    variables_publicLb_rule_protocol: publicLb_rule_protocol
    variables_publicLb_rule_enableTcpReset: publicLb_rule_enableTcpReset
    variables_publicLb_rule_loadDistribution: publicLb_rule_loadDistribution
    variables_publicLb_rule_disableOutboundSnat: publicLb_rule_disableOutboundSnat
    variables_publicLb_probe_name: publicLb_probe_name
    variables_publicLb_probe_protocol: publicLb_probe_protocol
    variables_publicLb_probe_port: publicLb_probe_port
    variables_publicLb_probe_intervalInSeconds: publicLb_probe_intervalInSeconds
    variables_publicLb_probe_numberOfProbes: publicLb_probe_numberOfProbes
  }
}

module CREATE_INTERNALLB './nested_CREATE_INTERNALLB.bicep' = {
  name: 'CREATE_INTERNALLB'
  scope: resourceGroup(internalLb_resource_group)
  params: {
    resourceId_variables_global_vnet_resource_group_Microsoft_Network_virtualNetworks_variables_global_vnet_name: resourceId(global_vnet_resource_group, 'Microsoft.Network/virtualNetworks', global_vnet_name)
    resourceId_variables_internalLb_resource_group_Microsoft_Network_loadBalancers_variables_internalLb_name: resourceId(internalLb_resource_group, 'Microsoft.Network/loadBalancers', internalLb_name)
    variables_global_var_sku: global_var_sku
    variables_global_var_tier: global_var_tier
    variables_internalLb_name: internalLb_name
    variables_global_var_apiVersion: global_var_apiVersion
    variables_internalLb_frontend_name: internalLb_frontend_name
    variables_internalLb_frontend_ip: internalLb_frontend_ip
    variables_global_var_allocationMethod: global_var_allocationMethod
    variables_global_vnet_subnet3_name: global_vnet_subnet3_name
    variables_internalLb_pool_name: internalLb_pool_name
    variables_internalLb_rule_name: internalLb_rule_name
    variables_internalLb_rule_port: internalLb_rule_port
    variables_internalLb_rule_enableFloatingIP: internalLb_rule_enableFloatingIP
    variables_global_var_idleTimeoutInMinutes: global_var_idleTimeoutInMinutes
    variables_internalLb_rule_protocol: internalLb_rule_protocol
    variables_internalLb_rule_enableTcpReset: internalLb_rule_enableTcpReset
    variables_internalLb_rule_loadDistribution: internalLb_rule_loadDistribution
    variables_internalLb_rule_disableOutboundSnat: internalLb_rule_disableOutboundSnat
    variables_internalLb_probe_name: internalLb_probe_name
    variables_internalLb_probe_protocol: internalLb_probe_protocol
    variables_internalLb_probe_port: internalLb_probe_port
    variables_internalLb_probe_intervalInSeconds: internalLb_probe_intervalInSeconds
    variables_internalLb_probe_numberOfProbes: internalLb_probe_numberOfProbes
  }
  dependsOn: [
    CREATE_VNET
  ]
}

module CREATE_AVSET './nested_CREATE_AVSET.bicep' = if (global_fw_avset_option == 'Create new availability set') {
  name: 'CREATE_AVSET'
  scope: resourceGroup(resourceGroup().name)
  params: {
    variables_avset_sku: avset_sku
    variables_global_fw_avset_name: global_fw_avset_name
    variables_global_var_apiVersion: global_var_apiVersion
    variables_avset_platformUpdateDomainCount: avset_platformUpdateDomainCount
    variables_avset_platformFaultDomainCount: avset_platformFaultDomainCount
  }
}

module CREATE_FW1 './nested_CREATE_FW1.bicep' = {
  name: 'CREATE_FW1'
  scope: resourceGroup(resourceGroup().name)
  params: {
    resourceId_variables_global_vnet_resource_group_Microsoft_Network_virtualNetworks_variables_global_vnet_name: resourceId(global_vnet_resource_group, 'Microsoft.Network/virtualNetworks', global_vnet_name)
    resourceId_Microsoft_Network_networkSecurityGroups_variables_global_fw_mgmtnsg_name: resourceId('Microsoft.Network/networkSecurityGroups', global_fw_mgmtnsg_name)
    resourceId_Microsoft_Network_publicIPAddresses_variables_fw1_interface0_pip_name: resourceId('Microsoft.Network/publicIPAddresses/', fw1_interface0_pip_name)
    resourceId_variables_publicLb_resource_group_Microsoft_Network_loadBalancers_variables_publicLb_name: resourceId(publicLb_resource_group, 'Microsoft.Network/loadBalancers', publicLb_name)
    resourceId_Microsoft_Network_networkSecurityGroups_variables_global_fw_dataNsg_name: resourceId('Microsoft.Network/networkSecurityGroups', global_fw_dataNsg_name)
    resourceId_Microsoft_Network_publicIPAddresses_variables_fw1_interface1_pip_name: resourceId('Microsoft.Network/publicIPAddresses/', fw1_interface1_pip_name)
    resourceId_variables_internalLb_resource_group_Microsoft_Network_loadBalancers_variables_internalLb_name: resourceId(internalLb_resource_group, 'Microsoft.Network/loadBalancers', internalLb_name)
    resourceId_Microsoft_Network_networkInterfaces_variables_fw1_interface0_name: resourceId('Microsoft.Network/networkInterfaces', fw1_interface0_name)
    resourceId_Microsoft_Network_networkInterfaces_variables_fw1_interface1_name: resourceId('Microsoft.Network/networkInterfaces', fw1_interface1_name)
    resourceId_Microsoft_Network_networkInterfaces_variables_fw1_interface2_name: resourceId('Microsoft.Network/networkInterfaces', fw1_interface2_name)
    variables_global_fw_interface0_pip_option: global_fw_interface0_pip_option
    variables_global_var_sku: global_var_sku
    variables_global_var_tier: global_var_tier
    variables_fw1_interface0_pip_name: fw1_interface0_pip_name
    variables_global_var_apiVersion: global_var_apiVersion
    variables_global_var_networkVersion: global_var_networkVersion
    variables_global_var_allocationMethod: global_var_allocationMethod
    variables_global_var_idleTimeoutInMinutes: global_var_idleTimeoutInMinutes
    variables_global_fw_interface1_pip_option: global_fw_interface1_pip_option
    variables_fw1_interface1_pip_name: fw1_interface1_pip_name
    variables_fw1_interface0_name: fw1_interface0_name
    variables_fw1_interface0_ip: fw1_interface0_ip
    variables_fw1_interface0_pip_id: fw1_interface0_pip_id
    variables_global_vnet_subnet0_name: global_vnet_subnet0_name
    variables_global_fw_enableAcceleratedNetworking: global_fw_enableAcceleratedNetworking
    variables_fw1_interface1_name: fw1_interface1_name
    variables_fw1_interface1_ip: fw1_interface1_ip
    variables_fw1_interface1_pip_id: fw1_interface1_pip_id
    variables_global_vnet_subnet1_name: global_vnet_subnet1_name
    variables_publicLb_pool_name: publicLb_pool_name
    variables_fw1_interface2_name: fw1_interface2_name
    variables_fw1_interface2_ip: fw1_interface2_ip
    variables_global_vnet_subnet2_name: global_vnet_subnet2_name
    variables_internalLb_pool_name: internalLb_pool_name
    variables_fw1_computerName: fw1_computerName
    variables_global_fw_license: global_fw_license
    variables_global_fw_product: global_fw_product
    variables_global_fw_publisher: global_fw_publisher
    variables_global_fw_avset_option: global_fw_avset_option
    variables_global_fw_avset_id: global_fw_avset_id
    variables_global_fw_vmSize: global_fw_vmSize
    variables_global_fw_version: global_fw_version
    variables_global_fw_storageAccountType: global_fw_storageAccountType
    variables_global_fw_diskSizeGB: global_fw_diskSizeGB
    variables_global_fw_adminUsername: global_fw_adminUsername
    variables_global_fw_adminPassword: global_fw_adminPassword
    variables_global_fw_bootstrap: global_fw_bootstrap
  }
  dependsOn: [
    CREATE_VNET
    CREATE_AVSET
    CREATE_NSGS
    CREATE_INTERNALLB
    CREATE_PUBLICLB
  ]
}

module CREATE_FW2 './nested_CREATE_FW2.bicep' = {
  name: 'CREATE_FW2'
  scope: resourceGroup(resourceGroup().name)
  params: {
    resourceId_variables_global_vnet_resource_group_Microsoft_Network_virtualNetworks_variables_global_vnet_name: resourceId(global_vnet_resource_group, 'Microsoft.Network/virtualNetworks', global_vnet_name)
    resourceId_Microsoft_Network_networkSecurityGroups_variables_global_fw_mgmtnsg_name: resourceId('Microsoft.Network/networkSecurityGroups', global_fw_mgmtnsg_name)
    resourceId_Microsoft_Network_publicIPAddresses_variables_fw2_interface0_pip_name: resourceId('Microsoft.Network/publicIPAddresses/', fw2_interface0_pip_name)
    resourceId_variables_publicLb_resource_group_Microsoft_Network_loadBalancers_variables_publicLb_name: resourceId(publicLb_resource_group, 'Microsoft.Network/loadBalancers', publicLb_name)
    resourceId_Microsoft_Network_networkSecurityGroups_variables_global_fw_dataNsg_name: resourceId('Microsoft.Network/networkSecurityGroups', global_fw_dataNsg_name)
    resourceId_Microsoft_Network_publicIPAddresses_variables_fw2_interface1_pip_name: resourceId('Microsoft.Network/publicIPAddresses/', fw2_interface1_pip_name)
    resourceId_variables_internalLb_resource_group_Microsoft_Network_loadBalancers_variables_internalLb_name: resourceId(internalLb_resource_group, 'Microsoft.Network/loadBalancers', internalLb_name)
    resourceId_Microsoft_Network_networkInterfaces_variables_fw2_interface0_name: resourceId('Microsoft.Network/networkInterfaces', fw2_interface0_name)
    resourceId_Microsoft_Network_networkInterfaces_variables_fw2_interface1_name: resourceId('Microsoft.Network/networkInterfaces', fw2_interface1_name)
    resourceId_Microsoft_Network_networkInterfaces_variables_fw2_interface2_name: resourceId('Microsoft.Network/networkInterfaces', fw2_interface2_name)
    variables_global_fw_interface0_pip_option: global_fw_interface0_pip_option
    variables_global_var_sku: global_var_sku
    variables_global_var_tier: global_var_tier
    variables_fw2_interface0_pip_name: fw2_interface0_pip_name
    variables_global_var_apiVersion: global_var_apiVersion
    variables_global_var_networkVersion: global_var_networkVersion
    variables_global_var_allocationMethod: global_var_allocationMethod
    variables_global_var_idleTimeoutInMinutes: global_var_idleTimeoutInMinutes
    variables_global_fw_interface1_pip_option: global_fw_interface1_pip_option
    variables_fw2_interface1_pip_name: fw2_interface1_pip_name
    variables_fw2_interface0_name: fw2_interface0_name
    variables_fw2_interface0_ip: fw2_interface0_ip
    variables_fw2_interface0_pip_id: fw2_interface0_pip_id
    variables_global_vnet_subnet0_name: global_vnet_subnet0_name
    variables_global_fw_enableAcceleratedNetworking: global_fw_enableAcceleratedNetworking
    variables_fw2_interface1_name: fw2_interface1_name
    variables_fw2_interface1_ip: fw2_interface1_ip
    variables_fw2_interface1_pip_id: fw2_interface1_pip_id
    variables_global_vnet_subnet1_name: global_vnet_subnet1_name
    variables_publicLb_pool_name: publicLb_pool_name
    variables_fw2_interface2_name: fw2_interface2_name
    variables_fw2_interface2_ip: fw2_interface2_ip
    variables_global_vnet_subnet2_name: global_vnet_subnet2_name
    variables_internalLb_pool_name: internalLb_pool_name
    variables_fw2_computerName: fw2_computerName
    variables_global_fw_license: global_fw_license
    variables_global_fw_product: global_fw_product
    variables_global_fw_publisher: global_fw_publisher
    variables_global_fw_avset_option: global_fw_avset_option
    variables_global_fw_avset_id: global_fw_avset_id
    variables_global_fw_vmSize: global_fw_vmSize
    variables_global_fw_version: global_fw_version
    variables_global_fw_storageAccountType: global_fw_storageAccountType
    variables_global_fw_diskSizeGB: global_fw_diskSizeGB
    variables_global_fw_adminUsername: global_fw_adminUsername
    variables_global_fw_adminPassword: global_fw_adminPassword
    variables_global_fw_bootstrap: global_fw_bootstrap
  }
  dependsOn: [
    CREATE_VNET
    CREATE_AVSET
    CREATE_NSGS
    CREATE_INTERNALLB
    CREATE_PUBLICLB
  ]
}