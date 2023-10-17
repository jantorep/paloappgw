param variables_avset_sku ? /* TODO: fill in correct type */
param variables_global_fw_avset_name ? /* TODO: fill in correct type */
param variables_global_var_apiVersion ? /* TODO: fill in correct type */
param variables_avset_platformUpdateDomainCount ? /* TODO: fill in correct type */
param variables_avset_platformFaultDomainCount ? /* TODO: fill in correct type */

resource variables_global_fw_avset_name_resource 'Microsoft.Compute/availabilitySets@[parameters(\'variables_global_var_apiVersion\')]' = {
  sku: {
    name: variables_avset_sku
  }
  name: variables_global_fw_avset_name
  location: resourceGroup().location
  properties: {
    platformUpdateDomainCount: variables_avset_platformUpdateDomainCount
    platformFaultDomainCount: variables_avset_platformFaultDomainCount
  }
}