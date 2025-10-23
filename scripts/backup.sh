#!/bin/bash
# 💾 Backup Script - Claude Code CLI Ecossystem

BACKUP_DIR="backup"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/snapshot-$TIMESTAMP.tar.gz"

echo "💾 Criando backup do ecossistema Claude Code CLI..."

# Criar diretório de backup se não existir
mkdir -p $BACKUP_DIR

# Criar backup dos arquivos essenciais
tar -czf $BACKUP_FILE \
    CLAUDE.md \
    memory/ \
    docs/ \
    scripts/ \
    configs/ \
    agents/ \
    projects/ \
    --exclude='backup' \
    --exclude='logs' \
    2>/dev/null

if [ $? -eq 0 ]; then
    echo "✅ Backup criado: $BACKUP_FILE"
    echo "$(date): Backup criado - $BACKUP_FILE" >> logs/backup.log
    
    # Manter apenas os últimos 5 backups
    ls -t $BACKUP_DIR/snapshot-*.tar.gz | tail -n +6 | xargs -r rm
    echo "🧹 Backups antigos removidos"
else
    echo "❌ Erro ao criar backup"
    exit 1
fi
