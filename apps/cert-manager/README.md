Add the Helm repository.
```
helm repo add jetstack https://charts.jetstack.io
helm repo update
```

Install CRDs separately.
```
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.0/cert-manager.crds.yaml
```

Install cert-manager.
```
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.12.0
```

Create self-signed cluster issuer for testing purposes.
```
kubectl apply -f clusterissuer-selfsigned.yaml
```
