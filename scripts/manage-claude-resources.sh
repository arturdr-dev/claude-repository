#!/bin/bash
# 🛠️ Claude Resources Manager - Script Completo de Gerenciamento
# Gerencia todos os repositórios, templates e recursos Claude Code

echo "🛠️ CLAUDE RESOURCES MANAGER"
echo "==========================="
echo ""

# Cores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
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

log_header() {
    echo -e "${CYAN}🔧 $1${NC}"
}

# Diretórios
CLAUDE_DIR="/home/arturdr/Claude"
RESOURCES_DIR="$CLAUDE_DIR/resources"
WORKSPACE_DIR="$CLAUDE_DIR/workspace"

case "${1:-status}" in
    "status")
        log_header "STATUS COMPLETO DOS RECURSOS CLAUDE CODE"
        echo ""

        echo "📂 Recursos Principais:"
        echo "   🍳 Cookbooks (Oficial): $RESOURCES_DIR/claude-cookbooks"
        echo "   📋 GitHub Repos: $RESOURCES_DIR/github-repos"
        echo "   💼 Workspace: $WORKSPACE_DIR"
        echo ""

        echo "🔗 Atalhos Disponíveis:"
        for link in official-claude-code awesome-claude-code claude-templates superclaude-framework claude-setup-example; do
            if [ -L "$CLAUDE_DIR/$link" ]; then
                target=$(readlink "$CLAUDE_DIR/$link")
                echo "   ✅ $link → $target"
            else
                echo "   ❌ $link → não encontrado"
            fi
        done
        echo ""

        echo "📁 Estrutura de Repositórios:"
        if [ -d "$RESOURCES_DIR/github-repos" ]; then
            cd "$RESOURCES_DIR/github-repos"
            for repo in */; do
                if [ -d "$repo" ]; then
                    cd "$repo"
                    status=$(git status --porcelain 2>/dev/null | wc -l)
                    if [ "$status" -eq 0 ]; then
                        echo "   ✅ ${repo%/} (limpo)"
                    else
                        echo "   ⚠️  ${repo%/} ($status arquivos modificados)"
                    fi
                    cd ..
                fi
            done
        fi
        ;;

    "update")
        log_header "ATUALIZANDO TODOS OS REPOSITÓRIOS"
        echo ""

        if [ -d "$RESOURCES_DIR/github-repos" ]; then
            cd "$RESOURCES_DIR/github-repos"
            for repo in */; do
                if [ -d "$repo" ]; then
                    log_info "Atualizando ${repo%/}..."
                    cd "$repo"
                    git pull origin main 2>/dev/null || git pull origin master 2>/dev/null || log_warning "Falha ao atualizar ${repo%/}"
                    cd ..
                fi
            done
        fi

        # Atualizar Cookbooks também
        if [ -d "$RESOURCES_DIR/claude-cookbooks" ]; then
            log_info "Atualizando Claude Cookbooks..."
            cd "$RESOURCES_DIR/claude-cookbooks"
            git pull origin main 2>/dev/null || log_warning "Falha ao atualizar Cookbooks"
        fi

        log_success "Todos os repositórios atualizados!"
        ;;

    "setup")
        log_header "CONFIGURAR AMBIENTE CLAUDE CODE"
        echo ""

        # Criar estrutura de workspace
        log_info "Criando estrutura de workspace..."
        mkdir -p "$WORKSPACE_DIR"/{projects,templates,examples,frameworks,scripts}

        # Copiar templates básicos
        if [ -d "$CLAUDE_DIR/claude-templates" ]; then
            log_info "Copiando templates para workspace..."
            cp -r "$CLAUDE_DIR/claude-templates/templates/"* "$WORKSPACE_DIR/templates/" 2>/dev/null || true
        fi

        # Copiar exemplos do setup
        if [ -d "$CLAUDE_DIR/claude-setup-example" ]; then
            log_info "Copiando exemplos de setup..."
            cp -r "$CLAUDE_DIR/claude-setup-example/examples/"* "$WORKSPACE_DIR/examples/" 2>/dev/null || true
        fi

        # Criar script de ativação rápida
        cat > "$CLAUDE_DIR/start-dev" << 'EOF'
#!/bin/bash
# 🚀 Quick Development Environment Start
echo "🚀 Iniciando ambiente Claude Code..."
echo ""
echo "📊 Status dos recursos:"
./scripts/manage-claude-resources.sh status
echo ""
echo "🎯 Ambiente pronto para desenvolvimento!"
echo "   • Use 'claude' para iniciar sessão"
echo "   • Explore templates em ./workspace/templates"
echo "   • Ver exemplos em ./workspace/examples"
echo "   • Consulte Cookbooks em ./cookbooks"
EOF
        chmod +x "$CLAUDE_DIR/start-dev"

        log_success "Ambiente configurado com sucesso!"
        echo "   • Execute './start-dev' para iniciar desenvolvimento"
        ;;

    "explore")
        log_header "EXPLORANDO RECURSOS CLAUDE CODE"
        echo ""

        echo "🍳 Claude Cookbooks (Oficial Anthropic):"
        if [ -d "$RESOURCES_DIR/claude-cookbooks" ]; then
            cd "$RESOURCES_DIR/claude-cookbooks"
            echo "   📁 Principais categorias:"
            ls -1 */ | head -8 | sed 's/^/      • /'
            echo "   📖 Exemplos de API, multimodal, RAG, agents..."
        fi
        echo ""

        echo "📋 Awesome Claude Code (Recursos Curados):"
        if [ -d "$CLAUDE_DIR/awesome-claude-code" ]; then
            cd "$CLAUDE_DIR/awesome-claude-code"
            echo "   📁 Principais seções:"
            ls -1 */ | head -8 | sed 's/^/      • /'
            echo "   📖 Commands, agents, workflows, ferramentas..."
        fi
        echo ""

        echo "🎨 Claude Templates (Configurações Prontas):"
        if [ -d "$CLAUDE_DIR/claude-templates" ]; then
            cd "$CLAUDE_DIR/claude-templates"
            echo "   📁 Templates disponíveis:"
            find . -name "*.json" -o -name "*.md" | head -8 | sed 's/^/      • /'
            echo "   📖 Configurações prontas para diferentes domínios..."
        fi
        echo ""

        echo "🚀 SuperClaude Framework (Avançado):"
        if [ -d "$CLAUDE_DIR/superclaude-framework" ]; then
            cd "$CLAUDE_DIR/superclaude-framework"
            echo "   📁 Componentes:"
            ls -1 */ | head -8 | sed 's/^/      • /'
            echo "   📖 26 commands, 16 agents, 8 MCP servers..."
        fi
        ;;

    "clean")
        log_header "LIMPANDO E OTIMIZANDO RECURSOS"
        echo ""

        # Limpar arquivos temporários
        log_info "Limpando arquivos temporários..."
        find "$CLAUDE_DIR" -name "*.pyc" -delete 2>/dev/null || true
        find "$CLAUDE_DIR" -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null || true

        # Verificar repositórios sujos
        log_info "Verificando status dos repositórios..."
        if [ -d "$RESOURCES_DIR/github-repos" ]; then
            cd "$RESOURCES_DIR/github-repos"
            for repo in */; do
                if [ -d "$repo" ]; then
                    cd "$repo"
                    if ! git diff --quiet || ! git diff --cached --quiet; then
                        log_warning "${repo%/} tem modificações não commitadas"
                    fi
                    cd ..
                fi
            done
        fi

        log_success "Limpeza concluída!"
        ;;

    "help"|"-h"|"--help")
        echo "🛠️  Claude Resources Manager - Uso:"
        echo ""
        echo "Comandos disponíveis:"
        echo "  status    - Mostrar status completo dos recursos"
        echo "  update    - Atualizar todos os repositórios Git"
        echo "  setup     - Configurar ambiente de desenvolvimento"
        echo "  explore   - Explorar recursos disponíveis"
        echo "  clean     - Limpar e otimizar recursos"
        echo "  help      - Mostrar esta ajuda"
        echo ""
        echo "Exemplos:"
        echo "  ./scripts/manage-claude-resources.sh status"
        echo "  ./scripts/manage-claude-resources.sh update"
        echo "  ./scripts/manage-claude-resources.sh setup"
        echo ""
        echo "Recursos gerenciados:"
        echo "  • Claude Cookbooks (Oficial Anthropic)"
        echo "  • awesome-claude-code (Recursos curados)"
        echo "  • claude-code-templates (Templates prontos)"
        echo "  • SuperClaude Framework (Framework avançado)"
        echo "  • my-claude-code-setup (Exemplos práticos)"
        ;;

    *)
        log_error "Comando desconhecido: $1"
        echo ""
        ./scripts/manage-claude-resources.sh help
        exit 1
        ;;
esac

echo ""
log_success "Operação concluída com sucesso! ✨"