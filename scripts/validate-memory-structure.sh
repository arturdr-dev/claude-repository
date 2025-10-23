#!/bin/bash
# 🧪 Memory Structure Validation Tool
# Script para validar estrutura otimizada e realizar limpeza automática

echo "🧪 VALIDAÇÃO DE ESTRUTURA DE MEMÓRIAS"
echo "======================================"
echo ""

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

SUCCESS=0
WARNINGS=0
ERRORS=0

# Função para logging
log_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

log_success() {
    echo -e "${GREEN}✅ $1${NC}"
    ((SUCCESS++))
}

log_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
    ((WARNINGS++))
}

log_error() {
    echo -e "${RED}❌ $1${NC}"
    ((ERRORS++))
}

log_info "🔍 Validando estrutura de memórias otimizada..."

# Verificar estrutura básica
log_info "📁 Verificando diretórios essenciais..."

# Verificar se /init existe
if [ -d "/home/arturdr/Claude/init" ]; then
    log_success "Diretório /init encontrado"
else
    log_error "Diretório /init não encontrado!"
fi

# Verificar se /memory existe
if [ -d "/home/arturdr/Claude/memory" ]; then
    log_success "Diretório /memory encontrado"
else
    log_error "Diretório /memory não encontrado!"
fi

# Verificar subdiretórios esperados
EXPECTED_DIRS=("essencial" "referencias" "especializados" "archive")
for dir in "${EXPECTED_DIRS[@]}"; do
    if [ -d "/home/arturdr/Claude/memory/$dir" ]; then
        log_success "Subdiretório memory/$dir encontrado"
    else
        log_warning "Subdiretório memory/$dir não encontrado - criando..."
        mkdir -p "/home/arturdr/Claude/memory/$dir"
        log_success "Subdiretório memory/$dir criado"
    fi
done

log_info "📄 Validando arquivos essenciais..."

# Verificar arquivos essenciais em /init
EXPECTED_INIT_FILES=("core-context.memory" "estrutura-basica.memory" "comandos-essenciais.memory" "checklist-diaria.memory")
for file in "${EXPECTED_INIT_FILES[@]}"; do
    if [ -f "/home/arturdr/Claude/init/$file" ]; then
        log_success "Essencial /init/$file encontrado"
    else
        log_error "Essencial /init/$file não encontrado!"
    fi
done

# Verificar CLAUDE.md
if [ -f "/home/arturdr/Claude/CLAUDE.md" ]; then
    log_success "Arquivo CLAUDE.md encontrado"
    
    # Verificar se imports apontam para /init
    if grep -q "import.*./init/" /home/arturdr/Claude/CLAUDE.md; then
        log_success "Imports no CLAUDE.md apontam para /init/"
    else
        log_warning "Imports no CLAUDE.md não apontam para /init/"
    fi
else
    log_error "Arquivo CLAUDE.md não encontrado!"
fi

log_info "📏 Analisando tamanhos dos arquivos..."

# Verificar tamanho dos arquivos essenciais
MAX_ESSENTIAL_SIZE=8192  # 8KB em bytes
for file in /home/arturdr/Claude/init/*.memory; do
    if [ -f "$file" ]; then
        SIZE=$(stat -c%s "$file")
        if [ "$SIZE" -gt "$MAX_ESSENTIAL_SIZE" ]; then
            log_warning "Arquivo essencial $(basename "$file") tem $(( SIZE / 1024 ))KB (>8KB recomendado)"
        else
            log_success "Arquivo essencial $(basename "$file") tem tamanho adequado ($(( SIZE / 1024 ))KB)"
        fi
    fi
done

log_info "🔍 Procurando arquivos duplicados ou vazios..."

# Verificar arquivos vazios
EMPTY_FILES=0
for file in /home/arturdr/Claude/memory/*/*.memory; do
    if [ -f "$file" ]; then
        if [ ! -s "$file" ]; then
            log_warning "Arquivo vazio encontrado: $(basename "$file")"
            ((EMPTY_FILES++))
        fi
    fi
done

if [ "$EMPTY_FILES" -eq 0 ]; then
    log_success "Nenhum arquivo vazio encontrado"
else
    log_warning "$EMPTY_FILES arquivos vazios encontrados"
fi

# Verificar arquivos duplicados (conteúdo)
log_info "🔍 Verificando conteúdo duplicado..."
DUPLICATE_COUNT=0
find /home/arturdr/Claude/memory/ -name "*.memory" -exec md5sum {} \; | sort | uniq -d | while read -r hash file; do
    log_warning "Conteúdo duplicado: $file"
    ((DUPLICATE_COUNT++))
done

if [ "$DUPLICATE_COUNT" -eq 0 ]; then
    log_success "Nenhum conteúdo duplicado encontrado"
else
    log_warning "$DUPLICATE_COUNT arquivos com conteúdo duplicado"
fi

log_info "📊 Gerando relatório de saúde..."

# Contagem total de arquivos
TOTAL_INIT_FILES=$(find /home/arturdr/Claude/init -name "*.memory" 2>/dev/null | wc -l)
TOTAL_MEMORY_FILES=$(find /home/arturdr/Claude/memory -name "*.memory" 2>/dev/null | wc -l)

echo ""
echo -e "${BLUE}📊 RELATÓRIO DE SAÚDE:${NC}"
echo "==================================="
echo -e "📂 Arquivos Essenciais: ${GREEN}$TOTAL_INIT_FILES${NC}"
echo -e "📚 Arquivos de Memória: ${GREEN}$TOTAL_MEMORY_FILES${NC}"
echo -e "📏 Total: ${GREEN}$((TOTAL_INIT_FILES + TOTAL_MEMORY_FILES))${NC}"
echo -e "📁 Diretórios Essenciais: ${GREEN}$(ls -1d /home/arturdr/Claude/init/ 2>/dev/null | wc -l)${NC}"
echo -e "📁 Diretórios de Memória: ${GREEN}$(ls -1d /home/arturdr/Claude/memory/ 2>/dev/null | wc -l)${NC}"
echo ""

# Resumo do status
echo -e "${BLUE}📋 RESUMO DA VALIDAÇÃO:${NC}"
echo "================================"
echo -e "${GREEN}✅ Sucessos: $SUCCESS${NC}"
echo -e "${YELLOW}⚠️  Avisos: $WARNINGS${NC}"
echo -e "${RED}❌ Erros: $ERRORS${NC}"

# Status final
if [ "$ERRORS" -eq 0 ]; then
    echo -e "${GREEN}🎉 Estrutura validada com sucesso!${NC}"
    exit 0
elif [ "$ERRORS" -lt "$WARNINGS" ]; then
    echo -e "${YELLOW}⚠️  Estrutura funcional com avisos${NC}"
    exit 1
else
    echo -e "${RED}❌ Erros encontrados - revise a estrutura${NC}"
    exit 2
fi
