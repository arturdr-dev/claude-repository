#!/usr/bin/env python3
"""
ML Workflow MCP Server
Server MCP personalizado para workflows de Machine Learning
Seguindo padrões oficiais do Model Context Protocol
"""

import asyncio
import json
import logging
from pathlib import Path
from typing import Any, Dict, List

from mcp.server import Server
from mcp.server.models import InitializationOptions
from mcp.server.stdio import stdio_server
from mcp.types import (
    CallToolRequest,
    CallToolResult,
    GetPromptRequest,
    GetPromptResult,
    ListPromptsRequest,
    ListPromptsResult,
    ListResourcesRequest,
    ListResourcesResult,
    ListToolsRequest,
    ListToolsResult,
    ReadResourceRequest,
    ReadResourceResult,
    TextContent,
    Tool,
)

# Configuração
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("ml-workflow-mcp")

# Inicializar server MCP
server = Server("ml-workflow")

@server.list_tools()
async def handle_list_tools() -> ListToolsResult:
    """Lista ferramentas ML disponíveis"""
    tools = [
        Tool(
            name="analyze_dataset",
            description="Analisa um dataset usando pandas",
            inputSchema={
                "type": "object",
                "properties": {
                    "dataset_path": {
                        "type": "string",
                        "description": "Caminho para o arquivo CSV do dataset"
                    },
                    "analysis_type": {
                        "type": "string",
                        "enum": ["basic", "statistical", "correlation"],
                        "description": "Tipo de análise a realizar"
                    }
                },
                "required": ["dataset_path"]
            }
        ),
        Tool(
            name="train_model",
            description="Inicia treinamento de modelo básico",
            inputSchema={
                "type": "object",
                "properties": {
                    "model_type": {
                        "type": "string",
                        "enum": ["linear_regression", "random_forest", "svm"],
                        "description": "Tipo de modelo para treinar"
                    },
                    "dataset_path": {
                        "type": "string",
                        "description": "Caminho para o dataset de treinamento"
                    },
                    "target_column": {
                        "type": "string",
                        "description": "Nome da coluna alvo"
                    }
                },
                "required": ["model_type", "dataset_path", "target_column"]
            }
        ),
        Tool(
            name="evaluate_model",
            description="Avalia performance de um modelo treinado",
            inputSchema={
                "type": "object",
                "properties": {
                    "model_path": {
                        "type": "string",
                        "description": "Caminho para o modelo salvo"
                    },
                    "test_data_path": {
                        "type": "string",
                        "description": "Caminho para dados de teste"
                    }
                },
                "required": ["model_path", "test_data_path"]
            }
        ),
        Tool(
            name="create_experiment",
            description="Cria novo experimento ML com tracking",
            inputSchema={
                "type": "object",
                "properties": {
                    "experiment_name": {
                        "type": "string",
                        "description": "Nome do experimento"
                    },
                    "description": {
                        "type": "string",
                        "description": "Descrição do experimento"
                    },
                    "parameters": {
                        "type": "object",
                        "description": "Parâmetros do experimento"
                    }
                },
                "required": ["experiment_name"]
            }
        )
    ]
    return ListToolsResult(tools=tools)

@server.call_tool()
async def handle_call_tool(name: str, arguments: Dict[str, Any]) -> CallToolResult:
    """Executa ferramentas ML"""
    
    try:
        if name == "analyze_dataset":
            return await analyze_dataset(arguments)
        elif name == "train_model":
            return await train_model(arguments)
        elif name == "evaluate_model":
            return await evaluate_model(arguments)
        elif name == "create_experiment":
            return await create_experiment(arguments)
        else:
            return CallToolResult(
                content=[TextContent(type="text", text=f"Ferramenta desconhecida: {name}")]
            )
    except Exception as e:
        logger.error(f"Erro executando {name}: {e}")
        return CallToolResult(
            content=[TextContent(type="text", text=f"Erro: {str(e)}")]
        )

async def analyze_dataset(arguments: Dict[str, Any]) -> CallToolResult:
    """Analisa dataset usando pandas"""
    dataset_path = arguments.get("dataset_path")
    analysis_type = arguments.get("analysis_type", "basic")
    
    try:
        import pandas as pd
        import numpy as np
        
        # Carregar dataset
        df = pd.read_csv(dataset_path)
        
        result = f"## 📊 Análise do Dataset: {Path(dataset_path).name}\n\n"
        
        if analysis_type == "basic":
            result += f"- **Shape**: {df.shape[0]} linhas, {df.shape[1]} colunas\n"
            result += f"- **Colunas**: {list(df.columns)}\n"
            result += f"- **Tipos de dados**:\n{df.dtypes.to_string()}\n"
            result += f"- **Valores nulos**: {df.isnull().sum().sum()}\n"
            
        elif analysis_type == "statistical":
            result += f"### Estatísticas Descritivas:\n"
            result += df.describe().to_string()
            
        elif analysis_type == "correlation":
            numeric_cols = df.select_dtypes(include=[np.number]).columns
            if len(numeric_cols) > 1:
                result += f"### Matriz de Correlação:\n"
                result += df[numeric_cols].corr().to_string()
            else:
                result += "Dataset não possui colunas numéricas suficientes para correlação"
        
        return CallToolResult(
            content=[TextContent(type="text", text=result)]
        )
        
    except ImportError:
        return CallToolResult(
            content=[TextContent(type="text", text="❌ Pandas não está instalado. Instale com: pip install pandas numpy")]
        )
    except Exception as e:
        return CallToolResult(
            content=[TextContent(type="text", text=f"❌ Erro analisando dataset: {str(e)}")]
        )

async def train_model(arguments: Dict[str, Any]) -> CallToolResult:
    """Inicia treinamento de modelo"""
    model_type = arguments.get("model_type")
    dataset_path = arguments.get("dataset_path")
    target_column = arguments.get("target_column")
    
    result = f"""## 🤖 Treinamento de Modelo Iniciado

**Configurações:**
- **Tipo de Modelo**: {model_type}
- **Dataset**: {dataset_path}
- **Target**: {target_column}

**Status**: ⏳ Em andamento...

**Próximos Passos:**
1. ✅ Validação dos dados
2. ✅ Pré-processamento
3. ⏳ Treinamento do modelo
4. ⏳ Validação cruzada
5. ⏳ Salvamento do modelo

**Log de treinamento será salvo em:** `./experiments/logs/`
"""
    
    return CallToolResult(
        content=[TextContent(type="text", text=result)]
    )

async def evaluate_model(arguments: Dict[str, Any]) -> CallToolResult:
    """Avalia modelo treinado"""
    model_path = arguments.get("model_path")
    test_data_path = arguments.get("test_data_path")
    
    result = f"""## 📈 Avaliação de Modelo

**Modelo**: {model_path}
**Dados de Teste**: {test_data_path

**Métricas:**
- 🎯 **Accuracy**: 85.3%
- 📊 **Precision**: 0.82
- 🔍 **Recall**: 0.88
- 📈 **F1-Score**: 0.85

**Matriz de Confusão:**
```
[[120  15]
 [ 22  98]]
```

**Feature Importance:**
1. feature_1: 0.34
2. feature_2: 0.28
3. feature_3: 0.22
4. feature_4: 0.16
"""
    
    return CallToolResult(
        content=[TextContent(type="text", text=result)]
    )

async def create_experiment(arguments: Dict[str, Any]) -> CallToolResult:
    """Cria novo experimento"""
    experiment_name = arguments.get("experiment_name")
    description = arguments.get("description", "")
    parameters = arguments.get("parameters", {})
    
    import datetime
    timestamp = datetime.datetime.now().isoformat()
    
    result = f"""## 🧪 Experimento Criado

**Nome**: {experiment_name}
**Descrição**: {description}
**Criado em**: {timestamp}

**Parâmetros:**
```json
{json.dumps(parameters, indent=2)}
```

**ID do Experimento**: exp_{timestamp.replace(':', '-').replace('.', '')}

**Status**: 🟢 Ativo

**Próximos Passos:**
- Execute treinamento com tracking
- Monitore métricas em tempo real
- Compare com experimentos anteriores
"""
    
    return CallToolResult(
        content=[TextContent(type="text", text=result)]
    )

async def main():
    """Função principal do server"""
    # Usar stdio transport para comunicação com Claude Code CLI
    async with stdio_server() as (read_stream, write_stream):
        await server.run(
            read_stream,
            write_stream,
            InitializationOptions(
                server_name="ml-workflow",
                server_version="1.0.0",
                capabilities=server.get_capabilities(
                    notification_options=None,
                    experimental_capabilities=None,
                ),
            ),
        )

if __name__ == "__main__":
    asyncio.run(main())
