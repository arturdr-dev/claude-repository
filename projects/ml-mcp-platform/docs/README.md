# 🤖 ML-MCP Platform - Arquitetura Modular

## 📋 Visão Geral
Plataforma integrada de Machine Learning com Model Context Protocol (MCP) para orquestração de workflows, containers Docker e automação via n8n.

## 🏗️ Estrutura do Projeto

```
ml-mcp-platform/
├── docker/                 # Configurações Docker
│   ├── Dockerfile         # Imagem principal
│   ├── docker-compose.yml # Orquestração de serviços
│   └── mcp-services/      # Serviços MCP containers
├── n8n-workflows/         # Workflows de automação
│   ├── data-processing/   # Pipelines de dados
│   ├── model-training/    # Treinamento de modelos
│   └── deployment/        # Deploy automatizado
├── models/               # Modelos ML
│   ├── training/         # Scripts de treino
│   ├── inference/        # Inferência
│   └── evaluation/       # Avaliação
├── data/                 # Dados
│   ├── raw/             # Dados brutos
│   ├── processed/       # Dados processados
│   └── models/          # Modelos treinados
├── services/            # Microsserviços
│   ├── api-gateway/     # Gateway de APIs
│   ├── model-server/    # Servidor de modelos
│   └── monitoring/      # Monitoramento
└── config/              # Configurações
    ├── mcp-config.json  # Config MCP
    ├── models.yaml      # Config dos modelos
    └── services.env     # Variáveis de ambiente
```

## 🔧 Tecnologias Integradas

### MCPs Disponíveis
- ✅ **Docker MCP Gateway** - Gerenciamento de containers
- ✅ **Filesystem MCP** - Manipulação de arquivos
- ✅ **n8n MCP** - Automação de workflows
- ✅ **Grafana MCP** - Monitoramento
- ✅ **GitHub MCP** - Controle de versão

### Serviços Docker
- **Jupyter Lab** - Ambiente de desenvolvimento
- **MLflow** - Experiment tracking
- **Grafana** - Dashboards de monitoramento
- **PostgreSQL** - Banco de dados
- **Redis** - Cache e filas
- **Nginx** - Reverse proxy

## 🚀 Funcionalidades Principais

1. **Auto-ML Pipeline** - Treinamento automático de modelos
2. **Model Deployment** - Deploy em containers Docker
3. **Data Processing** - ETL automatizado com n8n
4. **Monitoring** - Métricas em tempo real
5. **API Gateway** - Endpoints REST para modelos

## 📊 Fluxos de Trabalho n8n

### 1. Data Ingestion Pipeline
- Coleta de dados de múltiplas fontes
- Validação e limpeza automática
- Armazenamento estruturado

### 2. Model Training Workflow
- Preparação de datasets
- Treinamento automático
- Avaliação de performance
- Registro de modelos

### 3. Deployment Pipeline
- Build de imagem Docker
- Testes automatizados
- Deploy para produção
- Monitoramento contínuo

---
*Plataforma ML-MCP Gerenciada por Claude AI*