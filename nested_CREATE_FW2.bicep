param resourceId_variables_global_vnet_resource_group_Microsoft_Network_virtualNetworks_variables_global_vnet_name string
param resourceId_Microsoft_Network_networkSecurityGroups_variables_global_fw_mgmtnsg_name string
param resourceId_Microsoft_Network_publicIPAddresses_variables_fw2_interface0_pip_name string
param resourceId_variables_publicLb_resource_group_Microsoft_Network_loadBalancers_variables_publicLb_name string
param resourceId_Microsoft_Network_networkSecurityGroups_variables_global_fw_dataNsg_name string
param resourceId_Microsoft_Network_publicIPAddresses_variables_fw2_interface1_pip_name string
param resourceId_variables_internalLb_resource_group_Microsoft_Network_loadBalancers_variables_internalLb_name string
param resourceId_Microsoft_Network_networkInterfaces_variables_fw2_interface0_name string
param resourceId_Microsoft_Network_networkInterfaces_variables_fw2_interface1_name string
param resourceId_Microsoft_Network_networkInterfaces_variables_fw2_interface2_name string
param variables_global_fw_interface0_pip_option ? /* TODO: fill in correct type */
param variables_global_var_sku ? /* TODO: fill in correct type */
param variables_global_var_tier ? /* TODO: fill in correct type */
param variables_fw2_interface0_pip_name ? /* TODO: fill in correct type */
param variables_global_var_apiVersion ? /* TODO: fill in correct type */
param variables_global_var_networkVersion ? /* TODO: fill in correct type */
param variables_global_var_allocationMethod ? /* TODO: fill in correct type */
param variables_global_var_idleTimeoutInMinutes ? /* TODO: fill in correct type */
param variables_global_fw_interface1_pip_option ? /* TODO: fill in correct type */
param variables_fw2_interface1_pip_name ? /* TODO: fill in correct type */
param variables_fw2_interface0_name ? /* TODO: fill in correct type */
param variables_fw2_interface0_ip ? /* TODO: fill in correct type */
param variables_fw2_interface0_pip_id ? /* TODO: fill in correct type */
param variables_global_vnet_subnet0_name ? /* TODO: fill in correct type */
param variables_global_fw_enableAcceleratedNetworking ? /* TODO: fill in correct type */
param variables_fw2_interface1_name ? /* TODO: fill in correct type */
param variables_fw2_interface1_ip ? /* TODO: fill in correct type */
param variables_fw2_interface1_pip_id ? /* TODO: fill in correct type */
param variables_global_vnet_subnet1_name ? /* TODO: fill in correct type */
param variables_publicLb_pool_name ? /* TODO: fill in correct type */
param variables_fw2_interface2_name ? /* TODO: fill in correct type */
param variables_fw2_interface2_ip ? /* TODO: fill in correct type */
param variables_global_vnet_subnet2_name ? /* TODO: fill in correct type */
param variables_internalLb_pool_name ? /* TODO: fill in correct type */
param variables_fw2_computerName ? /* TODO: fill in correct type */
param variables_global_fw_license ? /* TODO: fill in correct type */
param variables_global_fw_product ? /* TODO: fill in correct type */
param variables_global_fw_publisher ? /* TODO: fill in correct type */
param variables_global_fw_avset_option ? /* TODO: fill in correct type */
param variables_global_fw_avset_id ? /* TODO: fill in correct type */
param variables_global_fw_vmSize ? /* TODO: fill in correct type */
param variables_global_fw_version ? /* TODO: fill in correct type */
param variables_global_fw_storageAccountType ? /* TODO: fill in correct type */
param variables_global_fw_diskSizeGB ? /* TODO: fill in correct type */
param variables_global_fw_adminUsername ? /* TODO: fill in correct type */
param variables_global_fw_adminPassword ? /* TODO: fill in correct type */
param variables_global_fw_bootstrap ? /* TODO: fill in correct type */

resource variables_fw2_interface0_pip_name_resource 'Microsoft.Network/publicIPAddresses@[parameters(\'variables_global_var_apiVersion\')]' = if (variables_global_fw_interface0_pip_option == 'Yes') {
  sku: {
    name: variables_global_var_sku
    tier: variables_global_var_tier
  }
  name: variables_fw2_interface0_pip_name
  location: resourceGroup().location
  properties: {
    publicIPAddressVersion: variables_global_var_networkVersion
    publicIPAllocationMethod: variables_global_var_allocationMethod
    idleTimeoutInMinutes: variables_global_var_idleTimeoutInMinutes
  }
}

resource variables_fw2_interface1_pip_name_resource 'Microsoft.Network/publicIPAddresses@[parameters(\'variables_global_var_apiVersion\')]' = if (variables_global_fw_interface1_pip_option == 'Yes') {
  sku: {
    name: variables_global_var_sku
    tier: variables_global_var_tier
  }
  name: variables_fw2_interface1_pip_name
  location: resourceGroup().location
  properties: {
    publicIPAddressVersion: variables_global_var_networkVersion
    publicIPAllocationMethod: variables_global_var_allocationMethod
    idleTimeoutInMinutes: variables_global_var_idleTimeoutInMinutes
  }
}

resource variables_fw2_interface0_name_resource 'Microsoft.Network/networkInterfaces@[parameters(\'variables_global_var_apiVersion\')]' = {
  name: variables_fw2_interface0_name
  location: resourceGroup().location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIpAddress: variables_fw2_interface0_ip
          privateIPAllocationMethod: variables_global_var_allocationMethod
          publicIpAddress: ((variables_global_fw_interface0_pip_option == 'Yes') ? variables_fw2_interface0_pip_id : json('null'))
          subnet: {
            id: '${resourceId_variables_global_vnet_resource_group_Microsoft_Network_virtualNetworks_variables_global_vnet_name}/subnets/${variables_global_vnet_subnet0_name}'
          }
          primary: true
          privateIPAddressVersion: variables_global_var_networkVersion
        }
      }
    ]
    enableAcceleratedNetworking: variables_global_fw_enableAcceleratedNetworking
    enableIPForwarding: false
    networkSecurityGroup: {
      id: resourceId_Microsoft_Network_networkSecurityGroups_variables_global_fw_mgmtnsg_name
    }
    tapConfigurations: []
  }
  dependsOn: [
    resourceId_Microsoft_Network_publicIPAddresses_variables_fw2_interface0_pip_name
  ]
}

resource variables_fw2_interface1_name_resource 'Microsoft.Network/networkInterfaces@[parameters(\'variables_global_var_apiVersion\')]' = {
  name: variables_fw2_interface1_name
  location: resourceGroup().location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIpAddress: variables_fw2_interface1_ip
          privateIPAllocationMethod: variables_global_var_allocationMethod
          publicIpAddress: ((variables_global_fw_interface1_pip_option == 'Yes') ? variables_fw2_interface1_pip_id : json('null'))
          subnet: {
            id: '${resourceId_variables_global_vnet_resource_group_Microsoft_Network_virtualNetworks_variables_global_vnet_name}/subnets/${variables_global_vnet_subnet1_name}'
          }
          primary: true
          privateIPAddressVersion: variables_global_var_networkVersion
          loadBalancerBackendAddressPools: [
            {
              id: '${resourceId_variables_publicLb_resource_group_Microsoft_Network_loadBalancers_variables_publicLb_name}/backendAddressPools/${variables_publicLb_pool_name}'
            }
          ]
        }
      }
    ]
    enableAcceleratedNetworking: variables_global_fw_enableAcceleratedNetworking
    enableIPForwarding: true
    networkSecurityGroup: {
      id: resourceId_Microsoft_Network_networkSecurityGroups_variables_global_fw_dataNsg_name
    }
    tapConfigurations: []
  }
  dependsOn: [
    resourceId_Microsoft_Network_publicIPAddresses_variables_fw2_interface1_pip_name
  ]
}

resource variables_fw2_interface2_name_resource 'Microsoft.Network/networkInterfaces@[parameters(\'variables_global_var_apiVersion\')]' = {
  name: variables_fw2_interface2_name
  location: resourceGroup().location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIpAddress: variables_fw2_interface2_ip
          privateIPAllocationMethod: variables_global_var_allocationMethod
          subnet: {
            id: '${resourceId_variables_global_vnet_resource_group_Microsoft_Network_virtualNetworks_variables_global_vnet_name}/subnets/${variables_global_vnet_subnet2_name}'
          }
          primary: true
          privateIPAddressVersion: variables_global_var_networkVersion
          loadBalancerBackendAddressPools: [
            {
              id: '${resourceId_variables_internalLb_resource_group_Microsoft_Network_loadBalancers_variables_internalLb_name}/backendAddressPools/${variables_internalLb_pool_name}'
            }
          ]
        }
      }
    ]
    enableAcceleratedNetworking: variables_global_fw_enableAcceleratedNetworking
    enableIPForwarding: true
    networkSecurityGroup: {
      id: resourceId_Microsoft_Network_networkSecurityGroups_variables_global_fw_dataNsg_name
    }
    tapConfigurations: []
  }
}

resource variables_fw2_computer 'Microsoft.Compute/virtualMachines@[parameters(\'variables_global_var_apiVersion\')]' = {
  name: variables_fw2_computerName
  location: resourceGroup().location
  plan: {
    name: variables_global_fw_license
    product: variables_global_fw_product
    publisher: variables_global_fw_publisher
  }
  properties: {
    availabilitySet: ((variables_global_fw_avset_option == 'Do not use availability set') ? json('null') : variables_global_fw_avset_id)
    hardwareProfile: {
      vmSize: variables_global_fw_vmSize
    }
    storageProfile: {
      imageReference: {
        publisher: variables_global_fw_publisher
        offer: variables_global_fw_product
        sku: variables_global_fw_license
        version: variables_global_fw_version
      }
      osDisk: {
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: variables_global_fw_storageAccountType
        }
        diskSizeGB: variables_global_fw_diskSizeGB
      }
    }
    osProfile: {
      computerName: variables_fw2_computerName
      adminUsername: variables_global_fw_adminUsername
      adminPassword: variables_global_fw_adminPassword
      customData: base64(variables_global_fw_bootstrap)
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: resourceId_Microsoft_Network_networkInterfaces_variables_fw2_interface0_name
          properties: {
            primary: true
          }
        }
        {
          id: resourceId_Microsoft_Network_networkInterfaces_variables_fw2_interface1_name
          properties: {
            primary: false
          }
        }
        {
          id: resourceId_Microsoft_Network_networkInterfaces_variables_fw2_interface2_name
          properties: {
            primary: false
          }
        }
      ]
    }
  }
  dependsOn: [
    resourceId_Microsoft_Network_networkInterfaces_variables_fw2_interface0_name
    resourceId_Microsoft_Network_networkInterfaces_variables_fw2_interface1_name
    resourceId_Microsoft_Network_networkInterfaces_variables_fw2_interface2_name
  ]
}