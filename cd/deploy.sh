echo $1 | base64 -d > kubeconfig
kubectl --kubeconfig kubeconfig apply -f ./k8s/ --validate=false
