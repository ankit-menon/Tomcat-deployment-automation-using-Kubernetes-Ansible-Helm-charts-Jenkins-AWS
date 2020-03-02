## War File Deployment Using Helm, Jenkins, Kubernetes, Docker and Ansible 

When we talk about automation and continuous delivery we usually do a bit of study and research before implementing anything which includes trying out different tools and software since it should work perfectly in the end.

This is one such guide to achieve this goal in an efficient manner.

..........................................................................................................................................


## Kubernetes cluster on AWS using KOPS –-


One of the primary steps is to get the kubernetes cluster up and running.
For this the best platform would be to go with any cloud provider , in this case it is AWS .

To achieve this,  install KOPS first in your local machine then follow the list –
1.	Route 53
2.	S3 bucket
3.	Finally k8s cluster with master and worker nodes .
4.	IAM user with permission to all these resources .

Install Kubectl following this so that the operations to the cluster can be performed from the command line , once kubectl is installed check out whether the cluster is up and running .

Kubectl get nodes 

Kubectl get pods 

kubectl get nodes -o wide


Using kubernetes makes it easier to scale and rollback the deployments if required and with methodologies like blue green deployments and canary releases the deployment process can be made of zero downtime .

............................................................................................................................................

## Installing Jenkins on Kubernetes using Helm charts –-


This is the best way to install dependencies and tools on kubernetes clusters since all the packages are available as charts in a central repository.

1.	Helm search Jenkins
2.	Helm inspect values stable/Jenkins > tmp/Jenkins.values
3.	Vi /tmp/Jenkins.values
4.	edit Jenkins.values file and change the port numbers to 8085:8085
5.	helm install myjenkins stable/Jenkins –values /tmp/Jenkins.values
6.	kubectl --namespace default port-forward $POD_NAME 8085:8085
7.	Access Jenkins on 127.0.0.1:8085

Now Jenkins is hosted on the Kubernetes cluster hosted by us in the previous step using KOPS .

Now Jenkins can be used to configure CI/CD pipelines .

Building Docker Image with the Sample War file details to be deployed –

First step would be to create the Docker file , please refer to the Dockerfile created in this repository for details .

The base image used is “tomcat:8.0”

The warfile used is “helloworld.war”

This Dockerfile is then built and pushed to the Dockerhub repository which will be later used for the deployment to Kubernetes cluster where Jenkins is hosted.

Dockerhub Repository details – ankitmnn7 / menzy_007

One thing to keep in mind is to use “-v /var/run/docker.sock:/var/run/docker.sock” along with the docker command.

The War file has to be called from the sorce repository and then it should be copied to the Webapps folder within the tomcat container using the dockerfile .

.............................................................................................................................................


 ## Pulling the docker image and deploying it on the K8s cluster created on AWS –-



The image that has to be built and deployed in the K8s pod is ready in the dockerhub mentioned above.

For this stage we will be using Ansible, since it makes managing deployments easier using the playbook.yaml file which is present in this repository.

For this the first prerequisite would be to install ansible in the master and worker nodes which is hosting the Jenkins.

Once this is available then the playbook.yaml file can be invoked from the jenkinsfile which would take care of the deployment.

Once the deployment is done it can be seen using – “kubectl get deployments”

.............................................................................................................................................

## Jenkins Settings–-


Once the Jenkins is up and running before running the Build pipeline there are some changes that needs to be made in the configurations.

1.	Add the dockerhub details in the Global Credentials 

2.	Add the Ansible installation details in the global tool configuration and specify the path where it is installed.

3.	Likewise add the Docker details in the global tool configuration.

4.	Next would be to create a new pipeline job and paste the Jenkinsfile inline or add the git path so that it pulls and then runs it.

5.	The stages would be run according to the structure in the Jenkinsfile.

.............................................................................................................................................
