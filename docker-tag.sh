if [ "$#" -lt 2 ]; then echo "Usage: $0 tag version"; exit 0; fi
tag=$1
VERSION=$2
docker tag "$tag" docker.io/bprtkop/sysbox-deploy-k8s:latest
docker tag "$tag" "docker.io/bprtkop/sysbox-deploy-k8s:$VERSION"
docker tag "$tag" "docker.io/bprtkop/sysbox-deploy-k8s:${VERSION}_amd64"
docker push -a docker.io/bprtkop/sysbox-deploy-k8s
docker manifest create bprtkop/sysbox-deploy-k8s:latest --amend "bprtkop/sysbox-deploy-k8s:${VERSION}_amd64"
docker manifest push bprtkop/sysbox-deploy-k8s:latest
docker manifest create bprtkop/sysbox-deploy-k8s:"$VERSION" --amend "bprtkop/sysbox-deploy-k8s:${VERSION}_amd64"
docker manifest push bprtkop/sysbox-deploy-k8s:"$VERSION"
