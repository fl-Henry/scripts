# Python Backend Project Initialization Script

## Overview

`init_python.ps1` is a PowerShell script that automatically sets up a production-ready Python backend project with FastAPI, following industry best practices and layered architecture patterns.

## Features

- **UV Package Manager** - Modern Python package and project management
- **Layered Architecture** - Clean separation: API → Services → Repositories → Models
- **Database Migrations** - Alembic for version-controlled schema changes
- **Code Quality** - Ruff for linting and formatting
- **Task Automation** - Taskfile for common development workflows
- **Docker Ready** - Configuration files for containerization
- **Testing Structure** - Organized test directories (unit, integration, e2e)
- **Background Tasks** - Celery integration for async job processing

## Requirements

- **UV** - Python package manager ([install](https://github.com/astral-sh/uv))
- **Task** (optional) - Task runner ([install](https://taskfile.dev))
- **Internet connection** - For downloading ruff.toml configuration

## Usage

```powershell
.\init_python.ps1
```

Run this command in an empty directory or existing project root.

## What It Creates

### Project Structure

```
project_root/
├── config/                   # Configuration management
│   ├── settings.py           # Pydantic settings
│   ├── database.py           # DB configuration
│   ├── cache.py              # Redis/cache config
│   └── logging.py            # Logging setup
│
├── src/app/
│   ├── api/                  # API layer
│   │   ├── v1/
│   │   │   └── endpoints/    # API endpoints
│   │   ├── dependencies.py   # FastAPI dependencies
│   │   └── middleware.py     # Custom middleware
│   │
│   ├── core/                 # Core business logic
│   │   ├── security.py       # Auth, JWT, hashing
│   │   ├── exceptions.py     # Custom exceptions
│   │   └── constants.py      # App constants
│   │
│   ├── models/               # Database models (SQLAlchemy)
│   ├── schemas/              # Pydantic schemas (DTOs)
│   ├── services/             # Business logic layer
│   ├── repositories/         # Data access layer
│   ├── tasks/                # Background tasks (Celery)
│   ├── utils/                # Utility functions
│   ├── db/                   # Database utilities
│   ├── cache/                # Cache layer
│   └── main.py               # Application entry point
│
├── tests/                    # Test suite
│   ├── unit/
│   ├── integration/
│   └── e2e/
│
├── scripts/                  # Utility scripts
├── docker/                   # Docker configuration
├── docs/                     # Documentation
├── alembic/                  # Database migrations (auto-generated)
├── Taskfile.yml              # Task automation
└── pyproject.toml            # Project metadata
```

## Script Steps

### 1. UV Project Initialization
- Checks for existing `pyproject.toml`
- Initializes UV project if not present

### 2. Virtual Environment
- Creates `.venv` directory
- Sets up isolated Python environment

### 3. Ruff Configuration
- Downloads `ruff.toml` from remote repository
- Configures linting and formatting rules

### 4. Directory Structure
- Creates all necessary folders
- Follows layered architecture pattern

### 5. Python Files
- Generates module files with `__init__.py`
- Creates placeholder files for each layer

### 6. Configuration Files
- Docker files (Dockerfile, docker-compose.yml)
- Environment files (.env.example, .env)
- Documentation templates
- Git ignore files

### 7. Alembic Setup
- Installs Alembic via UV
- Initializes migration environment
- Creates `alembic/` directory with templates

### 8. Taskfile Creation
- Generates `Taskfile.yml` with common tasks
- Configures commands using `uv run`

## Available Tasks

After initialization, use these commands:

### Development
```bash
task dev          # Start development server with hot reload
task install      # Install all dependencies
```

### Database
```bash
task db-init      # Initialize database
task db-migrate   # Create new migration
task db-upgrade   # Apply migrations
task db-downgrade # Rollback one migration
task db-seed      # Seed test data
task db-reset     # Reset database
```

### Testing
```bash
task test         # Run all tests
```

### Code Quality
```bash
task lint         # Run linting
task lint-fix     # Auto-fix linting issues
task format       # Format code
```

### Docker
```bash
task docker-build # Build Docker image
task docker-up    # Start containers
task docker-down  # Stop containers
task docker-logs  # View logs
```

### Celery
```bash
task celery-worker # Start Celery worker
task celery-beat   # Start Celery scheduler
```

### Utilities
```bash
task clean        # Clean cache files
task --list       # Show all available tasks
```

## Next Steps After Running Script

1. **Install dependencies**
   ```bash
   task install
   ```

2. **Configure database connection**
   - Edit `alembic/env.py`
   - Set database URL in `.env`

3. **Create first migration**
   ```bash
   task db-migrate -- "initial migration"
   ```

4. **Apply migrations**
   ```bash
   task db-upgrade
   ```

5. **Start development server**
   ```bash
   task dev
   ```

6. **Access API documentation**
   - Swagger UI: http://localhost:8000/docs
   - ReDoc: http://localhost:8000/redoc

## Architecture Patterns

### Layered Architecture
- **API Layer** - Request/response handling, validation
- **Service Layer** - Business logic, orchestration
- **Repository Layer** - Data access abstraction
- **Model Layer** - Database entities

### Key Principles
- Separation of concerns
- Dependency injection
- Repository pattern for data access
- DTO pattern with Pydantic schemas
- Clean architecture principles

## Customization

### Modify Structure
Edit the `$dirs` and `$pythonFiles` arrays in the script to add/remove directories and files.

### Change Ruff Config
Update the download URL or create your own `ruff.toml` before running the script.

### Adjust Taskfile
Modify the `$taskfileContent` variable to add custom tasks.

## Troubleshooting

**"UV not found"**
- Install UV: `powershell -c "irm https://astral.sh/uv/install.ps1 | iex"`

**"Alembic initialization failed"**
- Ensure virtual environment is activated
- Check internet connection

**"Taskfile.yml already exists"**
- Delete existing file or skip this step
- Script won't overwrite existing Taskfile

## License

This script is provided as-is for project initialization purposes.
