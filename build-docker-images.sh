#!/bin/bash

execPath=$(dirname "$0")
aspnetCorePath="$execPath/aspnet-core"

declare -A projectsToBuild

projectsToBuild=(
    ["TCloudUptime.Migrator_folder"]="$aspnetCorePath/src/TCloudUptime.Migrator"
    ["TCloudUptime.Migrator_imageName"]="southamerica-east1-docker.pkg.dev/t-cloud-watch/tcloud-watch/tcloud-uptime-migrator"
    ["TCloudUptime.Web.Host_folder"]="$aspnetCorePath/src/TCloudUptime.Web.Host"
    ["TCloudUptime.Web.Host_imageName"]="southamerica-east1-docker.pkg.dev/t-cloud-watch/tcloud-watch/tcloud-uptime-webapi"
    ["TCloudUptime.QueueWorker_folder"]="$aspnetCorePath/src/TCloudUptime.QueueWorker"
    ["TCloudUptime.QueueWorker_imageName"]="southamerica-east1-docker.pkg.dev/t-cloud-watch/tcloud-watch/tcloud-uptime-queueworker"
    ["TCloudUptime.AlertsManager_folder"]="$aspnetCorePath/src/TCloudUptime.AlertsManager"
    ["TCloudUptime.AlertsManager_imageName"]="southamerica-east1-docker.pkg.dev/t-cloud-watch/tcloud-watch/tcloud-uptime-alertsmanager"
    ["TCloudUptime.MonitorSchedulerWorker_folder"]="$aspnetCorePath/src/TCloudUptime.MonitorSchedulerWorker"
    ["TCloudUptime.MonitorSchedulerWorker_imageName"]="southamerica-east1-docker.pkg.dev/t-cloud-watch/tcloud-watch/tcloud-uptime-monitorschedulerworker"
)

createdbyLabel="com.microsoft.created-by=visual-studio"

for project in TCloudUptime.Migrator TCloudUptime.Web.Host TCloudUptime.QueueWorker TCloudUptime.AlertsManager TCloudUptime.MonitorSchedulerWorker; do
    productLabel="com.microsoft.visual-studio.project-name=${project}"
    projectFolder="${projectsToBuild[${project}_folder]}"
    projectDockerFile="${projectFolder}/Dockerfile"
    projectImageName="${projectsToBuild[${project}_imageName]}"

    # imageSearch=$(docker image ls "$projectImageName" --format "table {{.Repository}}")
    imageSearch="southamerica-east1-docker.pkg.dev/t-cloud-watch/tcloud-watch/"

    if [[ $imageSearch =~ $projectImageName ]]; then
        # docker rmi "$projectImageName" -f
        buildah rmi -f "$projectImageName" 
        echo "projectImageName"
        echo $projectImageName
    fi
    echo "projectDockerFile"
    echo $projectDockerFile
    # buildah build -f "$projectDockerFile" --force-rm -t "$projectImageName" --label "$createdbyLabel" --label "$productLabel" "$projectFolder"
    buildah bud -f "$projectDockerFile" -t "$projectImageName" --label "$createdbyLabel" --label "$productLabel" "$aspnetCorePath"
done

docker image prune -f