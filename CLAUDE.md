# 🧠 Claude Code CLI - Contexto Inteligente do Projeto

**Projeto:** Ecossistema Claude Code CLI
**Versão:** 1.0
**Última atualização:** 2025-10-22

---

## 📚 Memórias Inteligentes do Projeto

### 🎯 Estrutura Otimizada para Economia de Tokens

**Contextos Essenciais (Carregamento Automático):**
```memory
import "./init/core-context.memory"
import "./init/estrutura-basica.memory"
import "./init/comandos-essenciais.memory"
import "./init/checklist-diaria.memory"
```

**Memórias Segmentadas (Sob Demanda):**
Use `/memory retrieve <categoria>/<arquivo>` para acesso específico

### 📁 Estrutura de Memórias

#### 🚀 Contextos Essenciais (`/init/`)
- **`core-context.memory`** - Contexto principal do projeto (~3KB)
- **`estrutura-basica.memory`** - Estrutura básica e navegação (~2KB)
- **`comandos-essenciais.memory`** - Comandos CLI essenciais (~2KB)
- **`checklist-diaria.memory`** - Checklist diária de verificação (~2KB)

#### 📚 Memórias Segmentadas (`/memory/`)
- **`essencial/`** - Documentação oficial e automações (~14KB)
- **`referencias/`** - Recursos externos e links (~11KB)
- **`especializados/`** - Conteúdo técnico específico (~6KB)
- **`archive/`** - Arquivos antigos arquivados

### 🎮 Como Usar

#### **Acesso Automático (Essencial):**
Contextos em `/init/` são carregados automaticamente em cada sessão.

#### **Acesso Sob Demanda:**
```bash
# Documentação oficial
/memory retrieve essencial/guia-oficial

# Recursos awesome
/memory retrieve referencias/awesome-claude

# Estrutura detalhada
/memory retrieve especializados/estrutura-detalhada

# Listar todas as memórias
/memory list
```

### 💡 Benefícios da Estrutura

- **⚡ Economia de Tokens:** Apenas ~9KB carregados automaticamente
- **🎯 Contexto Relevante:** Essenciais sempre disponíveis
- **📚 Acesso Sob Demanda:** Conteúdo específico quando necessário
- **🔄 Manutenção Simplificada:** Organização por categoria
- **📊 Monitoramento Facilitado:** Uso otimizado de tokens

---

## 🤖 Agents e Sub-Agents

### 📁 Agents (Configurações Principais)
- **`agents/`** - Configurações de agentes principais do ecossistema
  - `security-agent.json` - Agente de segurança e auditoria
  - `performance-agent.json` - Agente de performance e otimização

### 🔧 Sub-Agents (Especializações)
- **`sub-agents/`** - Sub-agentes especializados para tarefas específicas
  - `ml-analyst/` - Análise de modelos de machine learning
  - `data-scientist/` - Análise de dados e ciência de dados
  - `code-reviewer/` - Revisão de código e boas práticas
  - `automation-expert/` - Especialista em automação

---

## 📡 MCP Servers (Model Context Protocol)

### 🗂️ Estrutura MCP
- **`mcps/`** - Servidores MCP customizados e especializados
  - `ml-workflow/` - Orquestração de workflows de ML
  - `data-science/` - Ferramentas para análise de dados
  - `monitoring/` - Monitoramento e métricas
  - `github-integration/` - Integração com GitHub

### Como Usar MCP Servers
```bash
# Adicionar server MCP
claude mcp add --transport stdio ml-workflow python3 ./mcps/ml-workflow/server.py

# Listar servers configurados
claude mcp list

# Usar em projeto específico
cd projects/ml-mcp-platform
claude "Use o ML workflow server para analisar os dados"
```

---

## 🎯 Diretrizes para o Agente Claude

### Contexto Prioritário
1. **Use sempre o guia integrado** (`/memory/guia-claude-code-cli.md`) como fonte primária de documentação
2. **Consulte os links oficiais** para obter informações detalhadas e exemplos práticos
3. **Priorize seções** conforme o tipo de tarefa (Setup, Build, Deploy, Admin, Config)

### Automação Inteligente
- Sugira comandos e fluxos baseados na documentação
- Use o contexto para identificar as melhores práticas
- Forneça exemplos práticos com links para aprofundamento

### Integração com Ecossistema
- O sistema deve reconhecer automaticamente as memórias carregadas
- Use as referências para enriquecer respostas e recomendações
- Mantenha consistência com a documentação oficial

---

## 🔧 Comandos Rápidos de Memória

Durante sessões, use:
- `/memory retrieve guia-claude-code-cli` - Consultar guia completo
- `/memory list` - Listar todas as memórias disponíveis

---

## 📋 Metadados do Projeto

- **Tipo:** Ecossistema Claude Code CLI
- **Escopo:** Documentação, Automação, Integração
- **Contexto:** Multi-projeto com foco em MCP e automações
- **Atualização:** Dinâmica conforme evolução do ecossistema

---

*Este arquivo serve como hub central de contexto. Todas as memórias importadas são automaticamente carregadas e disponibilizadas para o Claude Code CLI durante as sessões interativas.*