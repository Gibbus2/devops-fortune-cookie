Redis&reg; can be accessed via port 6379 on the following DNS name from within your cluster:

    redis-master.student-18.svc.cluster.local



To connect to your Redis&reg; server:

1. Run a Redis&reg; pod that you can use as a client:

   kubectl run --namespace student-18 redis-client --restart='Never'  --image docker.io/bitnami/redis:7.4.0-debian-12-r1 --command -- sleep infinity

   Use the following command to attach to the pod:

   kubectl exec --tty -i redis-client \
   --namespace student-18 -- bash

2. Connect using the Redis&reg; CLI:
   redis-cli -h redis-master

To connect to your database from outside the cluster execute the following commands:

    kubectl port-forward --namespace student-18 svc/redis-master 6379:6379 &
    redis-cli -h 127.0.0.1 -p 6379


    Deployment command: helm install redis bitnami/redis -f redis.yaml