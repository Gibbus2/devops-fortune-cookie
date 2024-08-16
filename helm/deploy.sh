echo $1 | base64 -d > kubeconfig
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm upgrade --install redis bitnami/redis -f redis.yaml --kubeconfig kubeconfig
rm kubeconfig
