# my infra as code

## firewall

```
ufw default deny incoming
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw allow 41641/udp
ufw enable
```
