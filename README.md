# 📋 Contact List Application — AWS Infrastructure with Terraform

A production-grade, highly available web application deployed on AWS using Terraform with a modular infrastructure design. The application is built with Python/Flask and MySQL, served behind an Application Load Balancer with Auto Scaling capabilities.

---

## 🏗️ Architecture Overview

> 📌 **See `/docs/architecture-diagram.png` for the full architecture diagram.**

```
Internet
   │
   ▼
Route 53 (DNS)
   │
   ▼
Application Load Balancer (ALB)
   │          │
   ▼          ▼
EC2 (AZ-1)  EC2 (AZ-2)      ← Auto Scaling Group
   │
   ▼
Amazon RDS — MySQL
```

### AWS Services Used

| Service | Purpose |
|---|---|
| **VPC** | Isolated network environment |
| **EC2** | Application servers (Amazon Linux 2, t4g.micro) |
| **Auto Scaling Group** | High availability — min: 1, desired: 2, max: 3 |
| **Application Load Balancer** | Traffic distribution across EC2 instances |
| **Amazon RDS (MySQL)** | Managed relational database |
| **Route 53** | DNS management |
| **Security Groups** | Network-level access control |

---

## 📁 Project Structure

```
tf-files/
├── backend/          # Remote state configuration
├── modules/          # Reusable Terraform module
│   ├── main.tf       # ALB, ASG, RDS, Security Groups
│   ├── data.tf       # Data sources (AMI, subnets, VPC)
│   ├── variable.tf   # Input variables
│   ├── output.tf     # Output values
│   ├── provider.tf   # AWS provider configuration
│   └── userdata.sh   # EC2 bootstrap script
├── dev/              # Development environment
└── prod/             # Production environment
contact-list-app.py   # Flask application
templates/            # HTML templates
```

---

## 🚀 Getting Started

### Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.0
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials
- An AWS account with sufficient permissions

### Deployment

**1. Clone the repository**
```bash
git clone https://github.com/ckribrahim/Aws-Contact-List-App-Infrastructure-Terraform.git
cd Aws-Contact-List-App-Infrastructure-Terraform
```

**2. Initialize Terraform**
```bash
cd tf-files/prod
terraform init
```

**3. Review the plan**
```bash
terraform plan
```

**4. Deploy**
```bash
terraform apply
```

**5. Access the application**

After a successful apply, Terraform will output the ALB DNS name and Route 53 URL. Open the URL in your browser — the application typically takes **3–5 minutes** to become healthy after the instances boot.

---

## ⚙️ Configuration

Key variables can be configured in `prod/terraform.tfvars`:

| Variable | Description |
|---|---|
| `instance_type` | EC2 instance type (default: `t4g.micro`) |
| `db_name` | RDS database name |
| `db_username` | RDS master username |
| `db_password` | RDS master password (use secrets manager in production) |
| `min_size` | ASG minimum instance count |
| `desired_capacity` | ASG desired instance count |
| `max_size` | ASG maximum instance count |

---

## 🔒 Security Design

- **ALB Security Group**: Accepts inbound HTTP (port 80) from the internet
- **EC2 Security Group**: Accepts inbound traffic **only from the ALB Security Group** — no direct public access
- **RDS Security Group**: Accepts inbound MySQL (port 3306) **only from the EC2 Security Group**
- EC2 instances are in **public subnets** behind the ALB; RDS is isolated with its own security group

---

## 🔁 How the EC2 Bootstrap Works

Each EC2 instance is configured via a **user data script** that runs at launch:

```bash
yum install python3 gcc python3-devel git -y
pip3 install flask flask_mysql pymysql cryptography
git clone https://github.com/<user>/Aws-Contact-List-App-Infrastructure-Terraform.git
cd Aws-Contact-List-App-Infrastructure-Terraform
python3 contact-list-app.py
```

The Auto Scaling Group uses a **Launch Template** so every new instance automatically pulls the latest application code from GitHub and starts the Flask server.


## 🧹 Cleanup

To avoid unnecessary AWS charges:

```bash
terraform destroy
```

> ⚠️ This will permanently delete all provisioned resources including the RDS database.

---

## 📌 Notes

- This project was built as part of a DevOps portfolio to demonstrate Terraform infrastructure-as-code skills on AWS.
- The modular Terraform structure (`modules/`) makes it easy to reuse components across `dev` and `prod` environments.
- For a production deployment, consider adding: HTTPS (ACM + ALB), secrets management (AWS Secrets Manager), and a private subnet for RDS.

---

## 👤 Author

Ibrahim Cakir — Java Developer  | Cloud & DevOps  
🔗 [GitHub](https://github.com/ckribrahim)  

