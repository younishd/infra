Label minio nodes.
```
kubectl label node worker-0 node-role.kubernetes.io/minio=true
```

Create the storage class.
```
kubectl apply -f storage.yaml
```

Install the chart.
```
helm upgrade --install \
  -f values.yaml \
  minio \
  oci://registry-1.docker.io/bitnamicharts/minio \
  --namespace minio \
  --create-namespace
```
