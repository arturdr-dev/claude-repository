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
