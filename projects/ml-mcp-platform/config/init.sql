-- 🗄️ Banco de Dados ML-MCP - Configuração Inicial
-- Usuário: arturdr | Senha: Drugo321!

-- Criar schemas
CREATE SCHEMA IF NOT EXISTS ml_experiments;
CREATE SCHEMA IF NOT EXISTS ml_models;
CREATE SCHEMA IF NOT EXISTS ml_data;
CREATE SCHEMA IF NOT EXISTS ml_monitoring;

-- Criar tabelas de experimentos
CREATE TABLE IF NOT EXISTS ml_experiments.experiments (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) DEFAULT 'active'
);

-- Criar tabela de modelos
CREATE TABLE IF NOT EXISTS ml_models.models (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    version VARCHAR(50) NOT NULL,
    model_type VARCHAR(100),
    accuracy FLOAT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    file_path VARCHAR(500)
);

-- Criar tabela de métricas
CREATE TABLE IF NOT EXISTS ml_monitoring.metrics (
    id SERIAL PRIMARY KEY,
    model_id INTEGER REFERENCES ml_models.models(id),
    metric_name VARCHAR(100) NOT NULL,
    metric_value FLOAT NOT NULL,
    recorded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Inserir dados de exemplo
INSERT INTO ml_experiments.experiments (name, description) VALUES
('Experimento Inicial', 'Primeiro experimento ML-MCP Platform'),
('Teste de Modelo', 'Experimento para testar pipeline');

INSERT INTO ml_models.models (name, version, model_type, accuracy) VALUES
('RandomForest_v1', '1.0.0', 'RandomForest', 0.85),
('LinearRegression_v1', '1.0.0', 'LinearRegression', 0.78);

-- Dar permissões ao usuário arturdr
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA ml_experiments TO arturdr;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA ml_models TO arturdr;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA ml_data TO arturdr;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA ml_monitoring TO arturdr;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA ml_experiments TO arturdr;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA ml_models TO arturdr;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA ml_monitoring TO arturdr;

-- Configurações adicionais
ALTER DEFAULT PRIVILEGES IN SCHEMA ml_experiments GRANT ALL ON TABLES TO arturdr;
ALTER DEFAULT PRIVILEGES IN SCHEMA ml_models GRANT ALL ON TABLES TO arturdr;
ALTER DEFAULT PRIVILEGES IN SCHEMA ml_monitoring GRANT ALL ON TABLES TO arturdr;

COMMIT;