# Node.js Docker App

## Build Docker Image
```bash
docker build -t node-hello:latest .


### deploy to kubernetes
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/ingress.yaml


### check the status of application
kubectl get pods
kubectl get svc
kubectl get ingress

### find the Ingress IP
kubectl get svc -n ingress-nginx

###Test via curl
curl http://node.local

###Expected output
Hello World from Node.js in Kubernetes!

