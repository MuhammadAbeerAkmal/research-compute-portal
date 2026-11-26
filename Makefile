CLUSTER_NAME := rcp
KIND_CONFIG  := deploy/kind/cluster.yaml
KUBE_CONTEXT := kind-$(CLUSTER_NAME)

.DEFAULT_GOAL := help
.PHONY: help cluster-up cluster-down cluster-status

help: ## Show available commands
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-16s %s\n", $$1, $$2}'

cluster-up: ## Create the local kind cluster (skips if it exists)
	@if kind get clusters | grep -qx $(CLUSTER_NAME); then \
		echo "Cluster '$(CLUSTER_NAME)' already exists"; \
	else \
		kind create cluster --config $(KIND_CONFIG) --wait 120s; \
	fi
	@kubectl cluster-info --context $(KUBE_CONTEXT)

cluster-down: ## Delete the local kind cluster
	kind delete cluster --name $(CLUSTER_NAME)

cluster-status: ## Show nodes with their pool labels
	kubectl get nodes -L node-pool,accelerator --context $(KUBE_CONTEXT)
