#!/bin/bash
# 🚀 Setup Script - Claude Code CLI Ecossystem

echo "🧠 Configurando Ecossistema Claude Code CLI..."

# Criar estrutura de diretórios
mkdir -p {docs,scripts,configs,backup,logs,agents,tests,projects}

# Verificar instalação Claude CLI
if ! command -v claude &> /dev/null; then
    echo "❌ Claude CLI não encontrado. Por favor, instale primeiro."
    exit 1
fi

echo "✅ Claude CLI encontrado: $(claude --version)"

# Verificar configuração MCP
if [ -f "$HOME/.claude/mcp.json" ]; then
    echo "✅ Configuração MCP encontrada"
else
    echo "⚠️  Configuração MCP não encontrada"
fi

# Verificar arquivos de memória
if [ -f "memory/guia-claude-code-cli.md" ]; then
    echo "✅ Arquivos de memória encontrados"
else
    echo "⚠️  Arquivos de memória não encontrados"
fi

# Criar logs
echo "$(date): Setup executado" >> logs/setup.log

echo "🎉 Setup concluído com sucesso!"
