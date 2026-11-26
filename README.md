# research-compute-portal

A self-service portal where researchers can request compute (CPU/GPU jobs) and work with research data, running on Kubernetes.

Work in progress.

## Development

### Local cluster

Requirements: Docker, [kind](https://kind.sigs.k8s.io), kubectl, make.

```bash
make cluster-up       # 3-node cluster: control plane, general worker, simulated GPU worker
make cluster-status
make cluster-down
```

The `gpu` worker has no real GPU. It is labelled and tainted like a GPU node so scheduling rules can be tested locally.

### Pre-commit

Checks run on every commit with [pre-commit](https://pre-commit.com):

```bash
pre-commit install
pre-commit run --all-files
```

## Docs

- [Architecture](docs/architecture.md)
- [Decision records](docs/adr/)
