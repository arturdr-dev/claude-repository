#!/bin/bash
# 🚀 MCP Daemon Activation Script
# Ativa o MCP Dog quando Claude Code CLI inicia

echo "🚀 Ativando MCP Dog Daemon para Claude Code CLI..."

# Verificar se MCP Dog daemon está rodando
if ! pgrep -f "mcpdog.*daemon" > /dev/null; then
    echo "📥 Iniciando MCP Dog Daemon..."
    cd /home/arturdr/.config/mcpdog

    # Iniciar daemon em background
    nohup mcpdog start --config mcpdog.config.json > /dev/null 2>&1 &

    # Esperar inicialização
    sleep 3

    # Verificar se iniciou corretamente
    if pgrep -f "mcpdog.*daemon" > /dev/null; then
        echo "✅ MCP Dog Daemon iniciado com sucesso!"
    else
        echo "❌ Falha ao iniciar MCP Dog Daemon"
        exit 1
    fi
else
    echo "✅ MCP Dog Daemon já está rodando"
fi

# Exibir status
echo ""
echo "📊 Status do Ecossistema MCP:"
mcpdog status 2>/dev/null || echo "⚠️  Status não disponível"

echo ""
echo "🌐 Dashboard MCPDog disponível em: http://localhost:38881"
echo "🔧 Use 'mcpdog web' para abrir interface web"
