#!/bin/bash
echo $1 | base64 -d > kubeconfig
nohup kubectl --kubeconfig kubeconfig port-forward svc/service-frontend 8080:8080 &
KUBECTL_PID=$!

response=000
retry_count=0
max_retries=60

while [ "$response" -eq 000 ] && [ $retry_count -lt $max_retries ]; do
    retry_count=$((retry_count + 1))
    response=$(curl --write-out "%{http_code}" --silent --output /dev/null localhost:8080)
    echo "HTTP response code: $response"
    status=$?
    sleep 1
done

if [ "$response" -eq 404 ]; then
    echo "Resource not found (404). Exiting."
    exit 1
elif [ "$response" -eq 000 ]; then
    echo "connection refused (000). Exiting."
    exit 1
elif [ "$status" -eq 7 ]; then
    echo "Connection refused (cURL error 7). Exiting."
    exit 1
elif [ "$status" -eq 28 ]; then
    echo "Operation timeout (cURL error 28). Exiting."
    exit 1
fi

echo "HTTP response code: $response"
echo "cURL exit status: $status"

kill $KUBECTL_PID