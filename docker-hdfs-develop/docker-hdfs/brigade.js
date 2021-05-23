const { Job } = require("brigade");
const devops = require("devops-brigade");

async function buildAsync(e, project) {
    let job = new Job("getdeps", "node");
    // todo whatever
    job.storage.enabled = true

    let taskFactory = new devops.BuildTaskFactory(e, project);
    job.tasks = [
        "cd /src",
        `mkdir tar && cd tar`,
        `curl -O -u ${project.secrets.nexus_user}:${project.secrets.nexus_pass} https://nexus01-nexus.az.gdoci01.gdpdentsu.net/repository/maven-releases/org/apache/ranger/ranger-hdfs-plugin/2.0.0/ranger-hdfs-plugin-2.0.0.tar.gz`,
        `curl -O -u ${project.secrets.nexus_user}:${project.secrets.nexus_pass} https://nexus01-nexus.az.gdoci01.gdpdentsu.net/repository/maven-releases/org/apache/tez/tez/0.9.1/tez-0.9.1.tar.gz`,
        `cd /src`,
        taskFactory.storeBuild(),
        `pwd`
    ]
    return job.run();
}

devops.Events.onPushDevelop(async (e, project) => {
    await devops.Utilities.gitVersionAsync();
    await buildAsync(e, project);
    await devops.Standard.packageAsync();
    await devops.Standard.approveAsync();
    await devops.Standard.publishHelmChartAsync();
});

