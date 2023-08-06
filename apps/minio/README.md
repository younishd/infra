Label minio nodes.
```
kubectl label node worker-0 node-role.kubernetes.io/storage=true
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

Create the PV and PVC.
```
kubectl apply -f storage.yaml
```
