## Apply Service Account

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: <USERNAME>  # any name you want
  namespace: <NAMESPACE>
```

## Apply Role

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: <NAMESPACE>
  name: <ROLE_NAME>  # any name you want
rules:
- apiGroups: [""] # "" indicates the core API group -> pods, services, etc...
  resources: ["pods"]
  verbs: ["get", "list", "watch"]
  # --- #
- apiGroups: ["apps"]  # indicates API group for -> deployments, statefulsets, etc...
  resources: ["deployments"]
  verbs: ["create", "get", "list", "watch", "update", "patch", "delete"]
```

## Apply Role Binding

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: <ROLE_BINDING_NAME>
  namespace: <NAMESPACE>
subjects:
- kind: ServiceAccount
  name: <USERNAME>
  namespace: <NAMESPACE>
roleRef:
  kind: Role
  name: <ROLE_NAME>
  apiGroup: rbac.authorization.k8s.io
```

## Create user token secret

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: <TOKEN_SECRET_NAME>  # any name you want
  annotations:
    kubernetes.io/service-account.name: <USERNAME>
type: kubernetes.io/service-account-token
```


## Create kubeconfig file

### Get the server URL
```bash
kubectl config view --minify --raw | grep server # -> Get the server URL
```
### Get the certificate-authority-data
```bash
kubectl config view --minify --raw | grep certificate-authority-data # -> Get the certificate-authority-data
```

### Get the token
```bash
kubectl get secret deployer-user-token -o jsonpath="{.data.token}" | base64 --decode  # -> Get the token
```

### Create kubeconfig file
```yaml
apiVersion: v1
kind: Config
clusters:
- cluster:
    certificate-authority-data: <CERTIFICATE_AUTHORITY_DATA>
    server: <SERVER_URL>
  name: kubernetes-cluster
contexts:
- context:
    cluster: kubernetes-cluster
    namespace: <NAMESPACE>
    user: <USERNAME>
  name: <USERNAME>-context  
current-context: <USERNAME>-context
users:
- name: <USERNAME>
  user:
    token: eyJhbGciOiJSUzI1NiIsImtpZCI6IkhlSDh5Y3g5aWZxYkJOSWppSHdEYlZhQUVyYlNieVNEaU5HWG83YTZSajAifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImRlcGxveWVyLXVzZXItdG9rZW4iLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiZGVwbG95ZXIiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiJhNjM0OWM0YS0zNTIxLTRmZjgtOTU4MC02OTFiMDFkNjE0NDMiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6ZGVmYXVsdDpkZXBsb3llciJ9.u1vgFM9LMX4SJhTCNFjXL51GRGTv0K81dqxDMg6T9hoDL5EgLMK6wus2nKyREFepP53PyrwkY3iY1OLZha3whXD_lCSVV_mXGYVF2xSV2a5VAoo7SblnaxRyuQ8QJ_qWminy9gyyD80_a5eQk8e4v4Z5l5kTXeZ2u8gYpmCrQi3ELgisQNSkgcgEGpkYP7SwLLQX50Ao5bC1ryHR_ctQbNPRiBRA47L4z0RLGvtdzdlXUi92NL9WnvYB9V4_7AteaFVXZ9dVFPhtzaFpnQotv9VXQBnkm6oURX58d0nxhhJt_iYztu86z8HEvOpPZ78KiKomqNC6cuvAScn0-XE-mw

```




