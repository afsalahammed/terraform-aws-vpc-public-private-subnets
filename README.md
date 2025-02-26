# **Terraform AWS VPC with Public & Private Subnets** 🚀

## **Overview**
This project provisions an **AWS VPC with both public and private subnets** using **Terraform**. The setup includes:
- A **VPC** with a defined CIDR block.
- A **Public Subnet** (accessible via the Internet Gateway).
- A **Private Subnet** (only accessible via a NAT Gateway or Bastion Host).
- An **Internet Gateway (IGW)** for public internet access.
- A **NAT Gateway** for outbound access from private instances.
- **Route Tables** to control traffic flow.
- **Security Groups** to enforce access rules.
- **EC2 Instances** in both subnets:
  - A **Public Instance** (acts as a Bastion Host if needed).
  - A **Private Instance** (accessible only via the Public Instance).

## **Prerequisites**
Before running this Terraform project, ensure you have:
- An **AWS account**.
- **Terraform installed** (≥ v1.0).
- An **AWS key pair** for SSH access.

## **Project Structure**
```
terraform-aws-vpc/
│── provider.tf        # AWS provider configuration
│── variables.tf       # Input variables for flexibility
│── vpc.tf             # VPC creation
│── subnets.tf         # Public & Private Subnet creation
│── network.tf         # IGW, NAT Gateway & Route Tables
│── security.tf        # Security Groups for EC2 instances
│── ec2.tf             # EC2 instances deployment
│── output.tf          # Output values for resources
│── README.md          # Project documentation
```

## **Terraform Setup & Deployment**
Run the following commands to deploy the infrastructure:

1️⃣ **Initialize Terraform**
```sh
terraform init
```

2️⃣ **Preview the Changes**
```sh
terraform plan
```
📌 **Note:** Terraform will prompt you to enter the **key pair name** as it is marked **sensitive** in `variables.tf`.

3️⃣ **Apply the Configuration**
```sh
terraform apply -auto-approve
```

4️⃣ **View Outputs**
```sh
terraform output
```
This will display **Public Instance IP & Private Instance Private IP**.

5️⃣ **Destroy the Infrastructure (if needed)**
```sh
terraform destroy -auto-approve
```

## **Accessing the Instances**
Since the **private instance has no public IP**, you need to SSH into it via the **public instance**.

### **Step 1: Copy the SSH Key to the Public Instance**
```sh
scp -i your-key.pem your-key.pem ubuntu@PUBLIC_IP:/home/ubuntu/
```
- Replace `your-key.pem` with your **actual key file**.
- Replace `PUBLIC_IP` with the **public instance's IP** from Terraform output.

### **Step 2: SSH into the Public Instance**
```sh
ssh -i your-key.pem ubuntu@PUBLIC_IP
```

### **Step 3: Change Key Permissions on the Public Instance**
```sh
chmod 400 your-key.pem
```

### **Step 4: SSH into the Private Instance**
```sh
ssh -i your-key.pem ubuntu@PRIVATE_IP
```
- Replace `PRIVATE_IP` with the **private instance’s IP** from Terraform output.

✅ **Expected Result:** You should now be logged into the private EC2 instance! 🎉

## **Resources Created**
| Resource         | Description |
|-----------------|-------------|
| **VPC** | Creates an isolated virtual network in AWS |
| **Public & Private Subnets** | Segregates resources for security and efficiency |
| **Internet Gateway** | Provides internet access to the public subnet |
| **NAT Gateway** | Allows private subnet instances to reach the internet securely |
| **Route Tables** | Manages traffic flow between subnets |
| **Security Groups** | Controls inbound & outbound traffic for instances |
| **EC2 Instances** | Deploys public and private instances |

## **Outputs**
After deployment, Terraform will display:
- **VPC ID**
- **Public Subnet ID & Private Subnet ID**
- **Internet Gateway & NAT Gateway IDs**
- **Public Instance ID & Public IP**
- **Private Instance ID & Private IP**

## **Security Considerations**
⚠ **Restrict SSH Access** → Change `"0.0.0.0/0"` to your IP in `security.tf` for better security.  
⚠ **Ensure Private Key Security** → Do not expose the key pair in logs or public repositories.  
⚠ **Limit Outbound Access in Private Subnet** → Allow only necessary ports for communication.  

## **Next Steps**
- **Test SSH access to both instances.**
- **Improve security by restricting inbound rules further.**
- **Extend with additional services (e.g., Load Balancer, RDS, Monitoring).** 🚀

---

### **Contributing**
Feel free to fork this repo and enhance the project! 😊
