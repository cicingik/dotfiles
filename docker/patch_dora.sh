NAMESPACE_CRON=finfini-cron
CRONJOB_NAME=dora-data
KUBE_PATCH_DEPLOYMENT=$(cat << JSON
{
  "metadata": {
    "labels": {
      "app.kubernetes.io/instance": "production",
      "app.kubernetes.io/part-of": "dora-data",
      "app.kubernetes.io/version": "v1.0.1",
      "service.finfini.com/type": "production",
      "service.finfini.com/env": "production",
      "service.finfini.com/commit-sha": "0cbf9744",
      "service.finfini.com/version": "v1.0.1",
      "service.finfini.com/project-name": "dora-rs",
      "service.finfini.com/project-namespace": "se-metrics",
      "service.finfini.com/release-pipeline": "574081"
    }
  },
  "spec": {
    "jobTemplate": {
      "spec": {
        "template": {
          "metadata": {
            "labels": {
              "app.kubernetes.io/instance": "production",
              "app.kubernetes.io/part-of": "dora-data",
              "app.kubernetes.io/version": "v1.0.1",
              "service.finfini.com/type": "production",
              "service.finfini.com/env": "production",
              "service.finfini.com/commit-sha": "0cbf9744",
              "service.finfini.com/version": "v1.0.1",
              "service.finfini.com/project-name": "dora-rs",
              "service.finfini.com/project-namespace": "se-metrics",
              "service.finfini.com/release-pipeline": "574081"
            }
          },
          "spec": {
            "containers": [
              {
                "image": "asia.gcr.io/finfini/dora-rs:v1.0.1",
                "name": "dora-data"
              }
            ]
          }
        }
      }
    }
  }
}
JSON
)

kubectl patch cronjobs.batch -n $NAMESPACE_CRON ${CRONJOB_NAME}-aggressive --patch "$KUBE_PATCH_DEPLOYMENT"
