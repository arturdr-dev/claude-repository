# 🤖 ML-MCP Platform - Machine Learning com Model Context Protocol

**Tipo:** Project Context
**Priority:** Alta
**Escopo:** Plataforma de Machine Learning integrada ao Claude Code CLI via MCP

## 🎯 Objetivo do Projeto

Implementar uma plataforma de Machine Learning completa seguindo as melhores práticas do Claude Code CLI e MCP (Model Context Protocol).

## 📚 Memórias Importadas

```memory
import "../../memory/guia-claude-code-cli.md"
import "../../memory/estrutura-projeto.memory"
import "../../memory/comandos.memory"
import "../../memory/automacao-memory.memory"
```

## 🏗️ Arquitetura MCP para ML

### Servers MCP Configurados:
- **filesystem**: Acesso a datasets e arquivos de modelo
- **postgres**: Consultas a bancos de dados de ML
- **github**: Controle de versão de modelos e datasets
- **grafana**: Monitoramento de experimentos
- **custom-ml**: Server personalizado para workflows ML

### Fluxos de Trabalho:

1. **Data Ingestion**: filesystem + postgres MCP
2. **Model Training**: Scripts Python + MCP orchestration  
3. **Experiment Tracking**: Grafana + postgres MCP
4. **Model Deployment**: GitHub + custom MCP

## 🎮 Comandos Disponíveis

- `/memory retrieve ml-workflows` - Fluxos de trabalho ML
- `/agent use data-scientist` - Agente especializado
- `/skill use data-analysis` - Análise de dados

## 🔧 MCP Servers Customizados

### ML Workflow Server
```bash
# Adicionar server MCP customizado
claude mcp add --transport stdio ml-workflow python3 /path/to/ml_mcp_server.py
```

### Data Science Tools
```bash
# Integrar ferramentas de data science
claude mcp add --transport stdio pandas-tools python3 pandas_mcp_server.py
```

## 📊 Estrutura de Dados

- `/data/` - Datasets e arquivos de dados
- `/models/` - Modelos treinados e checkpoints  
- `/experiments/` - Resultados e métricas
- `/notebooks/` - Jupyter notebooks
- `/scripts/` - Scripts de treinamento

## 🚀 Como Usar

1. **Análise de Dados**: Use filesystem MCP para acessar datasets
2. **Treinamento**: Scripts Python com orchestration MCP
3. **Monitoramento**: Grafana MCP para métricas em tempo real
4. **Versionamento**: GitHub MCP para controle de modelos

---
*Projeto integrado ao ecossistema Claude Code CLI*
