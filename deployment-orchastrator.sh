#!/bin/bash



# echo "initializing volumes for our mangodb storage"
# make init-ebs
echo "deploy workloads"
kubectl apply -f k8s/
sleep 10s
kubectl get po
kubectl get svc
# kubectl apply -f eks/database
# echo "deploy ingress controller"
# kubectl apply -f ingress/ingress-controller-cloud.yaml
# kubectl apply -f ingress/nginx-ingress-nlb.yaml
# sleep 30s
kubectl get pods -n ingress-nginx
kubectl describe svc ingress-nginx-controller-admission -n ingress-nginx
echo "deploy ingress"
# kubectl apply -f ingress/ingress.yaml
# sleep 60s
kubectl get ingress
kubectl get ingress -n monitoring
kubectl describe ingress 
