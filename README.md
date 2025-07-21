# Deploy Static Nginx App to AWS using Docker, ECR, ECS Fargate, Terraform & GitHub Actions CI/CD 🚀

## 📋 Project Overview

This project demonstrates a complete **DevOps pipeline** that automates the deployment of a containerized static web application to AWS. You'll learn how to build, containerize, and deploy applications using industry-standard tools and practices.

### What You'll Learn
- **Docker containerization** for static web applications
- **AWS cloud services** (ECR, ECS Fargate, Application Load Balancer)
- **Infrastructure as Code (IaC)** with Terraform modules
- **CI/CD automation** with GitHub Actions
- **DevOps best practices** for production deployments

## 🏗️ Architecture Overview

```
┌─────────────────┐    ┌────────────────┐      ┌───────────────┐
│   GitHub Repo   │───▶│ GitHub Actions │───▶ │   Terrafrom   │
│  (Source Code)  │    │   (CI/CD)      │      │     (IaC)     │
└─────────────────┘    └────────────────┘      └───────────────┘
                                                     │
                                                     ▼
┌─────────────────┐    ┌──────────────┐    ┌─────────────────┐
│   Amazon ECR    │◀───│   AWS ECS    │◀───│  Load Balancer  │
│  (Container Reg)│         Fargate    │    │      (ALB)      │
└─────────────────┘    └──────────────┘    └─────────────────┘
```

**Components:**
- **Terraform**: Manages all AWS infrastructure as code
- **GitHub Actions**: Automates the entire deployment pipeline
- **Docker**: Containerizes the Nginx static app
- **Amazon ECR**: Stores Docker images securely
- **ECS Fargate**: Runs containers without managing servers
- **Application Load Balancer**: Distributes traffic and provides public access


## 🛠️ Technologies Used

- **Containerization**: Docker, Nginx
- **Cloud Platform**: AWS (ECR, ECS, ALB)
- **Infrastructure as Code**: Terraform with custom modules
- **CI/CD**: GitHub Actions
- **Version Control**: Git & GitHub

## 📁 Project Structure

```
├── .github/workflows/        # GitHub Actions CI/CD pipelines
│   ├── modules/              # Custom Terraform modules
│   │   ├── ecr/              # ECR module for container registry
│   │   ├── ecs/              # ECS module for container orchestration
│   │   └── alb/              # ALB module for load balancing
│   ├── main.tf               # Main Terraform configuration
│   ├── variables.tf          # Terraform variables
│   └── outputs.tf            # Terraform outputs
├── Index.html                # Preview File
├── Dockerfile                # Docker configuration
└── README.md                 # Project documentation
```

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have:

1. **AWS Account** with appropriate permissions
2. **GitHub Account** for version control and CI/CD
3. **Basic understanding** of:
   - Command line/terminal
   - Git version control
   - Basic web development concepts

### Required Tools (will be installed during setup)
- AWS CLI
- Terraform
- Docker
- Git

## 📝 Step-by-Step Implementation Guide

### Phase 1: Repository Setup & Local Development

#### 1. Clone and Explore the Repository
```bash
https://github.com/muhammadhabiburrehman/Deploy_Nginx_on_AWS_with_ECR_ECS_Terraform_GitHub-Actions_Pipeline.git
cd Deploy_Nginx_on_AWS_with_ECR_ECS_Terraform_GitHub-Actions_Pipeline
```

**What's happening:** You're downloading the project code to your local machine and exploring the file structure.

#### 2. Understand the Application
- Check the `Dockerfile` to understand how the app is containerized
- The Dockerfile uses Nginx as a web server to serve static content

**Key concept:** Docker packages your application and its dependencies into a container that runs consistently anywhere.

### Phase 2: AWS Account & Credentials Setup

#### 3. Configure AWS Access
- Create an AWS account if you don't have one
- Create an IAM user with programmatic access
- Generate Access Key ID and Secret Access Key
- Required permissions: ECR, ECS, ALB, IAM

**Security note:** Never commit AWS credentials to your repository. You'll store them securely in GitHub Secrets.

#### 4. Set Up GitHub Secrets
In your GitHub repository, go to Settings → Secrets and Variables → Actions, and add:
- `AWS_ACCESS_KEY_ID`: Your AWS access key
- `AWS_SECRET_ACCESS_KEY`: Your AWS secret key
- `AWS_REGION`: Your preferred AWS region (e.g., us-east-1)(optional)

**Why this matters:** GitHub Secrets keep your credentials secure and allow GitHub Actions to access AWS on your behalf.

### Phase 3: Understanding Terraform Modules

#### 5. Explore Terraform Structure
Your project uses **modular Terraform** for better organization:

**ECR Module (`modules/ecr/`):**
- Creates a private Docker registry in AWS
- Stores your containerized application images
- Manages image lifecycle policies

**ECS Module (`modules/ecs/`):**
- Sets up ECS Fargate cluster
- Defines task definitions (how containers should run)
- Configures services (ensures containers stay running)
- Manages auto-scaling and health checks

**ALB Module (`modules/alb/`):**
- Creates an Application Load Balancer
- Configures target groups for routing traffic
- Sets up security groups for network access
- Provides a public endpoint for your application

#### 6. Review Main Configuration
- `terraform/main.tf`: Calls all modules and connects them together
- `terraform/variables.tf`: Defines configurable parameters
- `terraform/outputs.tf`: Returns important information (like your app's URL)

### Phase 4: Understanding the CI/CD Pipeline

#### 7. GitHub Actions Workflow Analysis
Your `.github/workflows/` contains automated pipelines:

**Build and Deploy Workflow:**
1. **Trigger**: Runs on pushes to main branch
2. **Build**: Creates Docker image from your code
3. **Push**: Uploads image to Amazon ECR
4. **Deploy**: Updates ECS service with new image
5. **Notify**: Reports deployment status

**Infrastructure Workflow:**
1. **Plan**: Shows what Terraform will create/change
2. **Apply**: Creates/updates AWS infrastructure
3. **Destroy**: (Optional) Cleans up resources to avoid costs

### Phase 5: Deployment Process

#### 8. Initial Infrastructure Deployment
1. **Fork this repository** to your GitHub account
2. **Update variables** in `variables.tf` if needed
3. **Push changes** to trigger GitHub Actions
4. **Monitor the workflow** in the Actions tab

**What happens automatically:**
- Terraform creates all AWS resources
- Docker builds your application image
- Image is pushed to ECR
- ECS deploys containers
- Load balancer makes your app publicly accessible

#### 9. Monitor Deployment
- Check GitHub Actions logs for any errors
- AWS Console: Verify resources are created
- ECS Console: Ensure tasks are running healthy
- Load Balancer: Get your application URL

### Phase 6: Testing & Verification

#### 10. Access Your Application
- Find the Load Balancer DNS name in Terraform outputs
- Open the URL in your browser
- Verify your static application loads correctly

#### 11. Test CI/CD Pipeline
- Make a change to your static content in `index.html`
- Commit and push changes
- Watch GitHub Actions automatically rebuild and redeploy
- Verify changes appear on your live site

### Phase 7: Monitoring & Troubleshooting

#### 12. Monitor Application Health
**AWS Console locations to check:**
- **ECS**: Task status, health checks, logs
- **CloudWatch**: Application and infrastructure logs
- **Load Balancer**: Target group health

**Common issues and solutions:**
- **Tasks failing**: Check ECS task logs
- **502/503 errors**: Verify security group rules
- **Image pull errors**: Check ECR permissions

### Phase 8: Resource Cleanup

#### 13. Destroy Infrastructure (Important!)
To avoid AWS charges:
1. Trigger the destroy workflow in GitHub Actions, OR
2. Run `terraform destroy` locally

**Cost consideration:** This project uses resources that incur charges. Always clean up when done experimenting.

## 🔧 Customization Options

### Modify the Application
- Update files in `index.html` directory
- Changes automatically deploy via CI/CD

### Change AWS Region
- Update region in GitHub Secrets
- Modify `terraform/variables.tf`

### Add Custom Domain
- Configure Route 53 in ALB module
- Add SSL certificate via ACM

## 📚 Learning Resources

### Understand the Technologies
- **Docker**: [Official Docker Tutorial](https://docs.docker.com/get-started/)
- **AWS ECS**: [ECS Developer Guide](https://docs.aws.amazon.com/ecs/)
- **Terraform**: [Terraform Learn](https://learn.hashicorp.com/terraform)
- **GitHub Actions**: [Actions Documentation](https://docs.github.com/en/actions)

### Best Practices Applied
- **Infrastructure as Code**: All resources defined in version control
- **Immutable Deployments**: New container images for each deployment
- **Security**: Credentials stored securely, least-privilege access
- **Modularity**: Reusable Terraform modules
- **Automation**: Fully automated CI/CD pipeline

## 🚨 Important Notes

### Security Considerations
- Never commit AWS credentials to the repository
- Use IAM roles with minimal required permissions
- Regularly rotate access keys
- Monitor AWS CloudTrail for security events

### Cost Management
- **ECS Fargate**: Charges for vCPU and memory usage
- **Load Balancer**: Hourly charges plus data processing
- **ECR**: Storage charges for Docker images
- **Always destroy resources** when not needed

### Production Readiness
This is a learning project. For production use, consider:
- Multiple availability zones
- Auto-scaling policies
- SSL/TLS certificates
- Monitoring and alerting
- Backup strategies
- Database integration

## 🤝 Contributing

Feel free to:
- Report issues or bugs
- Suggest improvements
- Submit pull requests
- Share your deployment experiences

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🎯 Next Steps

After completing this project, consider:
1. **Add a database** (RDS) to make it dynamic
2. **Implement monitoring** with CloudWatch dashboards
3. **Add security scanning** to your CI/CD pipeline
4. **Explore blue/green deployments** for zero-downtime updates
5. **Learn Kubernetes** as the next container orchestration step

---

**Congratulations!** 🎉 You've built a production-ready DevOps pipeline. This experience covers real-world skills used by DevOps engineers and cloud architects in the industry.