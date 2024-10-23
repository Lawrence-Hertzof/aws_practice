# Delete all at the beginning

kubectl delete -f deployment_with_filewriting.yaml
kubectl delete -f persistent_volume.yaml
kubectl delete -f persistent_volume_claim.yaml

# Create the persistent volume

#kubectl create -f persistent_volume.yaml
#kubectl create -f persistent_volume_claim.yaml
#kubectl create -f deployment_with_filewriting.yaml
