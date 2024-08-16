echo $1 | base64 -d > kubeconfig
kubectl --kubeconfig kubeconfig port-forward svc/service-frontend 8080:8080 &
sleep 5
response=$(curl --write-out "%{http_code}" --silent --output /dev/null localhost:8080)
echo "HTTP response code: $response"
status=$?

echo "HTTP response code: $response"
echo "cURL exit status: $status"

if [ "$response" -eq 404 ]; then
    echo "Resource not found (404). Exiting."
    exit 1
elif [ "$status" -eq 7 ]; then
    echo "Connection refused (cURL error 7). Exiting."
    exit 1
elif [ "$status" -eq 28 ]; then
    echo "Operation timeout (cURL error 28). Exiting."
    exit 1
elif [ "$status" -eq 000 ]; then
    echo "Unknwon return"
    exit 1
fi
