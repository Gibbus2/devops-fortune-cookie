echo $1 | base64 -d > kubeconfig
kubectl --kubeconfig kubeconfig port-forward service/service-frontend 8080 8080
response=$(curl --write-out "%{http_code}" --silent --output /dev/null localhost:8080)
echo "HTTP response code: $response"
if [ "$response" -eq 404 ]; then
    echo "Resource not found (404). Exiting."
    exit 1
fi
