# Lee las variables de .env y construye la imagen Docker

# Leer .env y extraer variables
$envVars = @{}
Get-Content .env | ForEach-Object {
    if ($_ -match "^([^#][^=]+)=(.*)$") {
        $envVars[$matches[1]] = $matches[2]
    }
}

# Construir el comando docker build
$buildArgs = @(
    "--build-arg", "NEXT_PUBLIC_PIPECAT_URL=$($envVars['NEXT_PUBLIC_PIPECAT_URL'])",
    "--build-arg", "NEXT_PUBLIC_SUPABASE_URL=$($envVars['NEXT_PUBLIC_SUPABASE_URL'])",
    "--build-arg", "NEXT_PUBLIC_SUPABASE_ANON_KEY=$($envVars['NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY'])",
    "--build-arg", "NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY=$($envVars['NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY'])",
    "--build-arg", "NEXT_PUBLIC_TUGUIA_URL=$($envVars['NEXT_PUBLIC_TUGUIA_URL'])",
    "--build-arg", "NEXT_PUBLIC_TUGUIA_ANON_KEY=$($envVars['NEXT_PUBLIC_TUGUIA_ANON_KEY'])"
)

Write-Host "Construyendo imagen Docker con variables de .env..." -ForegroundColor Green
docker build --no-cache -t cerebro-sonora $buildArgs .