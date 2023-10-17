param variables_global_vnet_name ? /* TODO: fill in correct type */
param variables_global_var_apiVersion ? /* TODO: fill in correct type */
param variables_vnet_cidr ? /* TODO: fill in correct type */
param variables_global_vnet_subnet0_name ? /* TODO: fill in correct type */
param variables_vnet_subnet0_cidr ? /* TODO: fill in correct type */
param variables_global_vnet_subnet1_name ? /* TODO: fill in correct type */
param variables_vnet_subnet1_cidr ? /* TODO: fill in correct type */
param variables_global_vnet_subnet2_name ? /* TODO: fill in correct type */
param variables_vnet_subnet2_cidr ? /* TODO: fill in correct type */
param variables_global_vnet_subnet3_name ? /* TODO: fill in correct type */
param variables_vnet_subnet3_cidr ? /* TODO: fill in correct type */

resource variables_global_vnet_name_resource 'Microsoft.Network/virtualNetworks@[parameters(\'variables_global_var_apiVersion\')]' = {
  name: variables_global_vnet_name
  location: resourceGroup().location
  properties: {
    addressSpace: {
      addressPrefixes: [
        variables_vnet_cidr
      ]
    }
    subnets: [
      {
        name: variables_global_vnet_subnet0_name
        properties: {
          addressPrefix: variables_vnet_subnet0_cidr
        }
      }
      {
        name: variables_global_vnet_subnet1_name
        properties: {
          addressPrefix: variables_vnet_subnet1_cidr
        }
      }
      {
        name: variables_global_vnet_subnet2_name
        properties: {
          addressPrefix: variables_vnet_subnet2_cidr
        }
      }
      {
        name: variables_global_vnet_subnet3_name
        properties: {
          addressPrefix: variables_vnet_subnet3_cidr
        }
      }
    ]
  }
}