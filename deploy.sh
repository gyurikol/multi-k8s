docker build -t gyuri/multi-client:latest -t gyuri/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t gyuri/multi-server:latest -t gyuri/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t gyuri/multi-worker:latest -t gyuri/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push gyuri/multi-client:latest
docker push gyuri/multi-server:latest
docker push gyuri/multi-worker:latest

docker push gyuri/multi-client:$SHA
docker push gyuri/multi-server:$SHA
docker push gyuri/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=gyuri/multi-server:$SHA
kubectl set image deployments/client-deployment client=gyuri/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=gyuri/multi-worker:$SHA
