# 2. Kubernetes as runtime, kind for local development

Date: 2026-11-25

## Status

Accepted

## Context

The platform has to run its own services and also the jobs that researchers submit. Jobs need resource limits, isolation between projects and, later, scheduling on GPU nodes.

Options considered:

- **Docker Compose**: simple, but no multi-node scheduling, quotas or isolation between tenants.
- **Slurm**: the standard in HPC, but a separate world from how the platform services themselves are deployed.
- **Kubernetes**: one system for both the platform and the jobs, with namespaces, ResourceQuotas, NetworkPolicies and GPU support through device plugins.

## Decision

Use Kubernetes for everything. Each project gets its own namespace. Locally, a multi-node cluster runs with kind (Kubernetes in Docker).

## Consequences

- Isolation and quotas per project come from built-in Kubernetes features.
- The same manifests work locally and on a managed cloud cluster.
- Kubernetes adds complexity compared to Docker Compose.
- No real GPUs locally: one node is labelled as a GPU node and jobs run on CPU there.
