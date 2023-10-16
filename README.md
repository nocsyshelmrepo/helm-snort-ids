# Snort IDS Helm Charts

- install snort ids on ecpaas.

## Usage:

[Helm](https://helm.sh) must be installed to use the charts.
Please refer to Helm's [documentation](https://helm.sh/docs/) to get started.

```console
git clone https://git88.accton.com/squid_ro/helm-snort-ids
cd helm-snort-ids
helm install {release} -n {namespace} .
```

_See [helm install](https://helm.sh/docs/helm/helm_install/) for command documentation._

---
### Note:
Build the new snoby docker image by
```
  docker build -t ecpaas-dockerhub.ddns.net/snorby:latest -f Dockerfile.snorby .
```
---

## Configuration

| Parameter | Description | Default |
|:-----------|:-------------|:---------|
| `global.repoPrefix` | Prefix string for image repository | "ecpaas-dockerhub.ddns.net/"<br></br>ex: "k8s.gcr.io/" |
| `mysql.auth.rootPassword` | root password for sql server | test |
| `barnyard2.dbenv.username` | username for sql server | root |
| `barnyard2.dbenv.password` | password for sql server | test |
| `snortsft.service.nodeport` | nodeport of sflowtool service | 31343 |
| `snortsft.localRules` | local rules for snort | alert tcp any any -> any any (msg:"TCP Packet Detected";sid:1000010;rev:1;)<br></br>ps: just for test |
| `snorby.image.repository` | image repository for snorby | ecpaas/snorby |
| `snorby.dbenv.username` | username for sql server | root |
| `snorby.dbenv.password` | password for sql server | test |
| `snorby.service.http.nodeport` | nodeport of snorby web interface | 31333 |
| | username for snorby | snorby@snorby.org |
| | password for snorby | snorby |

