#!groovy

node {
    stage 'Checkout'
        checkout scm

    stage 'Build'
        echo "Branch is: ${env.BRANCH_NAME}"
        echo "Build is: ${env.BUILD_NUMBER}"
        sh './build.sh'
}
