<#
.SYNOPSIS
    Initialize a production-ready Python backend project structure with FastAPI.

.DESCRIPTION
    This script sets up a complete Python backend project with:
    - UV package manager and virtual environment
    - Layered architecture (API, Services, Repositories, Models)
    - Alembic for database migrations
    - Ruff for linting and formatting
    - Taskfile for common development tasks
    - Docker configuration
    - Testing structure

.EXAMPLE
    .\init_python.ps1
    Initializes the project structure in the current directory.

.NOTES
    Requirements:
    - UV package manager installed
    - Internet connection (for downloading ruff.toml)
    - Task (optional, for running Taskfile commands)
#>

# 1. Check if Python uv project exists (pyproject.toml presence)
if (-Not (Test-Path -Path "./pyproject.toml")) {
    Write-Host "Python uv project not found, initializing with uv..."
    uv init .
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Failed to initialize uv project"
        exit 1
    }
} else {
    Write-Host "Python uv project detected."
}

# 2. Check if virtual environment folder '.venv' exists
if (-Not (Test-Path -Path "./.venv")) {
    Write-Host "Virtual environment not found, creating with uv..."
    uv venv .venv
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Failed to create virtual environment"
        exit 1
    }
} else {
    Write-Host "Virtual environment detected."
}

# 3. Check if ruff.toml exists, if not download
if (-Not (Test-Path -Path "./ruff.toml")) {
    Write-Host "ruff.toml not found, downloading..."
    try {
        Invoke-WebRequest -Uri "https://raw.githubusercontent.com/fl-Henry/scripts/main/scripts/ruff.toml" -OutFile "ruff.toml"
    } catch {
        Write-Error "Failed to download ruff.toml"
        exit 1
    }
} else {
    Write-Host "ruff.toml already exists."
}

if (Test-Path "main.py") { Remove-Item "main.py" -Force }

# 4. Create project directory structure
$dirs = @(
    'config',
    'src/app',
    'src/app/api',
    'src/app/api/v1',
    'src/app/api/v1/endpoints',
    'src/app/core',
    'src/app/models',
    'src/app/schemas',
    'src/app/services',
    'src/app/repositories',
    'src/app/tasks',
    'src/app/utils',
    'src/app/db',
    'src/app/cache',
    'tests',
    'scripts',
    'docker',
    'docs'
)

$dirs | ForEach-Object { New-Item -ItemType Directory -Path $_ -Force | Out-Null }

# 5. Create Python module files
$pythonFiles = @(
    'config/__init__.py',
    'config/settings.py',
    'config/database.py',
    'config/cache.py',
    'config/logging.py',
    'src/app/__init__.py',
    'src/app/main.py',
    'src/app/api/__init__.py',
    'src/app/api/dependencies.py',
    'src/app/api/middleware.py',
    'src/app/api/v1/__init__.py',
    'src/app/api/v1/router.py',
    'src/app/api/v1/endpoints/__init__.py',
    'src/app/api/v1/endpoints/users.py',
    'src/app/api/v1/endpoints/auth.py',
    'src/app/api/v1/endpoints/health.py',
    'src/app/core/__init__.py',
    'src/app/core/security.py',
    'src/app/core/exceptions.py',
    'src/app/core/events.py',
    'src/app/core/constants.py',
    'src/app/models/__init__.py',
    'src/app/models/base.py',
    'src/app/models/user.py',
    'src/app/models/mixins.py',
    'src/app/schemas/__init__.py',
    'src/app/schemas/base.py',
    'src/app/schemas/user.py',
    'src/app/schemas/auth.py',
    'src/app/schemas/responses.py',
    'src/app/services/__init__.py',
    'src/app/services/user_service.py',
    'src/app/services/auth_service.py',
    'src/app/services/email_service.py',
    'src/app/repositories/__init__.py',
    'src/app/repositories/base.py',
    'src/app/repositories/user_repository.py',
    'src/app/tasks/__init__.py',
    'src/app/tasks/celery_app.py',
    'src/app/tasks/email_tasks.py',
    'src/app/tasks/cleanup_tasks.py',
    'src/app/utils/__init__.py',
    'src/app/utils/datetime.py',
    'src/app/utils/validators.py',
    'src/app/utils/helpers.py',
    'src/app/db/__init__.py',
    'src/app/db/session.py',
    'src/app/db/base.py',
    'src/app/cache/__init__.py',
    'src/app/cache/redis_client.py',
    'src/app/cache/cache_keys.py',
    'scripts/init_db.py',
    'scripts/seed_data.py',
    'scripts/run_migrations.py'
)

$pythonFiles | ForEach-Object { New-Item -ItemType File -Path $_ -Force | Out-Null }

# 6. Create configuration and documentation files
$configFiles = @(
    'docker/Dockerfile',
    'docker/Dockerfile.dev',
    'docker/docker-compose.yml',
    'docs/api.md',
    'docs/architecture.md',
    'docs/deployment.md',
    '.env.example',
    '.env',
    '.gitignore',
    '.dockerignore',
    'requirements.txt',
    'requirements-dev.txt',
    'README.md'
)

$configFiles | ForEach-Object { New-Item -ItemType File -Path $_ -Force | Out-Null }

Write-Host "Python project structure created in $(Get-Location)" -ForegroundColor Green

# 7. Initialize Alembic for database migrations
if (-Not (Test-Path -Path "./alembic.ini")) {
    Write-Host "Initializing Alembic..."
    uv add alembic
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Failed to install Alembic"
        exit 1
    }
    
    & .venv\Scripts\alembic.exe init alembic
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Failed to initialize Alembic"
        exit 1
    }
    Write-Host "Alembic initialized successfully" -ForegroundColor Green
} else {
    Write-Host "Alembic already initialized."
}

# 8. Create Taskfile.yml with development tasks
if (-Not (Test-Path -Path "./Taskfile.yml")) {
    Write-Host "Creating Taskfile.yml..."
    $taskfileContent = @'
version: '3'

tasks:
  # Development
  dev:
    desc: Run development server with hot reload
    cmds:
      - uv run uvicorn src.app.main:app --reload --host 0.0.0.0 --port 8000

  install:
    desc: Install all dependencies
    cmds:
      - uv sync

  # Database
  db-init:
    desc: Initialize database
    cmds:
      - uv run python scripts/init_db.py

  db-migrate:
    desc: Create new migration
    cmds:
      - uv run alembic revision --autogenerate -m "{{.CLI_ARGS}}"

  db-upgrade:
    desc: Apply migrations
    cmds:
      - uv run alembic upgrade head

  db-downgrade:
    desc: Rollback one migration
    cmds:
      - uv run alembic downgrade -1

  db-seed:
    desc: Seed database with test data
    cmds:
      - uv run python scripts/seed_data.py

  db-reset:
    desc: Reset database (drop all and recreate)
    cmds:
      - uv run alembic downgrade base
      - uv run alembic upgrade head

  # Testing
  test:
    desc: Run all tests
    cmds:
      - uv run pytest tests/ -v

  # Code Quality
  lint:
    desc: Run linting
    cmds:
      - uvx ruff check .

  lint-fix:
    desc: Run linting with auto-fix
    cmds:
      - uvx ruff check --fix .

  format:
    desc: Format code
    cmds:
      - uvx ruff format .

  # Docker
  docker-build:
    desc: Build Docker image
    cmds:
      - docker build -t app:latest -f docker/Dockerfile .

  docker-up:
    desc: Start Docker containers
    cmds:
      - docker-compose -f docker/docker-compose.yml up -d

  docker-down:
    desc: Stop Docker containers
    cmds:
      - docker-compose -f docker/docker-compose.yml down

  docker-logs:
    desc: View Docker logs
    cmds:
      - docker-compose -f docker/docker-compose.yml logs -f

  # Celery
  celery-worker:
    desc: Start Celery worker
    cmds:
      - uv run celery -A src.app.tasks.celery_app worker --loglevel=info

  celery-beat:
    desc: Start Celery beat scheduler
    cmds:
      - uv run celery -A src.app.tasks.celery_app beat --loglevel=info

  # Cleanup
  clean:
    desc: Clean up cache and temporary files
    cmds:
      - rm -rf __pycache__ .pytest_cache .mypy_cache .ruff_cache htmlcov .coverage
      - find . -type d -name __pycache__ -exec rm -rf {} +
      - find . -type f -name "*.pyc" -delete

'@
    Set-Content -Path "Taskfile.yml" -Value $taskfileContent
    Write-Host "Taskfile.yml created successfully" -ForegroundColor Green
} else {
    Write-Host "Taskfile.yml already exists."
}

Write-Host ""
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host "Project initialization complete!" -ForegroundColor Green
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "  1. Install dependencies: task install" -ForegroundColor White
Write-Host "  2. Configure database in alembic/env.py" -ForegroundColor White
Write-Host "  3. Create first migration: task db-migrate -- 'initial'" -ForegroundColor White
Write-Host "  4. Run development server: task dev" -ForegroundColor White
Write-Host ""
Write-Host "Available commands:" -ForegroundColor Yellow
Write-Host "  task --list    - Show all available tasks" -ForegroundColor White
Write-Host "  task dev       - Start development server" -ForegroundColor White
Write-Host "  task test      - Run tests" -ForegroundColor White
Write-Host "  task lint      - Check code quality" -ForegroundColor White
Write-Host ""

