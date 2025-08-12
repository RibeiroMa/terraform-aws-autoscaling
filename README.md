
# Autoscaling AWS em Terraform

Esse repositório é uma amostra dos meus conhecimentos em ambiente AWS e Terraform.

Este projeto provisiona automaticamente, via Terraform, uma aplicação web na AWS com alta disponibilidade, balanceamento de carga e escalabilidade automática baseada em métricas de utilização de CPU.


A infraestrutura provisionada inclui:


- VPC com subnets públicas e privadas em múltiplas zonas de disponibilidade

- Internet Gateway e NAT Gateway para conectividade externa.

- Application Load Balancer (ALB) público para distribuir tráfego.

- Auto Scaling Group (ASG) com instâncias EC2 em subnets privadas.

- CloudWatch Alarms para escalar horizontalmente:
     - Scale Up: quando a CPU ultrapassa um limite.
     - Scale Down: quando a CPU cai abaixo de um limite.

- Bucket S3 com versionamento para armazenar o estado do Terraform.

- Security Groups segmentados para ALB, EC2 e NAT.

- Script de inicialização (User Data) para instalar Apache2 e exibir uma página HTML.

## Estrutura dos Arquivos

| Arquivo               | Função                                               |
| ----------------- | ---------------------------------------------------------------- |
| alb.tf       | Configura o Application Load Balancer. |
| cloudwatch.tf       | Configura alarmes para scale up/scale down.|
| ec2_setup.sh      | Script de inicialização das EC2. |
| ec2.tf      | Cria o Launch Template, Auto Scaling Group e políticas. |
| locals.tf       | Define variáveis locais reutilizadas. |
| provider.tf       | Configura o provedor AWS e região. |
| s3.tf       | Cria bucket S3 para versionamento do estado do Terraform. |
| sg.tf       | Define os Security Groups. |
| vpc.tf       | Cria a VPC, subnets, route tables e gateways. |

## Pré-requisitos

 Pré-requisitos
Terraform ≥ 1.3.x

Conta AWS configurada com credenciais (via aws configure ou variáveis de ambiente)

Permissões para criar:

VPC, Subnets, Gateways

EC2, ALB, Auto Scaling, CloudWatch

S3 Buckets


## Como utilizar

1 . Clone esse reposítório

```bash
  git clone https://github.com/RibeiroMa/terraform-aws-autoscaling
  cd terraform-aws-autoscaling

```
2 . Inicialize o Terraform
```bash
terraform init
```

3 . Planeje a criação dos recursos
```bash
terraform plan
```

4 . Aplique os recursos
```bash
terraform apply
```
5 . Acessar a aplicação
- Após a criação, pegue o DNS do ALB no console AWS ou via output do Terraform e abra no navegador.

6 . 
Rodar o stress-ng para simular carga de CPU nos testes de Auto Scaling.
```bash
sudo stress-ng --cpu 32 --timeout 180 --metrics-brief
```

6 . Após o uso
```bash
terraform destroy
```
