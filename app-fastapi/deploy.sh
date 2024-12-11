echo "IMAGE_NAME = $1"
echo "IMAGE_TAG = $2"
cat ./deployment.yaml | sed 's/\$IMAGE_NAME'"/$1/g" | sed 's/\$IMAGE_TAG'"/$2/g" | tee >(cat >&2) | kubectl apply --kubeconfig /home/jenkins/k3s.yaml --validate=false -f - 