ArgoCD Template
---------------

A boilerplate to bootstrap ArgoCD

## Goals

- Keep it simple.
- ArgoCD to manage by itself.
- High availability setup enabled by default.
- Add ArgoCD image updater/rollouts and notifications. Remove it as if you don't want those.
- Include a workaround for Vault integration.


## Vault integration

ArgoCD image updater has a limitation that only work with `Application` type Helm and Kustomize. At first, I was going to use [IBM/argocd-vault-plugin](https://github.com/IBM/argocd-vault-plugin) but then the application type will be `Plugin` and therefore won't work with image updater.

This repo includes a workaround until ArgoCD and image updater fix the problem upstream. Until then, we can use this workaround for Vault integration (which is kinda essential at every organizations)

So how does it work? The trick is to use a custom ArgoCD repo server and use a custom Helm binary so that ArgoCD will think that it's still Helm application. Underneath, ArgoCD will still use `helm template` and then apply the manifest. So we can find a way to trick it to use our custom `helm` binary and generate the manifest with the secrets from Vault and then it will work right?

See the custom repo server Dockerfile for more details.
## License

MIT


