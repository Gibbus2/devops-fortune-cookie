echo $1 | base64 -d > kubeconfig
helm upgrade --install redis bitnami/redis -f redis.yaml --kubeconfig kubeconfig
rm kubeconfig
