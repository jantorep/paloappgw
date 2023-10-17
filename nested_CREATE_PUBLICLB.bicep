param resourceId_variables_publicLb_resource_group_Microsoft_Network_publicIPAddresses_variables_publicLb_pip_name string
param resourceId_variables_publicLb_resource_group_Microsoft_Network_loadBalancers_variables_publicLb_name string
param variables_global_var_sku ? /* TODO: fill in correct type */
param variables_global_var_tier ? /* TODO: fill in correct type */
param variables_publicLb_pip_name ? /* TODO: fill in correct type */
param variables_global_var_apiVersion ? /* TODO: fill in correct type */
param variables_global_var_networkVersion ? /* TODO: fill in correct type */
param variables_global_var_allocationMethod ? /* TODO: fill in correct type */
param variables_global_var_idleTimeoutInMinutes ? /* TODO: fill in correct type */
param variables_publicLb_name ? /* TODO: fill in correct type */
param variables_publicLb_frontend_name ? /* TODO: fill in correct type */
param variables_publicLb_pool_name ? /* TODO: fill in correct type */
param variables_publicLb_rule_port ? /* TODO: fill in correct type */
param variables_publicLb_rule_name ? /* TODO: fill in correct type */
param variables_publicLb_rule_port_copyIndex_loadBalancingRules ? /* TODO: fill in correct type */
param variables_publicLb_rule_enableFloatingIP ? /* TODO: fill in correct type */
param variables_publicLb_rule_protocol ? /* TODO: fill in correct type */
param variables_publicLb_rule_enableTcpReset ? /* TODO: fill in correct type */
param variables_publicLb_rule_loadDistribution ? /* TODO: fill in correct type */
param variables_publicLb_rule_disableOutboundSnat ? /* TODO: fill in correct type */
param variables_publicLb_probe_name ? /* TODO: fill in correct type */
param variables_publicLb_probe_protocol ? /* TODO: fill in correct type */
param variables_publicLb_probe_port ? /* TODO: fill in correct type */
param variables_publicLb_probe_intervalInSeconds ? /* TODO: fill in correct type */
param variables_publicLb_probe_numberOfProbes ? /* TODO: fill in correct type */

resource variables_publicLb_pip_name_resource 'Microsoft.Network/publicIPAddresses@[parameters(\'variables_global_var_apiVersion\')]' = {
  sku: {
    name: variables_global_var_sku
    tier: variables_global_var_tier
  }
  name: variables_publicLb_pip_name
  location: resourceGroup().location
  properties: {
    publicIPAddressVersion: variables_global_var_networkVersion
    publicIPAllocationMethod: variables_global_var_allocationMethod
    idleTimeoutInMinutes: variables_global_var_idleTimeoutInMinutes
  }
}

resource variables_publicLb_name_resource 'Microsoft.Network/loadBalancers@[parameters(\'variables_global_var_apiVersion\')]' = {
  sku: {
    name: variables_global_var_sku
  }
  name: variables_publicLb_name
  location: resourceGroup().location
  properties: {
    frontendIPConfigurations: [
      {
        name: variables_publicLb_frontend_name
        properties: {
          publicIPAddress: {
            id: resourceId_variables_publicLb_resource_group_Microsoft_Network_publicIPAddresses_variables_publicLb_pip_name
          }
        }
      }
    ]
    backendAddressPools: [
      {
        name: variables_publicLb_pool_name
      }
    ]
    loadBalancingRules: [for j in range(0, length(variables_publicLb_rule_port)): {
      name: concat(variables_publicLb_rule_name, j)
      properties: {
        frontendIPConfiguration: {
          id: '${resourceId_variables_publicLb_resource_group_Microsoft_Network_loadBalancers_variables_publicLb_name}/frontendIPConfigurations/${variables_publicLb_frontend_name}'
        }
        frontendPort: variables_publicLb_rule_port_copyIndex_loadBalancingRules[j]
        backendPort: variables_publicLb_rule_port_copyIndex_loadBalancingRules[j]
        enableFloatingIP: variables_publicLb_rule_enableFloatingIP
        idleTimeoutInMinutes: variables_global_var_idleTimeoutInMinutes
        protocol: variables_publicLb_rule_protocol
        enableTcpReset: variables_publicLb_rule_enableTcpReset
        loadDistribution: variables_publicLb_rule_loadDistribution
        disableOutboundSnat: variables_publicLb_rule_disableOutboundSnat
        backendAddressPool: {
          id: '${resourceId_variables_publicLb_resource_group_Microsoft_Network_loadBalancers_variables_publicLb_name}/backendAddressPools/${variables_publicLb_pool_name}'
        }
        probe: {
          id: '${resourceId_variables_publicLb_resource_group_Microsoft_Network_loadBalancers_variables_publicLb_name}/probes/${variables_publicLb_probe_name}'
        }
      }
    }]
    probes: [
      {
        name: variables_publicLb_probe_name
        properties: {
          protocol: variables_publicLb_probe_protocol
          port: variables_publicLb_probe_port
          intervalInSeconds: variables_publicLb_probe_intervalInSeconds
          numberOfProbes: variables_publicLb_probe_numberOfProbes
        }
      }
    ]
  }
  dependsOn: [
    resourceId_variables_publicLb_resource_group_Microsoft_Network_publicIPAddresses_variables_publicLb_pip_name
  ]
}