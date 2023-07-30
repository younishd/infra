# Is this ✨ _Infrastructure as Code_ ✨

Get K8s cluster authentication token.
```sh
ssh -Fssh/hcloud.config master-0 -- cat /etc/rancher/rke2/rke2.yaml >~/.kube/config 2>/dev/null
```

Locally forward K8s API port via SSH.
```sh
ssh -Fssh/hcloud.config -nNTL6443:localhost:6443 master-0
```
