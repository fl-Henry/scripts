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


# Existing Python project structure creation (silent)
$dirs = @(
    'cmd/telegram-bot', 'cmd/api', 'cmd/admin-panel',
    'internal/models', 'internal/services', 'internal/repositories', 'internal/config', 'internal/shared',
    'pkg/blockchain', 'pkg/telegram', 'pkg/validators', 'pkg/metrics',
    'api', 'configs', 'migrations', 'docker', 'deployments', 'scripts', 'test', 'docs', 'web'
)

$dirs | ForEach-Object { New-Item -ItemType Directory -Path $_ -Force | Out-Null }

@(
    'configs/app.yaml', 'configs/db.toml',
    'README.md',
    'docker/Dockerfile.api', 'docker/Dockerfile.admin', 'docker/docker-compose.yml',
    'Taskfile.yml'
) | ForEach-Object { New-Item -ItemType File -Path $_ -Force | Out-Null }

Write-Host "✅ Python project structure created in $(Get-Location)" -ForegroundColor Green
# Tree view excluding .venv and venv content completely
ls -Directory | Where-Object Name -ne '.venv' | ForEach-Object { "└── $($_.Name)"; ls $_.FullName | ForEach-Object { "    └── $($_.Name)" } }
ls -File | Where-Object Name -ne '.venv' | ForEach-Object { "└── $($_.Name)" }
