#!/bin/bash
# 🔍 Memory Usage Analysis Tool
# Script para analisar uso de memórias e otimização de tokens

echo "📊 ANÁLISE DE USO DE MEMÓRIAS - CLAUDE CODE CLI"
echo "=============================================="
echo ""

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}📁 ESTRUTURA ATUAL:${NC}"
echo "📂 Contextos Essenciais (/init/):"
find /home/arturdr/Claude/init -name "*.memory" -exec du -h {} \; | sort -hr
echo ""
echo "📚 Memórias Segmentadas (/memory/):"
echo "Essencial:"
find /home/arturdr/Claude/memory/essencial -name "*.memory" -exec du -h {} \; | sort -hr
echo ""
echo "Referências:"
find /home/arturdr/Claude/memory/referencias -name "*.memory" -exec du -h {} \; | sort -hr
echo ""
echo "Especializados:"
find /home/arturdr/Claude/memory/especializados -name "*.memory" -exec du -h {} \; | sort -hr

echo ""
echo -e "${BLUE}📈 ANÁLISE DE TAMANHO:${NC}"
TOTAL_INIT=$(du -sh /home/arturdr/Claude/init/ | cut -f1)
TOTAL_MEMORY=$(du -sh /home/arturdr/Claude/memory/ | cut -f1)
TOTAL_ESS=$(du -sh /home/arturdr/Claude/memory/essencial/ | cut -f1)
TOTAL_REF=$(du -sh /home/arturdr/Claude/memory/referencias/ | cut -f1)
TOTAL_ESP=$(du -sh /home/arturdr/Claude/memory/especializados/ | cut -f1)

echo -e "📂 Contextos Essenciais: ${YELLOW}$TOTAL_INIT${NC}"
echo -e "📚 Memórias Totais: ${YELLOW}$TOTAL_MEMORY${NC}"
echo -e "  📖 Essencial: ${GREEN}$TOTAL_ESS${NC}"
echo -e "  🔗 Referências: ${GREEN}$TOTAL_REF${NC}"
echo -e "  ⚙️ Especializados: ${GREEN}$TOTAL_ESP${NC}"

echo ""
echo -e "${BLUE}📊 ANÁLISE DE CONTEÚDO:${NC}"
echo "📋 Arquivos por categoria:"
echo -e "${GREEN}Contextos Essenciais:${NC} $(find /home/arturdr/Claude/init -name "*.memory" | wc -l) arquivos"
echo -e "${GREEN}Memórias Essenciais:${NC} $(find /home/arturdr/Claude/memory/essencial -name "*.memory" | wc -l) arquivos"
echo -e "${GREEN}Memórias de Referência:${NC} $(find /home/arturdr/Claude/memory/referencias -name "*.memory" | wc -l) arquivos"
echo -e "${GREEN}Memórias Especializadas:${NC} $(find /home/arturdr/Claude/memory/especializados -name "*.memory" | wc -l) arquivos"

echo ""
echo "📈 Linhas totais:"
wc -l /home/arturdr/Claude/init/*.memory /home/arturdr/Claude/memory/*/*.memory 2>/dev/null | tail -1

echo ""
echo -e "${YELLOW}⚠️  ALERTAS DE OTIMIZAÇÃO:${NC}"

# Verificar arquivos grandes
echo "📋 Arquivos maiores que 5KB:"
LARGE_FILES=$(find /home/arturdr/Claude -name "*.memory" -size +5k 2>/dev/null)
if [ -n "$LARGE_FILES" ]; then
    find /home/arturdr/Claude -name "*.memory" -size +5k -exec du -h {} \;
    echo -e "${RED}⚠️  Considere dividir arquivos grandes${NC}"
else
    echo -e "${GREEN}✅ Nenhum arquivo maior que 5KB${NC}"
fi

# Verificar arquivos antigos (não modificados há 30 dias)
echo ""
echo "📋 Arquivos não modificados há 30+ dias:"
OLD_FILES=$(find /home/arturdr/Claude/memory -name "*.memory" -mtime +30 2>/dev/null)
if [ -n "$OLD_FILES" ]; then
    find /home/arturdr/Claude/memory -name "*.memory" -mtime +30 -ls
    echo -e "${YELLOW}⚠️  Considere revisar ou arquivar${NC}"
else
    echo -e "${GREEN}✅ Todos os arquivos recentes${NC}"
fi

echo ""
echo -e "${BLUE}🎯 RECOMENDAÇÕES:${NC}"
echo "1. Manter apenas conteúdo essencial em /init/"
echo "2. Acessar conteúdo específico sob demanda com: /memory retrieve <categoria>/<arquivo>"
echo "3. Arquivar conteúdo não utilizado em /memory/archive/"
echo "4. Revisar mensalmente o uso e necessidade de cada memória"
echo "5. Manter documentação atualizada em /docs/gestao-otimizacao-tokens.md"

echo ""
echo -e "${GREEN}✅ Análise concluída com sucesso!${NC}"
echo -e "${BLUE}📊 Use: /memory retrieve docs/gestao-otimizacao-tokens para guia completa${NC}"
