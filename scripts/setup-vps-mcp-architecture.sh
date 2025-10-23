#!/bin/bash
# 🚀 VPS MCP Architecture Setup Script
# Script para configurar MCPs em VPS Oracle e apontar Claude CLI local

echo "🚀 VPS MCP ARCHITECTURE SETUP"
echo "============================="
echo ""

# Cores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

log_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

log_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

log_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

log_header() {
    echo -e "${CYAN}🔧 $1${NC}"
}

# Configurações
VPS_IP="YOUR_VPS_IP_HERE"
VPS_USER="ubuntu"
VPS_SSH_KEY="$HOME/.ssh/id_rsa_oracle"
MCPDOG_PORT="38881"
CLAUDE_PROJECT_DIR="/home/arturdr/Claude"

case "${1:-help}" in
    "plan")
        log_header "PLANO DE IMPLEMENTAÇÃO - VPS MCP ARCHITECTURE"
        echo ""

        echo "📋 **FASE 1: Preparação da VPS Oracle**"
        echo "   1. Criar conta Oracle Cloud (Free Tier)"
        echo "   2. Provisionar VPS (VM.Standard.A1.Flex - 4 OCPU, 24GB RAM)"
        echo "   3. Configurar rede (ports 22, 38881, 8080 abertos)"
        echo "   4. Configurar domínio/apontamento DNS (opcional)"
        echo "   5. Setup segurança básica (SSH keys, firewall)"
        echo ""

        echo "📋 **FASE 2: Instalação MCPDog na VPS**"
        echo "   1. Instalar Node.js 18+, Python 3.10+"
        echo "   2. Clonar MCPDog e configurar todos os 18 MCPs"
        echo "   3. Configurar daemon para rodar 24/7"
        echo "   4. Expor MCPs via HTTP transport"
        echo "   5. Configurar nginx/reverse proxy (opcional)"
        echo ""

        echo "📋 **FASE 3: Configuração Local**"
        echo "   1. Remover MCPs locais do Claude CLI"
        echo "   2. Configurar Claude CLI para apontar para VPS"
        echo "   3. Testar conexão e latência"
        echo "   4. Otimizar cache local"
        echo "   5. Documentar configuração"
        echo ""

        echo "📋 **FASE 4: Testes e Validação**"
        echo "   1. Testar cada MCP remotamente"
        echo "   2. Medir latência e performance"
        echo "   3. Testar fallback em caso de falha"
        echo "   4. Validar segurança e acesso"
        echo "   5. Documentar troubleshooting"
        echo ""

        echo "🎯 **Benefícios Esperados:**"
        echo "   ⚡ Claude CLI local super leve (< 100MB RAM)"
        echo "   🌐 Acesso a 200+ ferramentas via VPS"
        echo "   💰 Economia de recursos locais"
        echo "   🔧 Manutenção centralizada"
        echo "   📊 Monitoramento unificado"
        echo ""

        echo "📊 **Recursos Necessários na VPS:**"
        echo "   💾 CPU: 2-4 OCPU"
        echo "   🧠 RAM: 8-24GB"
        echo "   💾 Storage: 50GB+ SSD"
        echo "   🌐 Network: 1Gbps (Oracle Free Tier)"
        echo ""

        echo "⏱️  **Tempo Estimado:** 2-4 horas para setup completo"
        ;;

    "vps-setup")
        log_header "CONFIGURANDO VPS ORACLE PARA MCPs"
        echo ""

        if [ -z "$VPS_IP" ] || [ "$VPS_IP" = "YOUR_VPS_IP_HERE" ]; then
            log_warning "Configure VPS_IP no script antes de executar"
            echo "Edite a variável VPS_IP='seu-ip-da-vps'"
            exit 1
        fi

        log_info "Conectando à VPS Oracle..."
        ssh -i "$VPS_SSH_KEY" "$VPS_USER@$VPS_IP" << 'EOF'
echo "🔧 Configurando VPS Oracle para MCPs..."

# Atualizar sistema
sudo apt update && sudo apt upgrade -y

# Instalar dependências
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs python3.10 python3.10-venv git

# Instalar MCPDog
cd /opt
sudo git clone https://github.com/your-mcpdog-repo.git mcpdog
sudo chown -R ubuntu:ubuntu mcpdog
cd mcpdog

# Instalar dependências
npm install
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Configurar MCPDog com todos os MCPs
cp config/mcpdog.config.json.example config/mcpdog.config.json

# Configurar daemon para rodar 24/7
sudo cp scripts/mcpdog.service /etc/systemd/system/
sudo systemctl enable mcpdog
sudo systemctl start mcpdog

# Configurar firewall
sudo ufw allow 22
sudo ufw allow 38881
sudo ufw allow 8080
sudo ufw --force enable

echo "✅ VPS configurada com MCPDog!"
EOF

        log_success "Configuração da VPS concluída!"
        ;;

    "local-setup")
        log_header "CONFIGURANDO CLAUDE CLI LOCAL PARA VPS"
        echo ""

        if [ -z "$VPS_IP" ] || [ "$VPS_IP" = "YOUR_VPS_IP_HERE" ]; then
            log_warning "Configure VPS_IP no script antes de executar"
            exit 1
        fi

        cd "$CLAUDE_PROJECT_DIR"

        # Remover MCPs locais atuais
        log_info "Removendo MCPs locais..."
        claude mcp remove filesystem 2>/dev/null || true
        claude mcp remove sequential-thinking 2>/dev/null || true

        # Configurar MCPs remotos
        log_info "Configurando MCPs remotos da VPS..."

        # Filesystem remoto (apontando para projeto local)
        claude mcp add --transport http remote-filesystem "http://$VPS_IP:$MCPDOG_PORT/filesystem" || {
            log_warning "Falha ao adicionar filesystem remoto, tentando método alternativo..."
            claude mcp add --transport stdio remote-filesystem npx @modelcontextprotocol/server-filesystem "$CLAUDE_PROJECT_DIR"
        }

        # Sequential thinking remoto
        claude mcp add --transport http remote-sequential-thinking "http://$VPS_IP:$MCPDOG_PORT/sequential-thinking" || {
            log_warning "Falha ao adicionar sequential-thinking remoto, tentando método alternativo..."
            claude mcp add --transport stdio remote-sequential-thinking npx @modelcontextprotocol/server-sequential-thinking
        }

        # Adicionar MCPs essenciais da VPS
        claude mcp add --transport http remote-tavily "http://$VPS_IP:$MCPDOG_PORT/tavily" || true
        claude mcp add --transport http remote-openrouter "http://$VPS_IP:$MCPDOG_PORT/openrouter" || true
        claude mcp add --transport http remote-github "http://$VPS_IP:$MCPDOG_PORT/github-mcp-server" || true

        log_success "MCPs remotos configurados!"

        # Criar script de verificação
        cat > "$CLAUDE_PROJECT_DIR/scripts/check-vps-mcp.sh" << EOF
#!/bin/bash
echo "🔍 Verificando conexão com MCPs na VPS..."
echo "VPS: $VPS_IP:$MCPDOG_PORT"
echo ""

# Testar conectividade
curl -f "http://$VPS_IP:$MCPDOG_PORT/health" 2>/dev/null && echo "✅ VPS MCPDog online" || echo "❌ VPS MCPDog offline"

# Verificar MCPs locais
echo ""
echo "📋 MCPs configurados localmente:"
claude mcp list

echo ""
echo "🌐 Dashboard VPS: http://$VPS_IP:$MCPDOG_PORT"
EOF

        chmod +x "$CLAUDE_PROJECT_DIR/scripts/check-vps-mcp.sh"

        log_success "Configuração local concluída!"
        echo "   Execute './scripts/check-vps-mcp.sh' para verificar"
        ;;

    "test")
        log_header "TESTANDO ARQUITETURA VPS MCP"
        echo ""

        cd "$CLAUDE_PROJECT_DIR"

        log_info "1. Testando conectividade com VPS..."
        if [ -n "$VPS_IP" ] && [ "$VPS_IP" != "YOUR_VPS_IP_HERE" ]; then
            timeout 5 curl -f "http://$VPS_IP:$MCPDOG_PORT/health" 2>/dev/null && \
                log_success "VPS MCPDog online" || \
                log_warning "VPS MCPDog offline ou inacessível"
        else
            log_warning "Configure VPS_IP para testar conectividade"
        fi

        log_info "2. Verificando MCPs configurados..."
        claude mcp list

        log_info "3. Testando funcionalidade básica..."
        claude "List the contents of current directory using filesystem MCP" 2>/dev/null && \
            log_success "Filesystem MCP funcionando" || \
            log_warning "Filesystem MCP com problemas"

        echo ""
        log_success "Testes concluídos!"
        ;;

    "docs")
        log_header "DOCUMENTAÇÃO - ARQUITETURA VPS MCP"
        echo ""

        cat << 'EOF'
📚 Arquitetura VPS MCP - Documentação Completa
==================================================

Visão Geral:
- VPS Oracle: Servidor central com todos os MCPs
- Local: Claude CLI apontando para serviços remotos
- Benefícios: Performance local + poder centralizado

Comandos Úteis:
./setup-vps-mcp-architecture.sh plan    - Ver plano completo
./setup-vps-mcp-architecture.sh vps-setup - Configurar VPS
./setup-vps-mcp-architecture.sh local-setup - Configurar local
./setup-vps-mcp-architecture.sh test    - Testar conexão
./setup-vps-mcp-architecture.sh docs    - Esta documentação

Troubleshooting:
1. Verificar se VPS está acessível: ping VPS_IP
2. Verificar se MCPDog está rodando: ssh VPS "systemctl status mcpdog"
3. Verificar ports abertos: telnet VPS_IP 38881
4. Testar MCP individualmente: claude mcp list

Segurança:
- Usar SSH keys para acesso à VPS
- Configurar firewall adequadamente
- Considerar VPN para acesso adicional
- Rotacionar chaves de API regularmente
EOF
        ;;

    "help"|"-h"|"--help")
        echo "🚀 VPS MCP Architecture Setup"
        echo ""
        echo "Comandos disponíveis:"
        echo "  plan         - Ver plano de implementação completo"
        echo "  vps-setup    - Configurar VPS Oracle com MCPDog"
        echo "  local-setup  - Configurar Claude CLI local para VPS"
        echo "  test         - Testar arquitetura e conectividade"
        echo "  docs         - Mostrar documentação completa"
        echo "  help         - Mostrar esta ajuda"
        echo ""
        echo "Uso:"
        echo "  ./setup-vps-mcp-architecture.sh plan"
        echo ""
        echo "Pré-requisitos:"
        echo "  - Conta Oracle Cloud (Free Tier)"
        echo "  - SSH key configurada para VPS"
        echo "  - Editar variável VPS_IP no script"
        ;;

    *)
        log_warning "Comando desconhecido: $1"
        ./setup-vps-mcp-architecture.sh help
        exit 1
        ;;
esac

echo ""
log_success "Operação concluída! ✨"