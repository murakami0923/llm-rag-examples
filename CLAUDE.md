# LLM-RAG Examples - Claude Code Instructions

## Project Overview
This project is a comprehensive Docker-based development environment for experimenting with Large Language Models (LLMs) and Retrieval-Augmented Generation (RAG) systems. It provides a complete setup for learning and developing with various vector databases, embedding models, and LLM integrations.

## Architecture

### Container Services
The project uses Docker Compose with 5 main services:

1. **Jupyter Container** (`llm-rag-examples-jupyter`)
   - Built from Python 3.13.4-bookworm
   - Runs JupyterLab with comprehensive ML/AI libraries
   - Port: 8888

2. **MySQL Container** (`llm-rag-examples-mysql`)
   - MySQL 9.2.0 with vector database capabilities
   - Stores embeddings using `VECTOR(4096)` data type
   - Port: 3306

3. **Ollama Container** (`llm-rag-examples-ollama`)
   - Local LLM runtime environment
   - Version: 0.5.7
   - Port: 11434
   - Supports GPU acceleration (when available)

4. **Elasticsearch Container** (`llm-rag-examples-elasticsearch1`)
   - Elasticsearch 8.18.0 for vector search
   - Single-node deployment
   - Security disabled for development
   - Port: 9200

5. **Kibana Container** (`llm-rag-examples-kibana`)
   - Kibana 8.18.0 for Elasticsearch visualization
   - Port: 5601

### Supported Technologies

#### Vector Databases
- **ChromaDB**: In-memory vector database for quick prototyping
- **MySQL 9.x**: Traditional database with vector search capabilities
- **Elasticsearch**: Full-text and vector search engine

#### LLM Integration
- **Amazon Bedrock**: Cloud-based LLM services via AWS
- **Ollama**: Local LLM deployment and management
- **LangChain**: Framework for LLM application development

#### Embedding Models
- **HuggingFace Transformers**: Various embedding models (e.g., all-MiniLM-L6-v2)
- **Sentence Transformers**: Specialized for semantic similarity

## Project Structure

```
/home/murakami/study/llm-rag/llm-rag-examples/
├── docker-compose.cpu.yml          # CPU-only configuration
├── docker-compose.gpu.yml          # GPU-enabled configuration
├── docker-compose.yml               # Symlink to active config
├── README.md                        # Comprehensive setup guide (Japanese)
├── compose-*.sh                     # Docker management scripts
├── .env                            # Environment configuration (create from .env.example)
├── .aws/                           # AWS credentials (user-provided)
├── jupyter/
│   ├── Dockerfiles                 # JupyterLab container definition
│   ├── requirements.txt            # Python dependencies
│   ├── startup.sh                  # Container initialization script
│   └── notebooks/                  # Jupyter notebooks and examples
│       ├── chromadb-ex*.ipynb      # ChromaDB examples
│       ├── elasticsearch-vector-ex*.ipynb # Elasticsearch examples
│       ├── mysql9-vector-ex*.ipynb # MySQL vector examples
│       ├── bedrock-api-ex*.ipynb   # AWS Bedrock examples
│       ├── backlog-*.ipynb         # Backlog API integration examples
│       ├── input/                  # Sample input files
│       ├── output/                 # Generated results
│       └── backlog-wikis/          # Japanese company wiki data
├── mysql/
│   ├── init-db/
│   │   └── init-db.sql            # Database schema initialization
│   └── data/                      # MySQL data directory (persistent)
├── elasticsearch/
│   └── esdata1/                   # Elasticsearch data (persistent)
└── ollama/
    ├── data/                      # Ollama models and data
    └── models.txt                 # List of available models
```

## Key Dependencies (requirements.txt)

### Core ML/AI Stack
- **jupyterlab**: 4.3.4 - Development environment
- **langchain**: 0.3.14 - LLM application framework
- **langchain-ollama**: 0.2.2 - Ollama integration
- **langchain-aws**: 0.2.12 - AWS Bedrock integration
- **langchain-huggingface**: 0.1.2 - HuggingFace models
- **chromadb**: 0.6.3 - Vector database
- **sentence-transformers**: 4.1.0 - Embedding models

### Database Connectors
- **mysql-connector-python**: 9.2.0 - MySQL connectivity
- **elasticsearch8**: 8.18.0 - Elasticsearch client

### Utilities
- **pandas**: 2.2.3 - Data manipulation
- **matplotlib**: 3.10.0 - Visualization
- **openpyxl**: 3.1.5 - Excel file handling
- **tqdm**: 4.67.1 - Progress bars

## Development Workflow

### Initial Setup
1. **Environment Configuration**: Copy `.env.example` to `.env` and configure:
   - User UID/GID for proper file permissions
   - AWS credentials and profile
   - MySQL connection details
   - Jupyter token

2. **Docker Configuration**: Choose CPU or GPU mode:
   ```bash
   ln -s docker-compose.cpu.yml docker-compose.yml  # CPU only
   ln -s docker-compose.gpu.yml docker-compose.yml  # GPU enabled
   ```

3. **Build and Start**: Use provided shell scripts:
   ```bash
   ./compose-build.sh    # Build containers
   ./compose-reup.sh     # Start services
   ```

### Database Initialization
Execute MySQL schema setup:
```bash
docker exec -ti llm-rag-examples-mysql /bin/bash
cd ~/init-db/
mysql -u [user] -p [database] < init-db.sql
```

### Jupyter Access
Access JupyterLab via browser:
```bash
./docker-logs-jupyter.sh  # Get access URL with token
```

## Code Patterns and Examples

### Vector Database Usage
The project demonstrates three main vector database patterns:

1. **ChromaDB Pattern** (chromadb-ex01.ipynb):
   - In-memory vector storage
   - Simple document ingestion
   - Similarity search with relevance scores

2. **MySQL Vector Pattern** (mysql9-vector-ex01-*.ipynb):
   - Persistent vector storage in MySQL
   - Custom embedding table schema
   - SQL-based vector operations

3. **Elasticsearch Pattern** (elasticsearch-vector-ex*.ipynb):
   - RESTful API and Python client approaches
   - Full-text and vector hybrid search
   - Index management and mappings

### LLM Integration Patterns
- **AWS Bedrock**: Cloud-based LLM access with profile-based authentication
- **Ollama**: Local model deployment and inference
- **LangChain**: Unified interface for different LLM providers

### Data Processing
- **Document Chunking**: Text splitting for better embeddings
- **Embedding Generation**: HuggingFace and Sentence Transformers
- **Metadata Handling**: JSON storage for document context

## Development Guidelines

### File Organization
- Keep notebooks in `/jupyter/notebooks/` directory
- Use descriptive naming: `{technology}-{type}-ex{number}-{description}.ipynb`
- Store input data in `input/` subdirectory
- Save results to `output/` subdirectory

### Best Practices
- Always activate Python venv in notebook cells if needed
- Use environment variables for configuration (MySQL credentials, etc.)
- Include progress bars (tqdm) for long-running operations
- Save intermediate results to Excel files for analysis

### Docker Management
- Use `./compose-reup.sh` for clean restart
- Use `./compose-down.sh` to stop all services
- Check logs with `./docker-logs-jupyter.sh`
- Rebuild containers with `./compose-build.sh`

## Common Use Cases

### 1. Vector Similarity Search
Embed documents into vector space and find semantically similar content based on user queries.

### 2. RAG Implementation
Combine vector search with LLM generation for context-aware question answering.

### 3. Document Analysis
Process and analyze large document collections using various embedding models.

### 4. LLM Comparison
Test different local and cloud-based LLMs on the same tasks for performance comparison.

## Environment Requirements
- Linux with Docker and Docker Compose v2+
- Minimum 16GB RAM recommended
- GPU with CUDA support recommended for Ollama
- AWS account for Bedrock integration (optional)

## Language Note
The project documentation (README.md) and many example notebooks are in Japanese, reflecting the original development context. The sample data includes Japanese company wiki pages from Backlog.

This setup provides a comprehensive environment for learning and experimenting with modern LLM and vector database technologies in a containerized, reproducible manner.