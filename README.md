
![](https://github.com/dimaspriyo/ci-cd-demo/blob/main/screenshoots/flow.png)

1. User push new commit

2. User Trigger build pipeline

3. Jenkins build and push to private registry

4. Jenkins update kube deployment

5. Pull latest image from private registry


## Introduction

This Repo act as a personal note for learning and deploy CI/CD in local using :

1. Gitea

2. Jenkins

3. Private Docker Registry

4. K3s

  

### Prerequisites
	
1. Docker

2. Docker Compose

  

### Step By Step

  

We Need To Find And Replace strings into your network interface IP than reachable from k3s and from docker container

  

`chmod +x find_and_replace.sh && sh find_and_replace.sh . HOST_IP {YOUR_IP}` (example: 101.1.40.5)

  

1. Install K3s
`curl -sfL https://get.k3s.io | sh -s - --disable traefik`

![](https://github.com/dimaspriyo/ci-cd-demo/blob/main/screenshoots/k3s-running.png)

2. Create secret for private registry , we are using admin:admin
`chmod +x secret.sh && sh secret.sh`


3. Copy registries.yaml
`sudo cp registries.yaml /etc/rancher/k3s/registries.yaml`


4. Restart K3s
`sudo systemctl restart k3s`

5. Install Gitea
` docker-compose -f docker_compose_gitea.yml up -d`

	- Setup Organization For jenkins to scan repository
	![](https://github.com/dimaspriyo/ci-cd-demo/blob/main/screenshoots/gitea-organization.png)

	- Create New Repo for our demo app & init it in **app-fastapi** folder
	![](https://github.com/dimaspriyo/ci-cd-demo/blob/main/screenshoots/gitea-new-repo.png)

	- Push to gitea

  

6. Install Jenkins Agent  

Before deploy jenkins agent container , we need to copy and change the server ip in k3s.yaml and generate new ssh key

- Create New file jenkins/k3s.yaml with k3s your kubeconfig (/etc/rancher/k3s/k3s.yaml) and replace server ip with your HOST IP
	![](https://github.com/dimaspriyo/ci-cd-demo/blob/main/screenshoots/k3s-kubeconfig.png)

- Generate new ssh key for jenkins server and agent to communicate
`ssh-keygen -t rsa -f ./jenkins/jenkins_agent_key -N ''`

  

- Deploy The Jenkins Agent
	`docker-compose -f jenkins/docker_compose_jenkins_agent.yml build && docker-compose -f jenkins/docker_compose_jenkins_agent.yml up -d`

  ![](https://github.com/dimaspriyo/ci-cd-demo/blob/main/screenshoots/jenkins-new-runner-1.png)

  ![](https://github.com/dimaspriyo/ci-cd-demo/blob/main/screenshoots/jenkins-new-runner-2.png)

  ![](https://github.com/dimaspriyo/ci-cd-demo/blob/main/screenshoots/jenkins-new-runner-4.png)

  
7. Install Private Docker Registry
`docker-compose -f docker_compose_docker_registry_ui.yml up -d`

  

8. Install Jenkins Server
`docker-compose -f jenkins/docker_compose_jenkins.yml build && docker-compose -f jenkins/docker_compose_jenkins.yml up -d`

  

Check your container Log For predefined password

![](https://github.com/dimaspriyo/ci-cd-demo/blob/main/screenshoots/jenkins-predefined-password.png)


![](https://github.com/dimaspriyo/ci-cd-demo/blob/main/screenshoots/jenkins-sugested-plugin.png)

- Install Plugins

![](https://github.com/dimaspriyo/ci-cd-demo/blob/main/screenshoots/jenkins-plugin.png)

- Configure Gitea Plugin

![](https://github.com/dimaspriyo/ci-cd-demo/blob/main/screenshoots/jenkins-gitea-configure.png)

Once Gitea version appears, it mean succesfully connected

- Add Jenkins Runner

![](https://github.com/dimaspriyo/ci-cd-demo/blob/main/screenshoots/jenkins-new-runner-1.png)

![](https://github.com/dimaspriyo/ci-cd-demo/blob/main/screenshoots/jenkins-new-runner-2.png)

![](https://github.com/dimaspriyo/ci-cd-demo/blob/main/screenshoots/jenkins-new-runner-3.png)


  9. Trigger build in Jenkins Job 
![](https://github.com/dimaspriyo/ci-cd-demo/blob/main/screenshoots/jenkins-job.png)

  10. Trigger build in Jenkins Job 
![](https://github.com/dimaspriyo/ci-cd-demo/blob/main/screenshoots/app-fastapi-running.png)

![](https://github.com/dimaspriyo/ci-cd-demo/blob/main/screenshoots/curl-success.png)

### Reference Link

- https://github.com/Joxit/docker-registry-ui

- https://docs.k3s.io/installation

- https://argo-cd.readthedocs.io/en/stable/operator-manual/installation/

- https://medium.com/@kumarkotamahesh/how-to-install-argocd-in-ubuntu-using-k3s-as-light-weighted-kubernetes-99c2f3af3434

- https://medium.com/@eloufirhatim/install-jenkins-using-docker-e76f41f79682

- https://mike42.me/blog/2019-05-how-to-integrate-gitea-and-jenkins

- Chat GPT (of course..)