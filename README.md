# Deploy Laravel on Kubernetes with Helm chart

Helm charts simplify greatly the process of deploying and managing a Laravel application in a Kubernetes cluster.

## Before we begin

This tutorial will make these assumptions for brevity purposes:

- You are using Mac OS
- You are using Google Cloud
- You will be installing this demo [Laravel Appointments](https://github.com/laravel-montreal/Laravel-Appointments) app

All of these instructions also assuredly apply to a Linux environment, and probably to a Windows environment as well.

## Prerequisites

- Install [Docker](https://hub.docker.com/?overlay=onboarding)
- Install [Docker Compose](https://docs.docker.com/compose/install/)
- Install [Helm](https://github.com/helm/helm#install)
- Install [Kubernetes](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- Install and configure the [gcloud command line tool](https://cloud.google.com/sdk/docs/quickstarts)

## Install the project

Clone this repository, and clone your Laravel project inside your directory:

```
git clone https://github.com/laravel-montreal/laravel-kubernetes-helm.git

cd laravel-kubernetes-helm

git clone https://github.com/laravel-montreal/Laravel-Appointments.git docker/laravel
```

## Deploy to Docker

The following command will:

- create Docker images and run containers
- perform series of Laravel Artisan and NPM commands in the container

```
bash ./bin/install-project.sh
```

To access website locally, visit http://localhost:82/.

## Create a Google Kubernetes Engine cluster

1. If you haven't already, [create a Google Cloud project](https://console.cloud.google.com/projectcreate).
2. In your project, [create a Kubernetes cluster](https://console.cloud.google.com/kubernetes/add).
   - Choose a zone geographically close to you for better latency.
   - Use Release Channels (Regular channel) to manage automatic upgrades of your cluster.
   - Choose a minimum of 2 nodes in your Number of nodes (ideally min. 3)
   - Choose a g1-small Machine type instead of n1-standard-1 (or more) if you just want to test. Be mindful that this choice will have an significative impact on the price of your cluster.
   - Click on 'More options', and then check the 'Enable autoscaling' box. Enter 2 as the minimum number of nodes, and choose the maximum you're willing to pay as the max ;)
   - Click 'Save'.
3. Once your cluster is created, click on the 'Connect' button, copy the command-line access command, and run it in your terminal.

## Deploy to a Kubernetes cluster using Helm.

To deploy the application on Kubernetes using Helm, you first need to push a Docker image of your application on Docker Hub:

```
docker build -t laravel-appointments -f ./docker/Dockerfile.phpfpm ./docker

docker tag laravel-appointments [your-docker-username]/laravel-appointments

docker push [your-docker-username]/laravel-appointments:latest
```

You might have to login to push image in the Docker repository:

```
docker login
```

Now, that you have your image in the Docker repository, you can deploy to Kubernetes by running the following command:

```
bash ./bin/publish_chart.sh
```

## TODO

- Database management in the Kubernetes cluster.
- Command-line cluster deployment (currently through user interface).

## ACKNOWLEDGEMENTS

Thanks to [Damber Prasad Gautam](https://github.com/dambergautam) for the inspiration for creating this repository.

Thanks to [Frédéric Chiasson](https://github.com/cariboufute) and [Miguel Legault](https://github.com/mlatjac) for their invaluable contribution to the Laravel Montreal user group.

Thanks to [Aurélien Lanos](https://github.com/HiddenCorp) for preparing the presentation to Laravel Montreal for which I have made this repository.
