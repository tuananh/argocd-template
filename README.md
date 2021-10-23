ArgoCD Template
---------------

![argocd logo](/images/argo-stacked-color.png)

A boilerplate to bootstrap ArgoCD

## Goals

- Keep it simple.
- ArgoCD to be managed by itself.
- High availability setup enabled by default.
- Add ArgoCD image updater/rollouts and notifications. Remove it as if you don't want those.
- Include a workaround for Vault integration.
- Follow best practices recommended by ArgoCD


## The repo structure

Basically, we will have one `Application` - the one in `_argocd` folder named `all-in-one`.

- `_misc` is for misc stuff like the custom repo server Dockerfile for reference.
- `apps` is for application manifest. A basic Helm app will have 2 files: `Chart.yaml` and `values.yaml`. I'm using Helm depedency style here so basically what we have is just empty chart with 1 dependency of the actual app I want to deploy.

## Vault integration

ArgoCD image updater has a limitation that only work with `Application` type Helm and Kustomize. At first, I was going to use [IBM/argocd-vault-plugin](https://github.com/IBM/argocd-vault-plugin) but then the application type will be `Plugin` and therefore won't work with image updater. You can subscribe to the [open issue here on Argocd image updater repo](https://github.com/argoproj-labs/argocd-image-updater/issues/168).

This repo includes a workaround until ArgoCD and image updater fix the problem upstream. Until then, we can use this workaround for Vault integration (which is kinda essential at every organizations)

So how does it work? The trick is to use a custom ArgoCD repo server and use a custom Helm binary so that ArgoCD will think that it's still Helm application. Underneath, ArgoCD will still use `helm template` and then apply the manifest. So we can find a way to trick it to use our custom `helm` binary and generate the manifest with the secrets from Vault and then it will work right?

See the custom repo server Dockerfile for more details.
## License

[MIT](./LICENSE)


