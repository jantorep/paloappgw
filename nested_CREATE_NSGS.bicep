param variables_global_fw_mgmtnsg_name ? /* TODO: fill in correct type */
param variables_global_var_apiVersion ? /* TODO: fill in correct type */
param variables_nsg_mgmt_inbound_rule_name ? /* TODO: fill in correct type */
param variables_nsg_mgmt_inbound_rule_sourceAddress ? /* TODO: fill in correct type */
param variables_nsg_mgmt_inbound_rule_ports ? /* TODO: fill in correct type */
param variables_global_fw_dataNsg_name ? /* TODO: fill in correct type */
param variables_nsg_data_inbound_rule_name ? /* TODO: fill in correct type */
param variables_nsg_data_outbound_rule_name ? /* TODO: fill in correct type */

resource variables_global_fw_mgmtnsg_name_resource 'Microsoft.Network/networkSecurityGroups@[parameters(\'variables_global_var_apiVersion\')]' = {
  name: variables_global_fw_mgmtnsg_name
  location: resourceGroup().location
  properties: {
    securityRules: [
      {
        name: variables_nsg_mgmt_inbound_rule_name
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: variables_nsg_mgmt_inbound_rule_sourceAddress
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: '100'
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: variables_nsg_mgmt_inbound_rule_ports
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

resource variables_global_fw_dataNsg_name_resource 'Microsoft.Network/networkSecurityGroups@[parameters(\'variables_global_var_apiVersion\')]' = {
  name: variables_global_fw_dataNsg_name
  location: resourceGroup().location
  properties: {
    securityRules: [
      {
        name: variables_nsg_data_inbound_rule_name
        properties: {
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: '100'
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: variables_nsg_data_outbound_rule_name
        properties: {
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: '100'
          direction: 'Outbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}