/* ========================================================================================================== */
/* Servicebus Queue module - Existing Basic Tier Namespace                                                    */
/* Laendrun - 13-02-2024                                                                                      */
/* This module creates a single Service Bus queue linked to an existing Service Bus Namespace.                */
/* This module works with Basic Tier Service Bus Namespace                                                    */
/*                                                                                                            */
/* https://learn.microsoft.com/en-us/azure/templates/microsoft.servicebus/namespaces/queues                   */
/* ========================================================================================================== */
/* Parameters definition                                                                                      */
/* ========================================================================================================== */

@description('Required. The name of the Servicebus Namespace the Servicebus Queue will be linked to.')
@minLength(6)
@maxLength(50)
param parent string

@description('Required. The name of the Servicebus Queue to create.')
@minLength(1)
@maxLength(260)
param queueName string

@description('Optional. Indicates wether this queue has dead letter support when a message arrives.')
param deadLetteringOnMessageExpiration bool = false

@description('Optional. Indicates wether server-side batched operations are enabled.')
param enableBatchedOperations bool = false

@description('Optional. Indicates wether the que should be partitioned.')
param enablePartitioning bool = false

@description('Optional. IS8061 timespan of peek-lock; Maximum value is 5 minutes.')
param lockDuration string = 'PT1M'

@description('Optional. Maximum delivery count.')
param maxDeliverycount int = 10

@description('Optional. Max queue size in Megabytes.')
@allowed([
  1024
  2048
  3072
  4096
  5120
])
param maxSizeInMegabytes int = 1024

@description('Optional. Status of the messaging entity.')
@allowed([
  'Active'
  'Creating'
  'Deleting'
  'Disabled'
  'ReceiveDisabled'
  'Renaming'
  'Restoring'
  'SendDisabled'
  'Unknown'
])
param status string = 'Active'

/* ========================================================================================================== */
/* Variables definition                                                                                       */
/* ========================================================================================================== */

/* ========================================================================================================== */
/* Resource definition                                                                                        */
/* ========================================================================================================== */

resource servicebusNamespace 'Microsoft.ServiceBus/namespaces@2022-10-01-preview' existing = {
  name: parent
}

resource servicebusQueue 'Microsoft.ServiceBus/namespaces/queues@2022-10-01-preview' = {
  name: queueName
  parent: servicebusNamespace
  properties: {
    deadLetteringOnMessageExpiration: deadLetteringOnMessageExpiration
    enableBatchedOperations: enableBatchedOperations
    enablePartitioning: enablePartitioning
    lockDuration: lockDuration
    maxDeliveryCount: maxDeliverycount
    maxSizeInMegabytes: maxSizeInMegabytes
    status: status
  }
}

/* ========================================================================================================== */
/* Output(s)                                                                                                  */
/* ========================================================================================================== */
