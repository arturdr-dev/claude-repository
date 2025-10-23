#!/bin/bash
# 🔧 MCP Daemon Integration Setup Script
# Configura integração entre MCP Daemon e Claude Code CLI

echo "🔧 CONFIGURANDO INTEGRAÇÃO MCP DAEMON + CLAUDE CODE CLI"
echo "======================================================="
echo ""

# Cores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

# Funções de logging
log_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

log_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

log_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

log_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Diretórios
CLAUDE_DIR="/home/arturdr/Claude"
MCPDOG_CONFIG="/home/arturdr/.config/mcpdog/mcpdog.config.json"
CLAUDE_CONFIG="/home/arturdr/.claude.json"

log_info "🔍 Verificando configurações atuais..."

# Verificar se MCPDog está configurado
if [ -f "$MCPDOG_CONFIG" ]; then
    log_success "Configuração MCPDog encontrada"
    echo "📊 MCPs configurados no MCPDog:"
    jq -r '.servers | keys[]' "$MCPDOG_CONFIG" 2>/dev/null | head -10 | while read server; do
        echo "   • $server"
    done
else
    log_error "Configuração MCPDog não encontrada"
    exit 1
fi

# Verificar configuração Claude
if [ -f "$CLAUDE_CONFIG" ]; then
    log_success "Configuração Claude Code CLI encontrada"
else
    log_warning "Configuração Claude Code CLI não encontrada - criando..."
    echo '{}' > "$CLAUDE_CONFIG"
fi

log_info "🔧 Configurando integração MCP..."

# Criar script de ativação automática
cat > "$CLAUDE_DIR/scripts/activate-mcp-daemon.sh" << 'EOF'
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
EOF

chmod +x "$CLAUDE_DIR/scripts/activate-mcp-daemon.sh"

log_success "Script de ativação criado"

# Criar configuração de sincronização
cat > "$CLAUDE_DIR/mcps/mcp-sync-config.json" << 'EOF'
{
  "integration": {
    "mcp_daemon": {
      "config_file": "/home/arturdr/.config/mcpdog/mcpdog.config.json",
      "web_port": 38881,
      "auto_start": true
    },
    "claude_code": {
      "config_file": "/home/arturdr/.claude.json",
      "native_mcps": ["filesystem"]
    },
    "sync_settings": {
      "auto_sync": true,
      "fallback_to_external": true,
      "health_check_interval": 30
    }
  },
  "mcp_servers": {
    "essential": [
      "filesystem",
      "simple-ecosystem"
    ],
    "external_from_mcpdog": [
      "sequential-thinking",
      "tavily",
      "openrouter",
      "github-mcp-server",
      "playwright-microsoft",
      "mem0-mcp",
      "vectara-mcp",
      "perplexity-mcp"
    ]
  }
}
EOF

log_success "Configuração de sincronização criada"

# Criar script de verificação de saúde
cat > "$CLAUDE_DIR/scripts/mcp-health-check.sh" << 'EOF'
#!/bin/bash
# 🏥 MCP Health Check Script
# Verifica saúde do ecossistema MCP

echo "🏥 MCP ECOSYSTEM HEALTH CHECK"
echo "============================="
echo ""

# Verificar MCP Dog daemon
echo "📊 MCP Dog Daemon Status:"
if pgrep -f "mcpdog.*daemon" > /dev/null; then
    echo "✅ MCP Dog Daemon: RUNNING"
    mcpdog status 2>/dev/null | head -5
else
    echo "❌ MCP Dog Daemon: NOT RUNNING"
    echo "💡 Execute: $CLAUDE_DIR/scripts/activate-mcp-daemon.sh"
fi

echo ""
echo "📋 Claude Code CLI MCP Status:"
claude mcp list 2>/dev/null || echo "❌ Claude MCP check failed"

echo ""
echo "🌐 Port Check:"
if netstat -tuln 2>/dev/null | grep -q ":38881 "; then
    echo "✅ MCPDog Web Interface (38881): AVAILABLE"
else
    echo "❌ MCPDog Web Interface (38881): NOT AVAILABLE"
fi

echo ""
echo "🔗 Integration Status:"
if [ -f "/home/arturdr/.config/mcpdog/mcpdog.config.json" ] && [ -f "/home/arturdr/.claude.json" ]; then
    echo "✅ Configuration files: EXIST"
    echo "✅ Integration: READY"
else
    echo "❌ Configuration files: MISSING"
fi

echo ""
echo "📝 Quick Actions:"
echo "  • Start MCP ecosystem: $CLAUDE_DIR/scripts/activate-mcp-daemon.sh"
echo "  • Check MCP status: claude mcp list"
echo "  • Open MCPDog web: mcpdog web"
echo "  • Health check: $CLAUDE_DIR/scripts/mcp-health-check.sh"
EOF

chmod +x "$CLAUDE_DIR/scripts/mcp-health-check.sh"

log_success "Script de health check criado"

# Criar atalho no diretório principal
cat > "$CLAUDE_DIR/mcp-start" << 'EOF'
#!/bin/bash
# 🚀 Quick MCP Start
# Ativação rápida do ecossistema MCP

/home/arturdr/Claude/scripts/activate-mcp-daemon.sh
/home/arturdr/Claude/scripts/mcp-health-check.sh
EOF

chmod +x "$CLAUDE_DIR/mcp-start"

log_success "Atalho de ativação criado"

echo ""
log_success "🎉 INTEGRAÇÃO MCP CONFIGURADA COM SUCESSO!"
echo ""
echo -e "${BLUE}📋 Próximos Passos:${NC}"
echo "1. Ativar MCP ecosystem:"
echo "   ./mcp-start"
echo ""
echo "2. Verificar status:"
echo "   ./scripts/mcp-health-check.sh"
echo ""
echo "3. Abrir dashboard:"
echo "   mcpdog web"
echo ""
echo -e "${GREEN}✨ Ecossistema MCP pronto para uso com Claude Code CLI!${NC}"
EOF

chmod +x /home/arturdr/Claude/scripts/setup-mcp-integration.sh