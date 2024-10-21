# Criando Máquinas Virtuais na Azure

Este documento oferece uma visão geral sobre como criar máquinas virtuais na plataforma da Azure, usando também o Terraform, uma ferramenta de automação de infraestrutura que permite gerenciar a infraestrutura como código (IaC).

## O que é uma Máquina Virtual?

As Máquinas Virtuais (VMs) são instâncias de servidores baseados em nuvem, que podem rodar diversos sistemas operacionais, como Windows e Linux. Elas são amplamente usadas para:
- Desenvolvimento e testes de software.
- Execução de aplicativos em produção.
- Escalabilidade de workloads sem a necessidade de gerenciar hardware físico.

## Requisitos para Criar VMs na Azure

Antes de começar, certifique-se de:
- Ter uma **conta na Azure** (é possível utilizar uma conta gratuita).

# Estrutura do Projeto

```
AzureVirtualMachine/
│
├──Infra/
│    └── main.tf
│
└── README.md
```


## 1. **Criando uma Máquina Virtual pelo Portal da Azure**

### Passo 1: Acesse o Portal da Azure

- Acesse o *Portal da Azure* **https://portal.azure.com/**.
- Faça login com suas credenciais.

### Passo 2: Navegue até "Máquinas Virtuais"

- No painel à esquerda, clique em **Máquinas Virtuais** (ou busque "Máquinas Virtuais" na barra de pesquisa).
- Clique em **+ Adicionar** e, em seguida, em **Máquina Virtual**.

### Passo 3: Configuração da VM

- **Grupo de Recursos**: Selecione um grupo de recursos existente ou crie um novo.
- **Nome da VM**: Dê um nome descritivo à sua VM (por exemplo, `DevVM`).
- **Região**: Escolha a região onde deseja hospedar a VM (por exemplo, "Brazil South").
- **Imagem**: Selecione a imagem do sistema operacional. Exemplo: **Ubuntu Server 18.04 LTS**.
- **Tamanho da VM**: Selecione o tamanho e a configuração de hardware da VM. Exemplo: `Standard_DS1_v2`.

### Passo 4: Autenticação

- **Usuário**: Escolha um nome de usuário para acessar a VM (por exemplo, `azureuser`).
- **Autenticação**: Opte por utilizar **senha** ou **chave SSH**. Para maior segurança, é recomendável usar chave SSH.
  - Se escolher chave SSH, cole a chave pública no campo apropriado.
  - Link de ajuda para configurar o SSH: [link].

### Passo 5: Configuração de Rede

- **Rede Virtual (VNet)**: Use uma VNet existente ou crie uma nova.
- **Sub-rede**: Use uma sub-rede existente ou crie uma nova dentro da VNet selecionada.
- **Endereço IP Público**: Habilite um IP público para acesso remoto.
- **Grupo de Segurança de Rede (Firewall)**: Abra as portas necessárias, como **SSH (porta 22)** para máquinas Linux ou **RDP (porta 3389)** para máquinas Windows.

### Passo 6: Discos e Armazenamento

- Configure o disco do sistema operacional (OS Disk) e, opcionalmente, adicione discos de dados adicionais, conforme suas necessidades.

### Passo 7: Revisar e Criar

- Clique em **Revisar + Criar** para validar as configurações.
- Clique em **Criar** para iniciar a criação da VM. A criação pode levar alguns minutos.

## 2. **Criando uma VM pelo Terraform**

### Requisitos necessários:

Para criar devidamente sua VM, certifique-se de:
1. Instalar o **Terraform** na sua máquina local.
2. Configurar a **Azure CLI** para autenticação.

### Instalação da Azure CLI

Caso não tenha instalado a Azure CLI, utilize o seguinte comando:

**Para rodar no Windows:**
```bash
winget install Microsoft.AzureCLI
```

**Para rodar no Linux:**
```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

**Para rodar no MacOS:**
```bash
brew update && brew install azure-cli
```

Em seguida faça o login na Azure utilizando:

```bash
az login
```
Após executar `az login`, uma janela será aberta na Azure onde você deverá inserir suas credenciais. Caso você esteja usando o terminal, será solicitado que você insira um código para autenticação.

### Criação e execução do Terraform
Após a autenticação realizada anteriormente realize os seguintes passos:
1. Criar um arquivo `main.tf` (como este presente na pasta `infra`).
2. Iniciar o Terraform
3. Planejar a infra (gera um plano de execução, afim de verificar o que será criado)
4. Aplicar a configuração (neste passo, cria a VM e seus recursos)

### Inicializar o Terraform
```bash
terraform init
```

### Planejar a infra
```bash
terraform plan
```

### Aplicar a configuração
```bash
terraform apply
```