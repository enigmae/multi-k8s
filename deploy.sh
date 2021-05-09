docker build -t enigmae/multi-client:latest -t enigmae/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t enigmae/multi-server:latest -t enigmae/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t enigmae/multi-worker:latest -t enigmae/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push enigmae/mutli-client:latest
docker push enigmae/mutli-server:latest
docker push enigmae/mutli-worker:latest
docker push enigmae/mutli-client:$SHA
docker push enigmae/mutli-server:$SHA
docker push enigmae/mutli-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=enigmae/multi-server:$SHA
kubectl set image deployments/client-deployment client=enigmae/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=enigmae/multi-worker:$SHA