# 🚀 Cleanora AWS Infrastructure (Terraform + CI/CD)
## 🌍 Live Demo 🚀
The project is live here 👉 d1jskvl1ulsdp8.cloudfront.net

This project provisions a **full production-grade AWS infrastructure** using Terraform with a complete CI/CD pipeline.


---

## 🏗️ Architecture Overview

The infrastructure includes:

* 🌐 VPC with public & private subnets
* 🚪 Internet Gateway & NAT Gateway
* ⚖️ Application Load Balancer (ALB)
* 📈 Auto Scaling Group (ASG)
* 🔐 AWS WAF (SQLi + Common + Rate Limiting)
* 📊 CloudWatch dashboards & alarms
* 🔔 SNS notifications
* 🔑 IAM roles & instance profiles
* 🪣 S3 (static hosting + logs + artifacts)

---

## ⚙️ CI/CD Pipeline

Every push to `main` triggers:

1. Terraform Init
2. Terraform Validate
3. Terraform Format Check
4. Terraform Plan
5. Manual approval (production)
6. Terraform Apply

---

## 🚀 How to Use

### 1. Initialize Terraform

```bash
terraform init
```

### 2. Plan Infrastructure

```bash
terraform plan
```

### 3. Apply Infrastructure

```bash
terraform apply
```

---

## 🔐 Security Features

* AWS WAF protection (SQL Injection, Common attacks)
* Rate limiting (DDoS mitigation)
* Private EC2 instances
* IAM least privilege roles
* SSM access enabled

---

## 📊 Monitoring

* CloudWatch dashboards
* CPU utilization tracking
* ALB 5XX error alarms
* Auto Scaling health monitoring
* SNS email alerts

---

## 📂 Project Structure

```
.
├── modules/
├── envs/
├── .github/workflows/
├── main.tf
├── variables.tf
└── backend.tf
```

---

## 👨‍💻 Author

Built as a DevOps/Cloud Engineering project using AWS + Terraform + GitHub Actions.
## 📬 Contact * email >waela8214@gmail.com 
* LinkedIn: (https://www.linkedin.com/in/ahmed-wael-abdelaziz-ahmed-gouhar-1a679a301/)
