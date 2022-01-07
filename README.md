# oadp-gcpbucket

This script is to help create a GCP bucket for OADP as backup storage. In the meanwhile, it also create a unique service account for the bucket access. When the script is done, it will produce a `credentials-velero-gcp` file and `dpa.yml` file for OADP configuration. Regarding the detail, you could reference [Velero plugins for GCP]( https://github.com/vmware-tanzu/velero-plugin-for-gcp)

* Login to Google Cloud
```
$ gcloud auth application-default login
```

* Create a GCP bucket for Velero

```
$ ./create_bucket.sh <bucket name>  <project id>
```

it will generate two files named `credentials-velero-gcp` and `dpa.yml` after executing above command. And then you can apply them to create DPA CR.

* Delete GCP bucket
```
$ ./delete_bucket.sh <bucket name>  <project id>
```