Add the Helm repository.
```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
```

Install ingress-nginx:
```
helm upgrade --install \
  -f values.yaml \
  ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --create-namespace
```

Create basic auth secret:
```
htpasswd -c auth neo  # pick a password
kubectl create secret generic basic-auth --from-file=auth
rm auth
```
