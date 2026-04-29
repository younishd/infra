# my infra as code

## Firewall

```sh
ufw default allow incoming
ufw default allow outgoing
ufw default allow routed
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
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

### Cilium cluster mesh

Establish routing between nodes:

On the node connected to the tailnet (i.e., `frozen-river`)
we advertise the node CIDR using a [subnet router](https://tailscale.com/docs/features/subnet-routers):

```sh
sudo tailscale set --advertise-routes=172.27.100.0/24
sudo tailscale up --snat-subnet-routes=false
```

On the remaining nodes (i.e., `savanna-plateau` and `pale-garden`) we add static back routes:

```yaml
network:
  …
      routes:
        - to: 100.64.0.0/10
          via: 172.27.100.10
```

## Applications

### Ceph

Ceph really likes clean disks for its OSDs. This is how we flatten the disks before creating the Ceph cluster:

```sh
sudo wipefs -a        /dev/disk/by-id/nvme-WD_Red_SN700_2000GB_000000000000
sudo sgdisk --zap-all /dev/disk/by-id/nvme-WD_Red_SN700_2000GB_000000000000
sudo blkdiscard       /dev/disk/by-id/nvme-WD_Red_SN700_2000GB_000000000000
sudo partprobe        /dev/disk/by-id/nvme-WD_Red_SN700_2000GB_000000000000
```

### Plex

Hack to claim Plex server:

```sh
kubectl port-forward -n plex service/plex-plex-media-server 32400:32400
```

http://127.0.0.1:32400/web

Then log into plex.tv and manually set the remote port to the NodePort value (32000) and disable relay.
