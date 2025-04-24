#!/usr/bin/env bash

echo "Applying Kubernetes resources..."
kubectl apply -k .

echo "Sleeping while awaiting for containers to be built (make a cuppa)..."
sleep 60

echo "Forwarding ports for Prometheus & Grafana..."

# Forward the port for Prometheus...
kubectl -n monitoring port-forward svc/prometheus 9090:9090 &

# Forward the port for Grafana...
kubectl -n monitoring port-forward svc/grafana 3000:80 &

echo "Opening Prometheus & Grafana in Chrome"

# Open Prometheus
open -a 'Google Chrome' 'http://localhost:9090/targets'

# Open Grafana
open -a 'Google Chrome' 'http://localhost:3000'

# Wait for keyboard response before closing...
wait
