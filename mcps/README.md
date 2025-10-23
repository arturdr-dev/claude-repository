# 📡 MCP Servers - Model Context Protocol

**Diretório:** `/mcps/`
**Contexto:** Servidores MCP oficiais e customizados para Claude Code CLI

---

## 🎯 Estrutura Oficial MCP

Conforme documentação oficial do Claude Code CLI, os MCP servers devem ser configurados usando:

```bash
# Adicionar servidor HTTP
claude mcp add --transport http <nome> <url>

# Adicionar servidor stdio local
claude mcp add --transport stdio <nome> <comando> [args...]

# Listar servidores configurados
claude mcp list

# Remover servidor
claude mcp remove <nome>
```

## 📁 Diretórios

### `/mcps/official/`
Servidores MCP oficiais e exemplos prontos para uso

### `/mcps/servers/`
Implementações customizadas e servidores específicos do projeto

### `/mcps/configs/`
Configurações e ambiente para cada MCP server

---

## 🚀 Como Usar

1. **Verificar MCPs disponíveis:**
   ```bash
   ls mcps/servers/
   ```

2. **Adicionar MCP ao Claude Code:**
   ```bash
   cd mcps/servers/nome-do-servidor/
   claude mcp add --transport stdio server-name python server.py
   ```

3. **Listar MCPs ativos:**
   ```bash
   claude mcp list
   ```

---

*Todos os MCPs são configurados seguindo as diretrizes oficiais do Claude Code CLI*