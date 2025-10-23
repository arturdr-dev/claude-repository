# 🧠 Diretório de Memórias Inteligentes

**Propósito:** Armazenar documentação, guias e referências para contexto automático do Claude Code CLI

---

## 📁 Estrutura de Arquivos

### 🎯 Memórias Principais (Carregadas Automaticamente)

| Arquivo | Tipo | Prioridade | Descrição |
|---------|------|------------|-----------|
| `guia-claude-code-cli.md` | Documentação | Alta | Guia completo do Claude Code CLI com links oficiais |

### 📋 Metadados do Sistema

- **Formato:** Markdown estruturado com metadados
- **Carregamento:** Via import no CLAUDE.md principal
- **Contexto:** Persistente durante sessões do Claude Code CLI
- **Atualização:** Dinâmica conforme evolução do ecossistema

---

## 🚀 Como Adicionar Novas Memórias

1. **Crie o arquivo** em `/memory/nome-do-arquivo.memory`
2. **Adicione metadados** no topo do arquivo:
   ```markdown
   **Tipo:** [Documentação/Checklist/Referência]
   **Prioridade:** [Alta/Média/Baixa]
   **Contexto:** [Descrição breve]
   ```
3. **Importe no CLAUDE.md:**
   ```memory
   import "./memory/nome-do-arquivo.memory"
   ```
4. **Atualize a tabela** de memórias no CLAUDE.md

---

## 📚 Categorias Sugeridas

- **🎯 Guias:** Documentação completa e tutoriais
- **✅ Checklists:** Listas de verificação para processos
- **🔧 Referências:** Comandos, configurações, padrões
- **📊 Padrões:** Melhores práticas e convenções
- **🔄 Workflows:** Fluxos de trabalho e automações

---

## ⚡ Comandos de Memória

- `/memory list` - Listar todas as memórias disponíveis
- `/memory retrieve <nome>` - Consultar memória específica
- `/memory search <termo>` - Buscar em todas as memórias

---

*Este diretório serve como base de conhecimento inteligente para o ecossistema Claude Code CLI.*