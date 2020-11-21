# Steps to create the cluster from scratch

##########################################################
# ONLY USE WHEN CLUSTER HAS TO BE CREATED THE FIRST TIME #
##########################################################

# Create namespace, crd, rbac, admin secret, storage classes and operator
kustomize build --reorder none ./common/0_essentials | kc --kubeconfig ~/.kube/config-cb-test apply -f -

# and wait for adminssion controller to be up and running

# Create volumes for first cluster node and single server cluster
kustomize build --reorder none ./common/1_cluster_base | kc --kubeconfig ~/.kube/config-cb-test apply -f -

# Create volumes for second cluster node 
kustomize build --reorder none ./common/2_scale_cluster | kc --kubeconfig ~/.kube/config-cb-test apply -f -

# Manually scale up cluster to 2

# Create volumes for third cluster node 
kustomize build --reorder none ./common/3_scale_cluster | kc --kubeconfig ~/.kube/config-cb-test apply -f -

# Manually scale up cluster to 3

# Create logs bucket
kustomize build --reorder none ./common/4_cluster_resources | kc --kubeconfig ~/.kube/config-cb-test apply -f -

# Create dedalo buckets
kustomize build overlays/quality | kc --kubeconfig ~/.kube/config-cb-test apply -f -
kustomize build overlays/production | kc --kubeconfig ~/.kube/config-cb-test apply -f -

# Create additionale resources: ingress and backup job
kustomize build . | kc --kubeconfig ~/.kube/config-cb-test apply -f -
