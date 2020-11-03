# RoboJenkins demo
## Description
This is an example project for running [Robot Framework RPA](https://robotframework.org/rpa/) tasks with [Robocorp tools](https://robocorp.com/docs/) and [Jenkins](https://www.jenkins.io/). See the instructions below how to run it on Linux/Mac or Windows.

This project installs and configures Jenkins for you in a Docker container, with a ready-made Multibranch pipeline Robot Framework RPA demo job. Note that this is not a production-ready environment, using this for real-life purposes is not recommended. See technical details for more information.

## Instructions
Short:
1. Install [Docker](https://docs.docker.com/get-docker/)
1. Setup the docker
   * Windows users: `get-started.bat`
   * Linux/Mac: `./get-started.sh`
   * Image building takes a while and ask you before starting the docker
   * Follow the guides
1. Once in the Jenkins click "robodemo" to open the demo project
1. Click `Scan multibranch pipeline` from the left-hand side
1. Refresh the Jenkins page and you should see that the job starts scanning first, then building the master branch
1. Click to open the master, check the results. 
   * Click build #1 from left-hand side to see full console output and more information.

## Details
### General
The Jenkins master will run on your own computer. The agents, that are also containers, are also running on the same computer. Running jobs on the master node is a bad practice, and this is the first thing that should be taken into account when using Jenkins for real use-cases. Either spin up resources on-the-fly with e.g. EC2 or Azure slaves plugins or use a Kubernetes cluster (EKS, AKS plugins), or use e.g. ECS for this purpose. How to set these up depends on your use case, but all of these plugins have a fairly good documentation, so Google is your friend :) Or, if you have an existing infrastructure with virtual/physical machines running somewhere, just use them as your agents as such: install Java, and either let Jenkins master connect to them with SSH, or connect to Jenkins master from the agent with JNLP. Read more about [Jenkins remoting here](https://www.jenkins.io/projects/remoting/).

Remember that nowadays, SSH works fine in Windows too. Use e.g. [OpenSSH](https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse). This is way more stable and secure than using JNLP, WinRM or so.

### Files and folders
- Dockerfile - uses jenkins/jenkins:lts docker image, installs the needed tools, installs the needed Jenkins plugins, and executes the groovy scripts for other Jenkins magic.
- jenkins-plugins - A text file containing the plugins that are wanted to be installed automatically.
- scripts/ - Folder for Groovy scripts, that are executed automatically every time that Jenkins boots up. Used for e.g. creating the default user and Jenkins jobs.

- Jenkinsfile - A simple [declarative pipeline](https://www.jenkins.io/doc/book/pipeline/syntax/#declarative-pipeline) for installing and running [Robot Framework RPA](https://robotframework.org/rpa/) tasks with [Robocorp CLI](https://robocorp.com/docs/product-manuals/robocorp-lab/robocorp-cli-manual) in an Ubuntu docker container, as well as parsing the Robot Framework results.

### How to proceed onto a Real Jenkins setup
- Think where you want to run your Jenkins, and especially where to run the jobs - EC2/Azure slaves, ECS, EKS/AKS, your own Kubernetes cluster, or whatnot. Don't run these on Jenkins master, or it'll only make your system unstable and overloaded.
- Make the setup secure: enable https, and configure the security groups / load balancers / firewall etc.
- Integrate into AD: use e.g. [SAML SSO](https://github.com/jenkinsci/saml-plugin) (Check the instructions and examples)
- Use [Role-based authorization strategy](https://plugins.jenkins.io/role-strategy/) and map the roles e.g. into AD groups.
- Need help in setting this up? Contact the author at jyri.ilama@gmail.com :)
