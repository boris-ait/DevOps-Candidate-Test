
# DevOps Test

Hi,
Welcome to our Git Repo for your skills tests for positions within our DevOps team. 

To begin, fork this repo, add your work and send us a link to your repo.

Good Luck
  
## Prepare an app
  Use your tool of choice Bash | Powershell or Python, the file will recieve and argument a version number or will take the version from environment variable
  1. Use this repo - https://github.com/johnpapa/node-hello
  2. Change the version of node app to version 1.1.0
  3. Download this reademe file into the app root folder
  4. Zip the file app folder with the name app-1.1.0.zip 

     [prep_app.sh](prep_app.sh) script added to the repo
 

## Dockerize the app

  1. Create a container that will contain the app 
  
  After runnig [prep_app.sh](prep_app.sh) got to node-hello/ directory and build the image using [Dockerfile](Dockerfile)
  ```bash
     cd node-hello/
     docker build -t node-hello-app ../DevOps-Candidate-Test/Dockerfile 
  ```
  2. Write a command to run the docker on port 5000

      ```bash
       docker run -p 5000:3000 node-hello-app 
       ```
  3. Prepare a kubernetes deployment file that will:
  
    a. Deploy two replicas of the app
    
    b. Contain an nginx or haproxy that will proxy the app so the app will be available from port 80

    c. For kuberentes - Suppose the app does not support environment variables and there is a json configuration file for the app.
       How would you configure it from the deploy pipeline to support different deployments (QA | Staging | Prod). What would you recommend for storing passwords. 

[node_hello.yml](node_hello.yml) contains resources for 3 a. b. requirements.

Regarding 3 c.:

ConfigMaps for different enviromnet could be created as per below example:
```bash
kubectl create configmap app-config-qa --from-file=config.json=./config-qa.json
kubectl create configmap app-config-staging --from-file=config.json=./config-staging.json
kubectl create configmap app-config-prod --from-file=config.json=./config-prod.json

```
And mount the appropriate ConfigMap as a volume in pod's deployment configuration.
For example:
```yaml
spec:
  containers:
    - name: your-app-container
      # ...
      volumeMounts:
        - name: config-volume
          mountPath: /app/config.json
          subPath: config.json
  volumes:
    - name: config-volume
      configMap:
        name: app-config-<ENVIRONMENT>  # Use the appropriate ConfigMap name for each environment
```
And of course everything could be templated by using helm.

For the secrets Secret Store CSI Driver could be used for example for AWS Secret manager as explained here https://github.com/aws/secrets-store-csi-driver-provider-aws


 Please Send us the script file, the docker files and the answers to 3c (instead you can add the solution to the docker | k8s files)
     
 Good Luck
  
  
  
  
  
  
  
