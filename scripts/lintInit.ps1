# Ensure the script is running in a Node.js project directory (with package.json)
if (!(Test-Path "package.json")) {
    Write-Host "No package.json found. Initializing a new Node.js project..."
    
    # Run npm init -y to create a package.json with default settings
    npm init -y
    
    Write-Host "package.json has been created."
}

Write-Host "Setting up ESLint and Prettier..."

# Install ESLint and Prettier dependencies
npm install eslint eslint-config-airbnb eslint-plugin-import eslint-plugin-react eslint-plugin-jsx-a11y eslint-config-prettier eslint-plugin-prettier --save-dev

Write-Host "Dependencies installed successfully."

# Create .eslintrc configuration file
$eslintrcContent = @"
{
  "extends": ["airbnb", "plugin:prettier/recommended"],
  "env": {
    "browser": true,
    "node": true,
    "es2021": true
  },
  "parserOptions": {
    "ecmaVersion": 12,
    "sourceType": "module"
  },
  "rules": {
    "no-console": "off"  // Disable no-console rule
  }
}
"@

$eslintrcPath = ".eslintrc"
$eslintrcContent | Set-Content -Path $eslintrcPath

Write-Host ".eslintrc file created successfully."

# Create .prettierrc.json configuration file with the provided settings
$prettierConfig = @{
    "arrowParens" = "always"
    "bracketSpacing" = $true
    "endOfLine" = "lf"
    "htmlWhitespaceSensitivity" = "css"
    "insertPragma" = $false
    "singleAttributePerLine" = $false
    "bracketSameLine" = $false
    "jsxSingleQuote" = $false
    "printWidth" = 150
    "proseWrap" = "preserve"
    "quoteProps" = "as-needed"
    "requirePragma" = $false
    "semi" = $true
    "singleQuote" = $true
    "tabWidth" = 2
    "trailingComma" = "es5"
    "useTabs" = $false
    "vueIndentScriptAndStyle" = $false
    "embeddedLanguageFormatting" = "auto"
    "experimentalTernaries" = $false
}

# Convert to JSON and save to .prettierrc.json
$prettierConfig | ConvertTo-Json -Depth 10 | Set-Content -Path ".prettierrc.json"

Write-Host ".prettierrc.json file created successfully."

# Add lint and lint:fix scripts to package.json
$packageJsonPath = "package.json"
$packageJson = Get-Content -Raw -Path $packageJsonPath | ConvertFrom-Json

# Check if scripts section exists, and add if not
if (-not $packageJson.scripts) {
    $packageJson | Add-Member -MemberType NoteProperty -Name "scripts" -Value @{}
}

# Save the modified package.json
$packageJson | ConvertTo-Json -Depth 10 | Set-Content -Path $packageJsonPath

Write-Host "'lint' and 'lint:fix' scripts added to package.json."

Write-Host "ESLint and Prettier setup is complete!"
Write-Host "You can now run 'npm run lint' to check for linting errors, or 'npm run lint:fix' to automatically fix them."
