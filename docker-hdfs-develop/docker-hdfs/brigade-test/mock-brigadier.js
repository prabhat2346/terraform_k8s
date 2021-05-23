var mock = require('mock-require'); 

class MockPromise {
    then(f) {
        return f();
    }
}

const mockBrigadier = { 
    events: {
        on: function(name, f) {}
    },
    Job: function(name, container) {
      return {
          storage: {
              enabled:false
          },
          name: name,
          container: container,
          run: function() {
              return new Promise((resolve, reject) => {
                resolve("some string");
              })
          }
      }  
    },
    Group: function() {
        return {
        }  
      },
};

mockBrigadier.Group.runAll = function(jobs) {
    console.log("Running " + jobs.length + " jobs in parallel (runAll):");
    for (let index = 0; index < jobs.length; index++) {
        console.log("- " + jobs[index].name);
    }

    return new MockPromise();
}

mockBrigadier.Group.runEach = function(jobs) {
    console.log("Running " + jobs.length + " jobs in sequentially (runEach):");
    for (let index = 0; index < jobs.length; index++) {
        console.log("- " + jobs[index].name);
    }

    return new MockPromise();
}

// For devops-brigade-worker < 0.0.82
mock('brigadier', mockBrigadier);
mock('./dist/brigadier', mockBrigadier);
mock('../../../../dist/brigadier', mockBrigadier);

exports.logJob = function logJob(job, name) {
    console.log('-------------------------')
    console.log(name || job.name)
    console.log('-------------------------')
    console.log(job);
    console.log()
    console.log("TASKS:")
    
    for (var i in job.tasks)
    {
        console.log(job.tasks[i])
        if (job.tasks[i].includes("${project.secrets")) {
            throw "Bad substitution, are you missing back-ticks for this task?"
        }
    }

    console.log()
}
