# 🏗️ Arquitetura do Ecossistema Claude Code CLI

## Visão Geral

Este ecossistema segue as melhores práticas do Claude Code CLI com foco em:
- **Context Persistence**: Memórias inteligentes carregadas automaticamente
- **Modularidade**: Estrutura composicional e scriptável
- **Governança**: Controle de versões e auditoria
- **Escalabilidade**: Suporte a múltiplos projetos e agentes

## Componentes Principais

### 1. Context Management
- `CLAUDE.md`: Hub central de contexto
- `memory/`: Memórias inteligentes especializadas
- Auto-carregamento via imports

### 2. MCP Integration
- Servidores MCP configurados em `~/.claude/mcp.json`
- 14 servidores ativos (metrics, filesystem, github, etc.)
- Gerenciamento via `mcp-daemon`

### 3. Subagents & Skills
- Configuração de agentes especializados
- Habilidades personalizadas para automação
- Integração nativa com CLI

### 4. Projects Structure
- Múltiplos projetos independentes
- Context isolado por projeto
- Compartilhamento de memórias globais

## Fluxo de Dados

```
User Input → Claude CLI → Context Loading (CLAUDE.md + Memory) → MCP Integration → Response
```

## Security & Governance

- Controle de permissões granular
- Auditoria de sessões
- Backup automático de configurações
- Isolamento de projetos
