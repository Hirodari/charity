#!/bin/bash

echo  "shutting down the project and cluster charity"
echo  "deleting workloads"
# kubectl delete -f eks/workload/stage
kubectl delete -f k8s/
echo  "deleting ingress controller"
kubectl delete -f ingress/ingress-controller-cloud.yaml
kubectl delete -f ingress/nginx-ingress-nlb.yaml
kubectl delete -f ingress/ingress.yaml
sleep 10s
echo "checking pods and services"
kubectl get all
sleep 5s
echo "all pods and services down"