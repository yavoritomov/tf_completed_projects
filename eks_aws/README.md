# tf_completed_projects

https://www.youtube.com/watch?v=nIIxexG7_a8&list=PLiMWaCMwGJXkeBzos8QuUxiYT6j8JYGE5

To connect to the k8s cluster:
1. You need to use the same user that created the cluster. mfa
2. remove pre-existing kube config. rm ~/.kube/config
3. Config the kubectl via aws eks --region us-east-2 update-kubeconfig --name eks --profile mfa
4. There is an bug in kubectl client 1.24.0 had to downgrade to 1.23.6 ->  
   a. curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.23.6/bin/linux/amd64/kubectl
   b. mv ./kubectl /usr/local/bin/kubectl