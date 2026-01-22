if [ "$#" -lt 2 ]; then echo "Usage: $0 image version_tag"; exit 0; fi
image=$1
VERSION=$2
docker tag "$image" docker.io/bprtkop/sysbox-deploy-k8s:latest
docker tag "$image" "docker.io/bprtkop/sysbox-deploy-k8s:$VERSION"
docker tag "$image" "docker.io/bprtkop/sysbox-deploy-k8s:${VERSION}_amd64"
docker push -a docker.io/bprtkop/sysbox-deploy-k8s
docker manifest create bprtkop/sysbox-deploy-k8s:latest --amend "bprtkop/sysbox-deploy-k8s:${VERSION}_amd64"
docker manifest push bprtkop/sysbox-deploy-k8s:latest
docker manifest create bprtkop/sysbox-deploy-k8s:"$VERSION" --amend "bprtkop/sysbox-deploy-k8s:${VERSION}_amd64"
docker manifest push bprtkop/sysbox-deploy-k8s:"$VERSION"
