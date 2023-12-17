# Infra etc.

```sh
ssh -Fssh/hcloud.config hzn-master-0 -- cat /etc/rancher/rke2/rke2.yaml >~/.kube/config 2>/dev/null
ssh -Fssh/hcloud.config -nNTL6443:localhost:6443 hzn-master-0
kubectl port-forward svc/argo-cd-argocd-server -n argo-cd 8080:443
```
