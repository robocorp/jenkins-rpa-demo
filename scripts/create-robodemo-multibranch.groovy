// Author: jyri.ilama@gmail.com
// Modified version of:
// https://github.com/peterjenkins1/jenkins-scripts/blob/master/add-multibranch-pipeline-job.groovy

import hudson.util.PersistedList
import jenkins.model.Jenkins
import jenkins.branch.*
import jenkins.plugins.git.*
import org.jenkinsci.plugins.workflow.multibranch.*

String jobName = "robodemo"
String jobScript = "Jenkinsfile"
String gitRepo = "https://github.com/robocorp/jenkins-rpa-demo.git"
String credentialsId = null

Jenkins jenkins = Jenkins.instance

// Create job if it doesn't exist
item = jenkins.getItem(jobName)
if ( item != null ) {
  // Update case
  mbp = (WorkflowMultiBranchProject) item
} else {
  // Create case
  mbp = jenkins.createProject(WorkflowMultiBranchProject.class, jobName)
}

mbp.getProjectFactory().setScriptPath(jobScript)

// Add git repo
String id = null
String remote = gitRepo
String includes = "*"
String excludes = ""
boolean ignoreOnPushNotifications = false
GitSCMSource gitSCMSource = new GitSCMSource(id, remote, credentialsId, includes, excludes, ignoreOnPushNotifications)
BranchSource branchSource = new BranchSource(gitSCMSource)
// Remove and replace?
PersistedList sources = mbp.getSourcesList()
sources.clear()
sources.add(branchSource)
