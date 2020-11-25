#!/bin/bash

echo "starting..."

gcloud container clusters get-credentials my-cool-cluster --zone us-central1-f

load_balancer_ip=""
while [ "${load_balancer_ip}" == "" ]; do
 load_balancer_ip=`kubectl get services -n istio-system istio-ingressgateway --output jsonpath='{.status.loadBalancer.ingress[0].ip}' 2>/dev/null`
done
echo "setting to ${load_balancer_ip}"


map_exists=""
while [ "${map_exists}" == "" ]; do
  map_exists=`kubectl get configmap config-domain --namespace knative-serving  2>/dev/null`
done
kubectl patch configmap config-domain --namespace knative-serving --patch \
 "{\"data\": {\"example.com\": null, \"${load_balancer_ip}.xip.io\": \"\"}}"

echo "end."

