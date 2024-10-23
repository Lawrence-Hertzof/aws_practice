# Delete all at the beginning
# Before deleting cluster, delete EFS file system in AWS console

kubectl delete -f efs_deployment_with_filewriting.yaml
kubectl delete -f efs_persistent_volume_claim.yaml
kubectl delete -f efs_persistent_volume.yaml

# Create the persistent volume
#kubectl apply -k "github.com/kubernetes-sigs/aws-efs-csi-driver/deploy/kubernetes/overlays/stable/ecr/?ref=release-1.3"
#kubectl create -f efs_persistent_volume.yaml
#kubectl create -f efs_persistent_volume_claim.yaml
#kubectl create -f efs_deployment_with_filewriting.yaml
#
