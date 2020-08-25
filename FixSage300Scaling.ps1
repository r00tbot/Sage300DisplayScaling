# Get executables in Sage local install folder
$modulePaths = Get-ChildItem "C:\Program Files (x86)\Timberline Office\Shared\" -Filter *.exe | Select-Object -ExpandProperty Name

# Scaling registry key for all users
$regPath = "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"

# Create scaling key if it does not exist
if (-Not (Test-Path $regPath)) {New-Item -Path $regPath}

# Create registry properties if they do not exist
if (-Not (Get-ItemProperty -Path $regPath -Name $modulePaths[0] -ErrorAction SilentlyContinue)) {
    foreach ($path in $modulePaths) {New-ItemProperty -Path $regPath -Name $path -Value ""}
}

# Get current DPI scaling setting
$currentSetting = Get-ItemProperty -Path $regPath -Name $modulePaths[0] | Select-Object -ExpandProperty $modulePaths[0]

# Toggle scaling setting
if ($currentSetting -eq "~ HIGHDPIAWARE") {$newSetting = ""} else {$newSetting = "~ HIGHDPIAWARE"}

# Apply scaling setting to every executable
foreach ($path in $modulePaths) {Set-ItemProperty -Path $regPath -Name $path -Value $newSetting}
