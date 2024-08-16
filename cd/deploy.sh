echo $1 | base64 -d > kubeconfig
cat kubeconfig
kubectl --kubeconfig kubeconfig apply -f ./k8s/ --validate=false
