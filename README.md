# terraform-aws-autoscaling

Autoscaled architecture on AWS with Terraform

🚀 Arquitetura AWS Auto Scaling com Terraform
Este projeto provisiona automaticamente, via Terraform, uma aplicação web na AWS com alta disponibilidade, balanceamento de carga e escalabilidade automática baseada em métricas de utilização de CPU.

📜 Arquitetura
A infraestrutura provisionada inclui:

VPC com subnets públicas e privadas em múltiplas zonas de disponibilidade.

Internet Gateway e NAT Gateway para conectividade externa.

Application Load Balancer (ALB) público para distribuir tráfego.

Auto Scaling Group (ASG) com instâncias EC2 em subnets privadas.

CloudWatch Alarms para escalar horizontalmente:

Scale Up: quando a CPU ultrapassa um limite.

Scale Down: quando a CPU cai abaixo de um limite.

Bucket S3 com versionamento para armazenar o estado do Terraform.

Security Groups segmentados para ALB, EC2 e NAT.

Script de inicialização (User Data) para instalar Apache2 e exibir uma página HTML.

📂 Estrutura dos Arquivos
Arquivo	Função
provider.tf	Configura o provedor AWS e região.
vpc.tf	Cria a VPC, subnets, route tables e gateways.
sg.tf	Define os Security Groups.
alb.tf	Configura o Application Load Balancer.
ec2.tf	Cria o Launch Template, Auto Scaling Group e políticas.
cloudwatch.tf	Configura alarmes para scale up/scale down.
s3.tf	Cria bucket S3 para versionamento do estado do Terraform.
locals.tf	Define variáveis locais reutilizadas.
ec2_setup.sh	Script de inicialização das EC2.
