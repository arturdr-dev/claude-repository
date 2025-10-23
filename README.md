# 🧠 Ecossistema Claude Code CLI

**Estrutura profissional para automação, documentação e desenvolvimento com IA**

[![Claude Code Version](https://img.shields.io/badge/Claude%20Code-2.0.25-blue.svg)](https://docs.claude.com/en/docs/claude-code/overview)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## 📋 Visão Geral

Este projeto implementa uma estrutura profissional e escalável para o ecossistema Claude Code CLI, seguindo as melhores práticas de governança, automação e documentação. Ideal para equipes que precisam de contexto persistente, automação inteligente e modularidade em seus projetos de IA.

## 🏗️ Estrutura do Projeto

```
Claude/
├── 📄 CLAUDE.md                 # Contexto principal para o Claude Code CLI
├── 📖 README.md                 # Documentação para humanos (este arquivo)
├── 🧠 memory/                   # Memórias inteligentes para automação
│   ├── 📚 guia-claude-code-cli.md
│   ├── ✅ checklist.memory
│   ├── ⌨️ comandos.memory
│   ├── 🏗️ estrutura-projeto.memory
│   ├── 🔧 automacao-memory.memory
│   └── 📖 README.md
├── 📚 docs/                     # Documentação técnica detalhada
│   └── 🏗️ arquitetura.md
├── 🔧 scripts/                  # Scripts de automação e configuração
│   ├── ⚙️ setup.sh
│   └── 💾 backup.sh
├── ⚙️ configs/                  # Configurações de ambiente
│   ├── 🔧 dev.env
│   └── 🚀 prod.env
├── 💾 backup/                   # Backups automáticos do sistema
├── 📝 logs/                     # Logs de execução e auditoria
├── 🤖 agents/                   # Subagentes personalizados
│   ├── 🔐 security-agent.json
│   └── ⚡ performance-agent.json
├── 🧪 tests/                    # Scripts de validação automatizada
│   └── 🧪 test_memory.sh
└── 📁 projects/                 # Projetos modulares independentes
    ├── 📄 projeto-a/
    │   └── 📄 CLAUDE.md
    └── 🔍 projeto-b/
        └── 📄 CLAUDE.md
```

## 🚀 Instalação e Setup

### Pré-requisitos

- [Claude Code CLI](https://docs.claude.com/en/docs/claude-code/quickstart) 2.0+
- Bash/Zsh
- Node.js (para MCP servers)
- Python 3.8+ (opcional, para alguns MCPs)

### Instalação Rápida

1. **Clone ou copie este projeto:**
   ```bash
   git clone <repository-url> Claude
   cd Claude
   ```

2. **Execute o script de setup:**
   ```bash
   ./scripts/setup.sh
   ```

3. **Verifique a instalação:**
   ```bash
   claude --version
   ./tests/test_memory.sh
   ```

4. **Comece a usar:**
   ```bash
   claude
   ```

## 💡 Como Usar

### Para Desenvolvedores Humanos

- **Leia este README** para entender a estrutura
- **Use os scripts** em `scripts/` para automação
- **Consulte `docs/`** para documentação técnica
- **Trabalhe em `projects/`** para projetos específicos

### Para Claude Code CLI

- **Contexto automático** via `CLAUDE.md` e imports de memória
- **Comandos inteligentes** via memórias especializadas
- **Automação** via scripts e agentes configurados

### Comandos Essenciais

```bash
# Iniciar sessão com contexto completo
claude

# Trabalhar em projeto específico
cd projects/projeto-a && claude

# Backup manual
./scripts/backup.sh

# Testar sistema
./tests/test_memory.sh

# Gerenciar memórias
/memory list
/memory retrieve estrutura-projeto
```

## 🎯 Recursos Principais

### 🧠 Memória Inteligente
- **Context Persistence** automático via imports
- **Memórias especializadas** por função (checklist, comandos, estrutura)
- **Modularidade** com referências cruzadas

### 🔧 Automação
- **Setup automatizado** com validações
- **Backup programável** com snapshots
- **Testes automáticos** para integridade

### 🤖 Agentes Personalizados
- **Security Agent** para auditoria de segurança
- **Performance Agent** para otimização
- **Extensível** para novas especializações

### 📁 Projetos Modulares
- **Contexto isolado** por projeto
- **Herança de configurações** globais
- **Independência** entre projetos

## 🔧 Integrações

- ✅ **MCP Servers:** 14 servidores configurados
- ✅ **GitHub:** Automação de workflows
- ✅ **Notion:** Integração com documentação
- ✅ **Tavily:** Busca inteligente
- ✅ **Filesystem:** Acesso completo ao sistema

## 📊 Status do Projeto

| Componente | Status | Versão |
|------------|--------|---------|
| Claude Code CLI | ✅ Ativo | 2.0.25 |
| Memórias | ✅ 5 arquivos | v1.0 |
| Scripts | ✅ 2 scripts | v1.0 |
| Agentes | ✅ 2 agentes | v1.0 |
| Testes | ✅ Automatizados | v1.0 |

## 🤝 Contribuição

1. **Fork** o projeto
2. **Crie** uma feature branch: `git checkout -b feature/nova-funcionalidade`
3. **Commit** suas mudanças: `git commit -m 'Add nova funcionalidade'`
4. **Push** para o branch: `git push origin feature/nova-funcionalidade`
5. **Abra** um Pull Request

## 📄 Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.

## 🔗 Links Úteis

- [Documentação Oficial Claude Code](https://docs.claude.com/en/docs/claude-code/overview)
- [Model Context Protocol](https://modelcontextprotocol.io/)
- [Guia de Memórias](memory/README.md)
- [Documentação Técnica](docs/arquitetura.md)

## 🚀 Awesome Claude Code Resources

**Referência essencial:** [awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code)

### O que oferece:
- 🎯 **Agent Skills** - Configurações especializadas para tarefas específicas
- 🔄 **Workflows** - AB Method, RIPER Workflow, Context Priming
- 🛠️ **Tooling** - cc-tools, claudekit, ContextKit e mais
- ⚡ **Slash Commands** - Comandos organizados por categoria
- 📋 **CLAUDE.md Templates** - Configurações por linguagem e domínio

### Destaques:
- **20+ subagents** prontos para uso
- **Workflows estruturados** para grandes projetos
- **Ferramentas CLI** para produtividade
- **Integração com CI/CD** e pipelines

## 📚 Recursos Adicionais

### 🎯 Templates e Frameworks
- **[Claude Code Templates](https://github.com/davila7/claude-code-templates)** - Configurações prontas e agentes
- **[SuperClaude Framework](https://github.com/SuperClaude-Org/SuperClaude_Framework)** - Framework avançado (26 commands, 16 agents)
- **[My Claude Code Setup](https://github.com/centminmod/my-claude-code-setup)** - Configuração inicial compartilhada

### 📋 Links Úteis Organizados
- Templates JSON prontos para adaptação
- Agentes especializados configurados
- Exemplos de projetos reais
- Documentação oficial e guias

*Todos estes recursos estão disponíveis como memória inteligente no projeto para acesso via Claude Code CLI.*

---

**Estrutura profissional, escalável e pronta para produção!** 🚀

*Para começar: `cd Claude && claude`*
