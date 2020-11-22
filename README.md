# Couchbase test data generator

Based on [LargeDatasetGenerator](https://github.com/couchbaselabs/couchbase-mobile-tools/tree/master/LargeDatasetGenerator), creates a dataset of appointments to work with. 

## Usage

Assuming that you have aliased LargeDatasetGenerator executable to `large-dataset-generator`

### Testing to local file

`large-dataset-generator --count 10 -i ./DocTemplate.json -o file --filename ./out.json`


## On a cloud cluster

### Create K8s cluster
To create a suitable cluster in Google Cloud (it's certified for CB operator), just run the `./k8s/create-gke-cluster.sh` script, it will create a 3 worker nodes cluster with 4 cpus and 16 GB RAM per node. Once created you can connect with `./k8s/connect-cluster.sh` or equivalent cmd you con get from gcloud web console.

### Create Couchbase cluster
Once K8s cluster is up and running you can deploy CB cluster with the following:
```shell
kustomize build couchbase | kc apply -f -
```
First time custom resources creation will fail, wait for admission controller ready and then re-run the command. Then move to `couchbase` namespace to observe cluster evolution
```
kubectl config set-context --current --namespace couchbase
```


