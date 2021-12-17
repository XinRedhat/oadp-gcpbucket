# velero-gcpbucket

* Login to Google Cloud
```
$ gcloud auth application-default login
```

* Create a GCP bucket for Velero

```
$ ./create_bucket.sh <bucket name>  <project id>
```

it will produce a secret file named `credentials-velero` after executing above command. And then you can apply it as secret for accessing the Google bucket storage by executing the following command
```
oc create secret generic cloud-credentials-azure --namespace openshift-adp --from-file cloud=credentials-velero
```

* Delete GCP bucket
```
$ ./delete_bucket.sh <bucket name>  <project id>
```