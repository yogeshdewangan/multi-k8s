docker build -t yogeshdewangan97/multi-client:latest -t yogeshdewangan97/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t yogeshdewangan97/multi-server:latest -t yogeshdewangan97/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t yogeshdewangan97/multi-worker:latest -t yogeshdewangan97/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push yogeshdewangan97/multi-client:latest
docker push yogeshdewangan97/multi-server:latest
docker push yogeshdewangan97/multi-worker:latest

docker push yogeshdewangan97/multi-client:$SHA
docker push yogeshdewangan97/multi-server:$SHA
docker push yogeshdewangan97/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=yogeshdewangan97/multi-server:$SHA
kubectl set image deployments/client-deployment client=yogeshdewangan97/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=yogeshdewangan97/multi-worker:$SHA

