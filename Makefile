.PHONY: bootstrap
bootstrap:
	cd apps/argo-cd && \
	helm dependency update && \
	helm upgrade argo-cd ./ -f values.yaml --install