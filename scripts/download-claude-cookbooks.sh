#!/bin/bash
# 🍳 Download Claude Cookbooks - Anthropic Official Repository
# Script para baixar e organizar os Cookbooks oficiais

echo "🍳 BAIXANDO CLAUDE COOKBOOKS - ANTHROPIC OFFICIAL"
echo "================================================="
echo ""

# Cores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
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

# Diretórios
CLAUDE_DIR="/home/arturdr/Claude"
COOKBOOKS_DIR="$CLAUDE_DIR/resources/claude-cookbooks"

log_info "📁 Criando diretório para Cookbooks..."
mkdir -p "$COOKBOOKS_DIR"

log_info "📥 Baixando Claude Cookbooks (repositório oficial)..."
cd "$CLAUDE_DIR/resources"

# Verificar se já existe
if [ -d "claude-cookbooks" ]; then
    log_warning "Diretório claude-cookbooks já existe - atualizando..."
    cd claude-cookbooks
    git pull origin main
else
    log_info "Clonando repositório oficial..."
    git clone https://github.com/anthropics/claude-cookbooks.git
fi

log_success "Claude Cookbooks baixados com sucesso!"

echo ""
log_info "📊 Estrutura dos Cookbooks:"
if [ -d "claude-cookbooks" ]; then
    cd claude-cookbooks
    echo "📂 Principais diretórios:"
    find . -maxdepth 2 -type d | head -10
    echo ""
    echo "📋 Arquivos principais:"
    find . -name "*.py" -o -name "*.md" -o -name "*.ipynb" | head -10
fi

echo ""
log_info "📚 Categorias Principais dos Cookbooks:"
echo "   🍳 API Examples - Exemplos de uso da API Claude"
echo "   🧠 Multimodal - Processamento de imagens e áudio"
echo "   🔍 RAG - Retrieval-Augmented Generation"
echo "   🤖 Agents - Sub-agentes e orquestração"
echo "   📊 Data Analysis - Análise de dados com Claude"
echo "   🔗 Integrations - Pinecone, Voyage AI, etc."
echo "   ☁️ Cloud - Deploy em AWS e infraestrutura"

echo ""
log_success "🎉 CLAUDE COOKBOOKS CONFIGURADOS COM SUCESSO!"
echo ""
echo -e "${BLUE}📋 Como usar:${NC}"
echo "1. Explore exemplos: cd resources/claude-cookbooks"
echo "2. Copie snippets para seus projetos"
echo "3. Adapte código Python para suas necessidades"
echo "4. Use exemplos de integração com APIs externas"
echo ""
echo -e "${GREEN}📖 Recurso oficial essencial para desenvolvimento Claude API!${NC}"

# Criar atalho rápido
ln -sf "$CLAUDE_DIR/resources/claude-cookbooks" "$CLAUDE_DIR/cookbooks" 2>/dev/null

log_success "🔗 Atalho criado: /home/arturdr/Claude/cookbooks"