#!/usr/bin/env bash
KUBE_CURRENT_NAMESPACE=hadoop

# hdfs deploy
helm install \
    --name ${KUBE_CURRENT_NAMESPACE}-fs helm/docker-hdfs \
    --namespace ${KUBE_CURRENT_NAMESPACE} \
    --set image=globaldevopsreg11.azurecr.io/docker-hdfs:0.0.20 \
    --set imagePullPolicy=Always \
    --set dataNode.replicas=9 \
    --set httpFs.replicas=4 \
    --set dataNode.pdbMinAvailable=6 \
    --set antiAffinity="soft" \
    --set nameNode.resources.requests.memory="4096Mi" \
    --set nameNode.resources.requests.cpu="2000m" \
    --set nameNode.resources.limits.memory="4096Mi" \
    --set nameNode.resources.limits.cpu="2000m" \
    --set dataNode.resources.requests.memory="4096Mi" \
    --set dataNode.resources.requests.cpu="2000m" \
    --set dataNode.resources.limits.memory="4096Mi" \
    --set dataNode.resources.limits.cpu="2000m" \
    --set journalNode.resources.requests.memory="4096Mi" \
    --set journalNode.resources.requests.cpu="2000m" \
    --set journalNode.resources.limits.memory="4096Mi" \
    --set journalNode.resources.limits.cpu="2000m" \
    --set httpFs.resources.requests.memory="4096Mi" \
    --set httpFs.resources.requests.cpu="2000m" \
    --set httpFs.resources.limits.memory="4096Mi" \
    --set httpFs.resources.limits.cpu="2000m" \
    --set enableDfsPermissions=true \
    --set enableHadoopAcls=false \
    --set LogLevel=INFO \
    --set webhdfs.enabled=true \
    --set persistence.nameNode.enabled=true \
    --set persistence.nameNode.storageClass=managed-premium \
    --set persistence.nameNode.size=1024Gi \
    --set persistence.dataNode.enabled=true \
    --set persistence.dataNode.storageClass=managed-premium \
    --set persistence.dataNode.size=4095Gi \
    --set persistence.journalNode.enabled=true \
    --set persistence.journalNode.storageClass=managed-premium \
    --set persistence.journalNode.size=512Gi \
    --set highAvailability.Enabled=true \
    --set highAvailability.Zookeeper.Host=${KUBE_CURRENT_NAMESPACE}-sl-zookeeper-headless \
    --set Ranger.Enabled=true \
    --set Ranger.RepositoryName=HDFS \
    --set Ranger.Host=${KUBE_CURRENT_NAMESPACE}-ra-ranger-admin \
    --set Ranger.Auditing.Zookeeper.Host=${KUBE_CURRENT_NAMESPACE}-sl-zookeeper-headless \
    --set Ranger.Auditing.SummaryEnabled=true \
    --set Ranger.Auditing.Solr.Enabled=true \
    --set Ranger.Auditing.Solr.Host=${KUBE_CURRENT_NAMESPACE}-sl-solr-headless