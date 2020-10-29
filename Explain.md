# This is to simple explain what is happening here

1. Install awscli, eksctl, kubectl for future use. 
2. Use awscli to create respective roles to access EKS services from code pipeline later. 
3. Use eksctl to create a default simple EKS cluster with independent VPC. eksctl will automatically set up kubectl to look at its cluster in AWS EKS. So after running eksctl, can directly use kubectl to check the nodes, etc. 
4. user this command to get the config done with adding new role
``` kubectl get -n kube-system configmap/aws-auth -o yaml > /tmp/aws-auth-patch.yml ```

```yaml
- rolearn: arn:aws:iam::1234567890:role/UdacityFlaskDeployCBKubectlRole
      username: build
      groups:
        - system:masters
```

5. Use the ci-cd-codepipeline.cfn.yml to provision the code pipeline resources to watch the github with code build project ready to build on new master branch merge. 
6. Code build project will automatically take the buildspec.yml to build when it is triggered.
7. The buildspec.yml has a docker build command, which is using Dockerfile as the instruction to build the image in codebuild. 
8. In the Dockefile, pip packages are installed, including gunicorn. gunicorn command will be use to start the server as ENTRYPOINT in Dockerfile on production ready base. 
9. As post build of the buildspec.yml, kubectl apply command is triggered to apply the simple_jwt_api.yml.This is a service kubernetes manifest to run the application as a service. It will run the image as a service in the pods. 
