#!/bin/sh
#
# Script to build images
#

# break on error
set -e

REPO="muccg"
DATE=`date +%Y.%m.%d`

DOCKER_HOST=$(ip -4 addr show docker0 | grep -Po 'inet \K[\d.]+')
HTTP_PROXY="http://${DOCKER_HOST}:3128"
: ${DOCKER_BUILD_OPTIONS:="--pull=true --build-arg HTTP_PROXY=${HTTP_PROXY} --build-arg http_proxy=${HTTP_PROXY}"}


ci_docker_login() {
    if [ -n "$bamboo_DOCKER_USERNAME" ] && [ -n "$bamboo_DOCKER_EMAIL" ] && [ -n "$bamboo_DOCKER_PASSWORD" ]; then
        docker login  -e "${bamboo_DOCKER_EMAIL}" -u ${bamboo_DOCKER_USERNAME} --password="${bamboo_DOCKER_PASSWORD}"
    else
        echo "Docker vars not set, not logging in to docker registry"
    fi
}

ci_docker_login

# build dirs, top level is distro
for dir in */
do
    distro=${dir%*/}

    # subdirs are version
    for subdir in ${dir}*/
    do
        version=`basename ${subdir}`
        image="${REPO}/${distro}${version}-base"

        echo "################################################################### ${image}"
        
        # warm up cache for CI
        docker pull ${image}:latest || true

        # build and tag legacy names
        docker build ${DOCKER_BUILD_OPTIONS} -t ${image}:${DATE} ${subdir}
        docker build ${DOCKER_BUILD_OPTIONS} -t ${image}:latest ${subdir}

	# new names
        docker build ${DOCKER_BUILD_OPTIONS} -t "${REPO}/base:${distro}-${version}" ${subdir}
        docker build ${DOCKER_BUILD_OPTIONS} -t "${REPO}/base:${distro}-${version}-${DATE}" ${subdir}

        # for logging in CI
        docker inspect ${image}:${DATE}

        # push to legacy repo
        docker push ${image}:${DATE}
        docker push ${image}:latest

	# push to new repo
        docker push "${REPO}/base:${distro}-${version}"
        docker push "${REPO}/base:${distro}-${version}-${DATE}"
    done
done
