#!/bin/bash
# 🧪 Test Script - Memory Validation

echo "🧪 Testando arquivos de memória..."

# Testar se os arquivos de memória existem
memory_files=(
    "memory/guia-claude-code-cli.md"
    "memory/checklist.memory"
    "memory/comandos.memory"
)

for file in "${memory_files[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file encontrado"
    else
        echo "❌ $file não encontrado"
        exit 1
    fi
done

# Testar se CLAUDE.md tem imports corretos
if grep -q "import.*memory" CLAUDE.md; then
    echo "✅ Imports de memória configurados corretamente"
else
    echo "❌ Imports de memória não encontrados"
    exit 1
fi

echo "🎉 Testes de memória concluídos com sucesso!"
