if [ "$#" -lt 2 ]; then echo "Usage: $0 image version_tag"; exit 0; fi
image=$1
VERSION=$2
ARCH=amd64
docker tag "$image" docker.io/bprtkop/sysbox-deploy-k8s:latest
docker tag "$image" "docker.io/bprtkop/sysbox-deploy-k8s:$VERSION"
docker tag "$image" "docker.io/bprtkop/sysbox-deploy-k8s:${VERSION}_$ARCH"
docker push -a docker.io/bprtkop/sysbox-deploy-k8s
docker manifest create docker.io/bprtkop/sysbox-deploy-k8s:latest \
--amend "docker.io/bprtkop/sysbox-deploy-k8s:${VERSION}_$ARCH"
docker manifest push docker.io/bprtkop/sysbox-deploy-k8s:latest
docker manifest create docker.io/bprtkop/sysbox-deploy-k8s:"$VERSION" \
--amend "docker.io/bprtkop/sysbox-deploy-k8s:${VERSION}_$ARCH"
docker manifest push docker.io/bprtkop/sysbox-deploy-k8s:"$VERSION"
