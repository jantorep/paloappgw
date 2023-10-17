param resourceId_variables_global_vnet_resource_group_Microsoft_Network_virtualNetworks_variables_global_vnet_name string
param resourceId_variables_internalLb_resource_group_Microsoft_Network_loadBalancers_variables_internalLb_name string
param variables_global_var_sku ? /* TODO: fill in correct type */
param variables_global_var_tier ? /* TODO: fill in correct type */
param variables_internalLb_name ? /* TODO: fill in correct type */
param variables_global_var_apiVersion ? /* TODO: fill in correct type */
param variables_internalLb_frontend_name ? /* TODO: fill in correct type */
param variables_internalLb_frontend_ip ? /* TODO: fill in correct type */
param variables_global_var_allocationMethod ? /* TODO: fill in correct type */
param variables_global_vnet_subnet3_name ? /* TODO: fill in correct type */
param variables_internalLb_pool_name ? /* TODO: fill in correct type */
param variables_internalLb_rule_name ? /* TODO: fill in correct type */
param variables_internalLb_rule_port ? /* TODO: fill in correct type */
param variables_internalLb_rule_enableFloatingIP ? /* TODO: fill in correct type */
param variables_global_var_idleTimeoutInMinutes ? /* TODO: fill in correct type */
param variables_internalLb_rule_protocol ? /* TODO: fill in correct type */
param variables_internalLb_rule_enableTcpReset ? /* TODO: fill in correct type */
param variables_internalLb_rule_loadDistribution ? /* TODO: fill in correct type */
param variables_internalLb_rule_disableOutboundSnat ? /* TODO: fill in correct type */
param variables_internalLb_probe_name ? /* TODO: fill in correct type */
param variables_internalLb_probe_protocol ? /* TODO: fill in correct type */
param variables_internalLb_probe_port ? /* TODO: fill in correct type */
param variables_internalLb_probe_intervalInSeconds ? /* TODO: fill in correct type */
param variables_internalLb_probe_numberOfProbes ? /* TODO: fill in correct type */

resource variables_internalLb_name_resource 'Microsoft.Network/loadBalancers@[parameters(\'variables_global_var_apiVersion\')]' = {
  sku: {
    name: variables_global_var_sku
    tier: variables_global_var_tier
  }
  name: variables_internalLb_name
  location: resourceGroup().location
  properties: {
    frontendIPConfigurations: [
      {
        name: variables_internalLb_frontend_name
        properties: {
          privateIPAddress: variables_internalLb_frontend_ip
          privateIPAllocationMethod: variables_global_var_allocationMethod
          subnet: {
            id: '${resourceId_variables_global_vnet_resource_group_Microsoft_Network_virtualNetworks_variables_global_vnet_name}/subnets/${variables_global_vnet_subnet3_name}'
          }
        }
      }
    ]
    backendAddressPools: [
      {
        name: variables_internalLb_pool_name
      }
    ]
    loadBalancingRules: [
      {
        name: variables_internalLb_rule_name
        properties: {
          frontendIPConfiguration: {
            id: '${resourceId_variables_internalLb_resource_group_Microsoft_Network_loadBalancers_variables_internalLb_name}/frontendIPConfigurations/${variables_internalLb_frontend_name}'
          }
          frontendPort: variables_internalLb_rule_port
          backendPort: variables_internalLb_rule_port
          enableFloatingIP: variables_internalLb_rule_enableFloatingIP
          idleTimeoutInMinutes: variables_global_var_idleTimeoutInMinutes
          protocol: variables_internalLb_rule_protocol
          enableTcpReset: variables_internalLb_rule_enableTcpReset
          loadDistribution: variables_internalLb_rule_loadDistribution
          disableOutboundSnat: variables_internalLb_rule_disableOutboundSnat
          backendAddressPool: {
            id: '${resourceId_variables_internalLb_resource_group_Microsoft_Network_loadBalancers_variables_internalLb_name}/backendAddressPools/${variables_internalLb_pool_name}'
          }
          probe: {
            id: '${resourceId_variables_internalLb_resource_group_Microsoft_Network_loadBalancers_variables_internalLb_name}/probes/${variables_internalLb_probe_name}'
          }
        }
      }
    ]
    probes: [
      {
        name: variables_internalLb_probe_name
        properties: {
          protocol: variables_internalLb_probe_protocol
          port: variables_internalLb_probe_port
          intervalInSeconds: variables_internalLb_probe_intervalInSeconds
          numberOfProbes: variables_internalLb_probe_numberOfProbes
        }
      }
    ]
  }
}