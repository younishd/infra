# my infra as code

## Firewall

```sh
ufw default allow incoming
ufw default allow outgoing
ufw default allow routed
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw allow 50000/tcp  # transmission
ufw allow 50000/udp  # transmission
ufw deny in on eno1 to any  # verify iface name
ufw enable
```

Also disable `ufw-not-local` chain in `before.rules`:

```
#-A ufw-before-input -j ufw-not-local
```

## Installation

Join Tailscale network and spin up RKE2 cluster:

```sh
ansible-playbook deploy.yaml
```

Same thing, but skip Tailscale step:

```sh
ansible-playbook deploy.yaml --skip-tags tailscale
```

Uninstall cluster ⚠️:

```sh
ansible all -m shell -a "sudo rke2-uninstall.sh"
```

## Cluster

Get cluster credentials:

```sh
ssh -Fssh/ovh.config bubblegum -- sudo cat /etc/rancher/rke2/rke2.yaml >~/.kube/config 2>/dev/null
```

Replace `127.0.0.1` with Tailscale Magic DNS name (e.g., `bubblegum`).

## Applications

### Plex

Hack to claim Plex server:

```sh
kubectl port-forward -n plex service/plex-plex-media-server 32400:32400
```

http://127.0.0.1:32400/web

Then log into plex.tv and manually set the remote port to the NodePort value (32000) and disable relay.
