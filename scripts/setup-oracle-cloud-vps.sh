#!/bin/bash
# ☁️ Oracle Cloud Free Tier Setup Script
# Guia completo para configurar VPS Oracle com MCPDog

echo "☁️ ORACLE CLOUD FREE TIER - SETUP COMPLETO"
echo "========================================"
echo ""

# Cores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RED='\033[0;31m'
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

log_error() {
    echo -e "${RED}❌ $1${NC}"
}

log_header() {
    echo -e "${CYAN}🔧 $1${NC}"
}

case "${1:-help}" in
    "guide")
        log_header "GUIA COMPLETO - ORACLE CLOUD FREE Tier"
        echo ""

        echo "📋 **PASSO 1: CRIAR CONTA ORACLE CLOUD**"
        echo "   1. Acesse: https://www.oracle.com/cloud/free/"
        echo "   2. Clique em 'Try for Free'"
        echo "   3. Preencha formulário (use email real)";
        echo "   4. Adicione cartão de crédito (não será cobrado no free tier)"
        echo "   5. Aguarde aprovação (geralmente instantânea)"
        echo ""

        echo "📋 **PASSO 2: CRIAR VPS (VM Instance)**"
        echo "   1. Faça login no Oracle Cloud Console"
        echo "   2. Vá para: Compute → Instances → Create Instance"
        echo "   3. Configure:"
        echo "      • Name: mcpdog-server"
        echo "      • Compartment: Seu compartment (padrão funciona)"
        echo "      • Placement: Availability Domain (qualquer um)"
        echo "      • Image: Oracle Linux 8 (ou Ubuntu 22.04)"
        echo "      • Shape: VM.Standard.A1.Flex"
        echo "      • OCPU count: 4"
        echo "      • Memory (GB): 24"
        echo "      • Boot volume: 50 GB (padrão)"
        echo "      • SSH Keys: Adicione sua chave SSH pública"
        echo "      • VCN: Create new VCN (padrão)"
        echo "      • Subnet: Public subnet (para acesso SSH)"
        echo "   4. Clique em 'Create'"
        echo ""

        echo "📋 **PASSO 3: CONFIGURAR REDE E SEGURANÇA**"
        echo "   1. Após criar a VM, anote o IP Público (Public IP)"
        echo "   2. Vá para: Networking → Virtual Cloud Networks"
        echo "   3. Selecione sua VNC → Security Lists → Default Security List"
        echo "   4. Adicione regras de ingress:"
        echo "      • Porta 22 (SSH): 0.0.0.0/0"
        echo "      • Porta 38881 (MCPDog Web): 0.0.0.0/0"
        echo "      • Porta 8080 (HTTP API): 0.0.0.0/0"
        echo "      • Porta 443 (HTTPS): 0.0.0.0/0"
        echo ""

        echo "📋 **PASSO 4: ACESSAR VIA SSH**"
        echo "   1. Obtenha o IP Público da VM (Console → Compute → Instances)"
        echo "   2. Conecte via SSH:"
        echo "      ssh -i sua-chave-privada.pem opc@SEU_IP_PUBLICO"
        echo "   3. Se usar Ubuntu, usuário é 'ubuntu'"
        echo "   4. Se usar Oracle Linux, usuário é 'opc'"
        echo ""

        echo "📋 **PASSO 5: INSTALAR DEPENDÊNCIAS**"
        echo "   Execute os comandos abaixo na VPS via SSH:"
        echo ""
        echo "   # Atualizar sistema"
        echo "   sudo apt update && sudo apt upgrade -y  # Ubuntu"
        echo "   # sudo yum update -y                    # Oracle Linux"
        echo ""
        echo "   # Instalar Node.js 18+"
        echo "   curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -"
        echo "   sudo apt-get install -y nodejs"
        echo ""
        echo "   # Instalar Python 3.10+"
        echo "   sudo apt install -y python3.10 python3.10-venv python3.10-dev"
        echo "   sudo apt install -y build-essential"
        echo ""
        echo "   # Instalar Git"
        echo "   sudo apt install -y git"
        echo ""
        echo "   # Instalar Docker (opcional, para container MCPs)"
        echo "   curl -fsSL https://get.docker.com | sudo sh"
        echo "   sudo usermod -aG docker \$USER"
        echo ""

        echo "📋 **PASSO 6: INSTALAR MCPDOG**"
        echo "   # Clonar MCPDog"
        echo "   cd /opt"
        echo "   sudo git clone https://github.com/seu-repo-mcpdog.git mcpdog"
        echo "   sudo chown -R \$USER:\$USER mcpdog"
        echo "   cd mcpdog"
        echo ""
        echo "   # Instalar dependências Node.js"
        echo "   npm install"
        echo ""
        echo "   # Instalar dependências Python"
        echo "   python3 -m venv venv"
        echo "   source venv/bin/activate"
        echo "   pip install -r requirements.txt"
        echo ""

        echo "📋 **PASSO 7: CONFIGURAR MCPDOG**"
        echo "   # Copiar configuração"
        echo "   cp config/mcpdog.config.json.example config/mcpdog.config.json"
        echo ""
        echo "   # Editar configuração com suas API keys"
        echo "   nano config/mcpdog.config.json"
        echo ""
        echo "   # Configurar daemon systemd"
        echo "   sudo cp scripts/mcpdog.service /etc/systemd/system/"
        echo "   sudo systemctl daemon-reload"
        echo "   sudo systemctl enable mcpdog"
        echo "   sudo systemctl start mcpdog"
        echo ""

        echo "📋 **PASSO 8: COPIAR CONFIGURAÇÃO EXISTENTE**"
        echo "   # Da sua máquina local, copie a configuração atual:"
        echo "   scp ~/.config/mcpdog/mcpdog.config.json opc@SEU_IP_PUBLICO:/opt/mcpdog/config/"
        echo ""
        echo "   # Copie também os scripts e servidores:"
        echo "   scp -r ~/.config/mcpdog/scripts/ opc@SEU_IP_PUBLICO:/opt/mcpdog/"
        echo "   scp -r ~/.config/mcpdog/servers/ opc@SEU_IP_PUBLICO:/opt/mcpdog/"
        echo ""

        echo "📋 **PASSO 9: TESTAR FUNCIONAMENTO**"
        echo "   # Verificar status do MCPDog"
        echo "   mcpdog daemon status"
        echo ""
        echo "   # Verificar MCPs ativos"
        echo "   mcpdog list"
        echo ""
        echo "   # Iniciar dashboard web"
        echo "   mcpdog start --web-port 38881"
        echo ""
        echo "   # Acessar dashboard: http://SEU_IP_PUBLICO:38881"
        echo ""

        echo "🎯 **RECURSOS DO FREE TIER:**"
        echo "   • Compute: 4 OCPU, 24GB RAM (perpétuo)"
        echo "   • Storage: 200GB (block storage)"
        echo "   • Network: 10TB带宽 (bandwidth)"
        echo "   • Databases: 2 Autonomous Database (20GB cada)"
        echo "   • Load Balancer: 1"
        echo "   • Monitoring: Metrics, Alerts, Logging"
        echo ""

        echo "⚠️  **IMPORTANTES:**"
        echo "   • Não esqueça de configurar Security Lists (firewall)"
        echo "   • Mantenha backup da sua chave SSH"
        echo "   • Monitore uso de recursos para não exceder limits"
        echo "   • Configure backups automáticos"
        echo ""

        echo "✨ **Resultado Final:**"
        echo "   🚀 VPS Oracle com 150+ ferramentas MCP"
        echo "   💰 Custo: R$ 0,00 (Free Tier)"
        echo "   ⚡ Performance: 4 OCPU + 24GB RAM"
        echo "   🌐 Acesso global via HTTP"
        echo ""

        echo "📞 **Suporte:**"
        echo "   • Oracle Cloud: 24/7 support no free tier"
        echo "   • Documentação: https://docs.oracle.com/"
        echo "   • Community: Oracle forums e Stack Overflow"
        ;;

    "generate-ssh")
        log_header "GERANDO CHAVE SSH PARA ORACLE CLOUD"
        echo ""

        log_info "Criando nova chave SSH para acesso à VPS..."

        # Criar diretório .ssh se não existir
        mkdir -p ~/.ssh
        chmod 700 ~/.ssh

        # Gerar chave SSH
        ssh-keygen -t rsa -b 4096 -f ~/.ssh/oracle_cloud_key -N "" -C "oracle-cloud-mcpdog"

        log_success "Chave SSH gerada!"
        echo ""
        echo "📁 **Arquivos criados:**"
        echo "   🔑 Chave privada: ~/.ssh/oracle_cloud_key"
        echo "   📋 Chave pública: ~/.ssh/oracle_cloud_key.pub"
        echo ""
        echo "📋 **Conteúdo da chave pública (copie para Oracle Cloud):**"
        echo ""
        cat ~/.ssh/oracle_cloud_key.pub
        echo ""
        echo "📝 **Como usar:**"
        echo "   1. Copie a chave pública acima"
        echo "   2. No Oracle Cloud Console → Compute → Create Instance"
        echo "   3. Em 'SSH Keys', cole a chave pública"
        echo "   4. Para acessar a VM: ssh -i ~/.ssh/oracle_cloud_key opc@IP_PUBLICO"
        echo ""
        log_warning "Guarde sua chave privada em local seguro!"
        ;;

    "check-requirements")
        log_header "VERIFICANDO REQUISITOS LOCAIS"
        echo ""

        # Verificar se tem chave SSH
        if [ -f ~/.ssh/oracle_cloud_key ]; then
            log_success "Chave SSH Oracle encontrada"
        else
            log_warning "Chave SSH Oracle não encontrada"
            echo "   Execute: $0 generate-ssh"
        fi

        # Verificar se tem scp para copiar configuração
        if command -v scp >/dev/null 2>&1; then
            log_success "SCP disponível para transferência de arquivos"
        else
            log_warning "SCP não encontrado. Instale OpenSSH client"
        fi

        # Verificar configuração MCPDog local
        if [ -f ~/.config/mcpdog/mcpdog.config.json ]; then
            log_success "Configuração MCPDog local encontrada"
            MCP_COUNT=$(python3 -c "import json; print(len(json.load(open('/home/arturdr/.config/mcpdog/mcpdog.config.json')).get('servers', {})))" 2>/dev/null || echo "?")
            echo "   📊 MCPs configurados: $MCP_COUNT"
        else
            log_warning "Configuração MCPDog local não encontrada"
        fi

        echo ""
        log_info "Próximos passos:"
        echo "   1. $0 guide - Seguir guia completo"
        echo "   2. Criar conta Oracle Cloud"
        echo "   3. Provisionar VPS"
        echo "   4. Instalar MCPDog na VPS"
        echo "   5. Copiar configuração existente"
        ;;

    "copy-config-to-vps")
        log_header "COPIANDO CONFIGURAÇÃO MCPDOG PARA VPS"
        echo ""

        if [ -z "$2" ]; then
            log_error "Forneça o IP da VPS: $0 copy-config-to-vps SEU_IP_PUBLICO"
            exit 1
        fi

        VPS_IP="$2"
        SSH_KEY="~/.ssh/oracle_cloud_key"

        log_info "Copiando configuração para VPS: $VPS_IP"

        # Testar conexão
        if ssh -i "$SSH_KEY" -o ConnectTimeout=10 -o StrictHostKeyChecking=no opc@"$VPS_IP" "echo 'SSH connection OK'" 2>/dev/null; then
            log_success "Conexão SSH estabelecida"
        else
            log_error "Falha na conexão SSH com a VPS"
            echo "   Verifique:"
            echo "   • IP público está correto: $VPS_IP"
            echo "   • Security Lists permitem porta 22"
            echo "   • Chave SSH está correta"
            echo "   • VM está rodando"
            exit 1
        fi

        # Criar diretórios na VPS
        log_info "Criando estrutura de diretórios na VPS..."
        ssh -i "$SSH_KEY" opc@"$VPS_IP" "sudo mkdir -p /opt/mcpdog/{config,servers,scripts,logs} && sudo chown -R opc:opc /opt/mcpdog"

        # Copiar configuração
        log_info "Copiando arquivos de configuração..."
        scp -i "$SSH_KEY" ~/.config/mcpdog/mcpdog.config.json opc@"$VPS_IP":/opt/mcpdog/config/
        scp -i "$SSH_KEY" ~/.config/mcpdog/.npmrc opc@"$VPS_IP":/opt/mcpdog/ 2>/dev/null || true

        # Copiar scripts importantes
        if [ -d ~/.config/mcpdog/scripts ]; then
            scp -i "$SSH_KEY" -r ~/.config/mcpdog/scripts/ opc@"$VPS_IP":/opt/mcpdog/
        fi

        # Copiar servidores MCP
        if [ -d ~/.config/mcpdog/servers ]; then
            scp -i "$SSH_KEY" -r ~/.config/mcpdog/servers/ opc@"$VPS_IP":/opt/mcpdog/
        fi

        log_success "Configuração copiada para VPS!"
        echo ""
        log_info "Próximos passos na VPS:"
        echo "   1. SSH para VPS: ssh -i $SSH_KEY opc@$VPS_IP"
        echo "   2. cd /opt/mcpdog"
        echo "   3. npm install"
        echo "   4. python3 -m venv venv && source venv/bin/activate"
        echo "   5. pip install -r requirements.txt"
        echo "   6. mcpdog daemon start"
        ;;

    "test-vps")
        log_header "TESTANDO CONEXÃO COM VPS ORACLE"
        echo ""

        if [ -z "$2" ]; then
            log_error "Forneça o IP da VPS: $0 test-vps SEU_IP_PUBLICO"
            exit 1
        fi

        VPS_IP="$2"
        SSH_KEY="~/.ssh/oracle_cloud_key"

        log_info "Testando conectividade com VPS: $VPS_IP"

        # Testar ping
        if ping -c 3 "$VPS_IP" >/dev/null 2>&1; then
            log_success "VPS responde ao ping"
        else
            log_error "VPS não responde ao ping"
            exit 1
        fi

        # Testar porta SSH
        if nc -zv "$VPS_IP" 22 2>&1 | grep -q "succeeded"; then
            log_success "Porta SSH (22) está aberta"
        else
            log_error "Porta SSH (22) não está acessível"
            echo "   Verifique Security Lists no Oracle Cloud"
            exit 1
        fi

        # Testar conexão SSH
        if ssh -i "$SSH_KEY" -o ConnectTimeout=5 -o StrictHostKeyChecking=no opc@"$VPS_IP" "whoami && echo 'Uptime:' && uptime" 2>/dev/null; then
            log_success "Conexão SSH funcional"
        else
            log_error "Falha na conexão SSH"
            exit 1
        fi

        log_success "Todos os testes de conectividade passaram!"
        echo ""
        log_info "VPS está pronta para configuração do MCPDog"
        echo "   Execute: $0 copy-config-to-vps $VPS_IP"
        ;;

    "help"|"-h"|"--help")
        echo "☁️ Oracle Cloud Free Tier Setup"
        echo ""
        echo "Comandos disponíveis:"
        echo "  guide               - Guia completo passo a passo"
        echo "  generate-ssh        - Gerar chave SSH para Oracle Cloud"
        echo "  check-requirements  - Verificar requisitos locais"
        echo "  copy-config-to-vps IP - Copiar configuração MCPDog para VPS"
        echo "  test-vps IP         - Testar conectividade com VPS"
        echo "  help                - Mostrar esta ajuda"
        echo ""
        echo "Fluxo recomendado:"
        echo "  1. $0 generate-ssh        # Gerar chave SSH"
        echo "  2. $0 guide               # Seguir guia para criar VPS"
        echo "  3. $0 test-vps IP         # Testar conexão com VPS"
        echo "  4. $0 copy-config-to-vps IP # Copiar configuração"
        echo ""
        echo "Requisitos:"
        echo "  • Conta Oracle Cloud (Free Tier)"
        echo "  • Chave SSH configurada"
        echo "  • Configuração MCPDog local"
        ;;

    *)
        log_warning "Comando desconhecido: $1"
        $0 help
        exit 1
        ;;
esac

echo ""
log_success "Operação concluída! ✨"