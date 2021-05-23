const { logJob } = require('./mock-brigadier')
const { Utilities, Globals } = require('devops-brigade')
// Workaround for loading brigade.js from this folder so it can import 
// devops-brigade. Must do this synchronously so it's available by the next line
// that imports it.
var fs = require('fs-extra');
fs.copySync('../brigade.js', 'brigade.js');

const { JobFactory } = require("./brigade")

// Must set this in brigade-test only
// so that production deployment jobs can be verified
Utilities.BrigadeTestMode = true;

function testJobs() {    
    const e = {
        revision: {
            commit: 'deadbeefdeadbeefdeadbeefdeadbeef',
            ref: 'develop'
        },
        payload: JSON.stringify({
            after: 'deadbeefdeadbeefdeadbeefdeadbeef',
            ref:'/ref/heads/develop',
            env: 'dev',
            version: '1.0.1'
        })
    };

    const project = {
        secrets: {
            base: 'devops',
            team_name: 'my-team',
            app_name: 'my-app',
            app_container_reg: 'myreg11.azurecr.io',
            global_container_reg: 'globaldevopsreg11.azurecr.io',
            "yourteam01-dev_resource_group": "devops-aks-rg",
            "yourteam01-dev_cluster": "my-aks-cluster",
            "yourteam01-dev_cluster_type": "aks",

            "yourteam01-prod_cluster": "my-prod-aks-cluster",
            "yourteam01-prod_cluster_type": "aks",
            "yourteam01-prod_resource_group": "myprod-aks-rg",
            
            azure_client_id: "my-az-client-id",
            azure_client_secret: "my-az-client-secret",
            azure_tenant_id: "my-az-tenant-id"
        },
        repo: { 
            name: 'devops/release-management',
            cloneURL: 'https://gitea-tooling.az.globaldevops.gdpdentsu.netglobal/devops/brigade-boilerplate.git'            
        },
        kubernetes: {
            namespace: 'my-namespace'
        }
    };
    
    Globals.project = project;
    Globals.e = e;
    Globals.branch = "develop";

    let factory = new JobFactory();
    logJob(factory.createBuildJob(e, project));
    logJob(factory.createDeployJob("yourteam01-dev", e, project));
    logJob(factory.createDeployJob("yourteam01-prod", e, project));
}

testJobs();
