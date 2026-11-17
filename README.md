# linuxtips-gitops-gke

Terraform and GitHub Actions that build the GKE platform for the **[linuxtips-gitops](https://github.com/LuisGustavoBR/linuxtips-gitops)** learning path: a VPC, a private GKE cluster and Argo CD, all applied by a pipeline. Nothing is created by hand, except the one-time project preparation described in the docs.

## What It Creates

| Folder | Creates | Docs |
|---|---|---|
| `network/` | VPC, subnet with Pod and Service ranges, Cloud Router and Cloud NAT | [Module 2, Lesson 2](https://github.com/LuisGustavoBR/linuxtips-gitops/tree/main/02%20-%20GKE%20Platform%20with%20Terraform%20and%20GitHub%20Actions#lesson-2-creating-the-network) |
| `gke/` | Zonal GKE Standard cluster `gitops-hub` with private nodes, DNS endpoint, Workload Identity, an on-demand `system` pool and a Spot `apps` pool | [Module 2, Lesson 3](https://github.com/LuisGustavoBR/linuxtips-gitops/tree/main/02%20-%20GKE%20Platform%20with%20Terraform%20and%20GitHub%20Actions#lesson-3-creating-the-gke-cluster) |
| `argocd/` | Argo CD (Helm chart) and the `root` Application that watches [linuxtips-gitops-argocd](https://github.com/LuisGustavoBR/linuxtips-gitops-argocd) | [Module 3](https://github.com/LuisGustavoBR/linuxtips-gitops/tree/main/03%20-%20Installing%20Argo%20CD%20and%20the%20First%20Application) |

Each folder is a separate Terraform project with its own state (`gs://<project>-tfstate/<env>/<folder>`). The values of each environment live in `<folder>/envs/<env>.tfvars`; only `lab` exists for now.

## Repository Structure

```txt
.github/workflows/
  terraform.yaml       # on push: checks, detect changed folders, network → gke → argocd
  _terraform.yaml      # reusable: plan + apply of one folder
  destroy.yaml         # manual: destroys argocd and then gke (the network stays)
network/
gke/
argocd/
  values/argocd.yaml   # Argo CD chart values
.tflint.hcl            # lint rules (Terraform + Google)
.trivyignore.yaml      # accepted security findings, each one explained
```

## Pipeline

| Job | Runs | Approval |
|---|---|---|
| `checks` | `terraform fmt`, `validate`, TFLint, Trivy | no |
| `changes` | detects which folders changed in the push | no |
| `<folder> / plan` | `terraform plan`, shown in the job summary | yes (environment `lab`) |
| `<folder> / apply` | `terraform apply` | yes (environment `lab`) |

- **Login:** GitHub Actions logs in to Google Cloud with **Workload Identity Federation**. No service account key exists.
- **What runs:** only the folders that changed run, in dependency order. A manual run, or a change to the workflows, runs every folder.

### Configuration

**Repository variables** (Settings → Secrets and variables → Actions → Variables). None of them is a secret:

| Variable | Example |
|---|---|
| `GCP_PROJECT_ID` | `my-project` |
| `GCP_WIF_PROVIDER` | `projects/123456789/locations/global/workloadIdentityPools/github/providers/github-actions` |
| `GCP_SERVICE_ACCOUNT` | `terraform@my-project.iam.gserviceaccount.com` |
| `TF_STATE_BUCKET` | `my-project-tfstate` |

**GitHub Environment** `lab`, with a required reviewer and deployments limited to `main`.

The bucket, the Workload Identity pool and the service account are created once, by hand, in [Module 2, Lesson 1](https://github.com/LuisGustavoBR/linuxtips-gitops/tree/main/02%20-%20GKE%20Platform%20with%20Terraform%20and%20GitHub%20Actions#lesson-1-preparing-the-gcp-project).

## Usage

| To... | Do |
|---|---|
| Change the infrastructure | push to `main`, then approve the plan and the apply in **Actions** |
| Recreate everything after a destroy | **Actions → terraform → Run workflow** |
| Stop paying for the cluster | **Actions → destroy-gke → Run workflow** |
| Connect `kubectl` | `gcloud container clusters get-credentials gitops-hub --location us-central1-a --project <project> --dns-endpoint` |

> **Note:** The cluster nodes cost money while they run. Destroy the cluster when you are not using it.

## License

[MIT](./LICENSE)
