1. Init remote state

```bash
$ terraform init -backend-config="storage_account_name=<YourAzureStorageAccountName>" 
-backend-config="container_name=tfstate" -backend-config="access_key=<YourStorageAccountAccessKey>" 
-backend-config="key=codelab.microsoft.tfstate"
```

2. Create a plan

``` 
Optional step
$ export TF_VAR_client_id=<your-client-id>
$ export TF_VAR_client_secret=<your-client-secret>
```

```bash
$ terraform plan -out out.plan
Acquiring state lock. This may take a few moments...
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.


------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + azurerm_kubernetes_cluster.k8s
      id:                                         <computed>
#...

Plan: 2 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

This plan was saved to: out.plan

To perform exactly these actions, run the following command to apply:
    terraform apply "out.plan"

Releasing state lock. This may take a few moments...
```

3. Apply

```bash
$ terraform apply out.plan
Acquiring state lock. This may take a few moments...
Releasing state lock. This may take a few moments...
Acquiring state lock. This may take a few moments...
azurerm_resource_group.k8s: Creating...
  location: "" => "eastus"
  name:     "" => "tfsstate"
  tags.%:   "" => "<computed>"

  #...

azurerm_kubernetes_cluster.k8s: Still creating... (12m50s elapsed)
azurerm_kubernetes_cluster.k8s: Still creating... (13m0s elapsed)
azurerm_kubernetes_cluster.k8s: Still creating... (13m10s elapsed)
azurerm_kubernetes_cluster.k8s: Creation complete after 13m10s (ID: /subscriptions/c0a607b2-6372-4ef3-abdb-...tainerService/managedClusters/tfsstate)

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
Releasing state lock. This may take a few moments...

Outputs:

# Redacted
```

4. Save kube_config

```bash
$ echo "$(terraform output kube_config)" > ~/.kube/tfk8stest
```

```bash
$ export KUBECONFIG=~/.kube/tfk8stest
```
First, let's check the health of the cluster:

```bash
$ kubectl get nodes
```
You should see the details of your worker nodes, and they should all have a status Ready.


5. use terminal on mac
```bash
$ az aks install-cli
```
```bash
$ az aks get-credentials --resource-group tfs-rg --name tfk8stest
```
```bash
$ az aks browse --resource-group tfs-rg --name tfk8stest
```
