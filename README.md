# my infra as code

## Firewall

```
ufw default allow incoming
ufw default allow outgoing
ufw default allow routed
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw deny in on eno1 to any  # verify iface name
ufw enable
```

Also disable `ufw-not-local` chain in `before.rules`.
