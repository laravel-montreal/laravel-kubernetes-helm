#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd );

DIR_ROOT="${DIR/\/bin/}";

export ENVIRONMENT_LOCAL="local";
export ENVIRONMENT_TEST="tst";

ENV_CHART_NAME="gke_laravelmtl_northamerica-northeast1-a_laravelmtl";
RELEASE_NAME="laravel-appointments";
VERSION_NUMBER="latest"

echo "Waiting for update to complete, this may take a couple of minutes...";
helm upgrade \
    --force \
    --kube-context="${ENV_CHART_NAME}" \
    --tiller-namespace="kube-system" \
    --install \
    --values "${DIR_ROOT}/chart/values-production.yaml" \
    --set image.tag="${VERSION_NUMBER}" \
    --set database.password="laravel_password" \
    --wait \
    "${RELEASE_NAME}" \
    "${DIR_ROOT}/chart";

echo "Helm chart applied successfully.";
