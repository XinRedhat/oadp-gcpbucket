apiVersion: oadp.openshift.io/v1alpha1
kind: DataProtectionApplication
metadata:
  name: dpa-sample
  namespace: openshift-migration
spec:
  backupLocations:
    - velero:
        credential:
          key: cloud
          name: cloud-credentials-gcp
        objectStorage:
          bucket: ${bucket}
          prefix: velero
        default: true
        provider: gcp
  configuration:
    restic:
      enable: true
    velero:
      defaultPlugins:
        - gcp
        - csi
        - openshift
    featureFlags:
    - EnableCSI
  snapshotLocations:
    - velero:
        config:
          project: ${project}
          snapshotLocation: ${region}
        provider: gcp
        default: true