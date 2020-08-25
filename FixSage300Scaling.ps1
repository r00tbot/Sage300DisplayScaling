# TO DO: Dynamically find executables
$modulePaths = @(
    "C:\Program Files (x86)\Timberline Office\Shared\TS.exe",
    "C:\Program Files (x86)\Timberline Office\Shared\AB.exe",
    "C:\Program Files (x86)\Timberline Office\Shared\ap.exe",
    "C:\Program Files (x86)\Timberline Office\Shared\Ar.exe",
    "C:\Program Files (x86)\Timberline Office\Shared\BL.exe",
    "C:\Program Files (x86)\Timberline Office\Shared\CM.exe",
    "C:\Program Files (x86)\Timberline Office\Shared\CN.EXE",
    "C:\Program Files (x86)\Timberline Office\Shared\EQ.exe",
    "C:\Program Files (x86)\Timberline Office\Shared\Fs.exe",
    "C:\Program Files (x86)\Timberline Office\Shared\GL.exe",
    "C:\Program Files (x86)\Timberline Office\Shared\IA.exe",
    "C:\Program Files (x86)\Timberline Office\Shared\ID.exe",
    "C:\Program Files (x86)\Timberline Office\Shared\IV.exe",
    "C:\Program Files (x86)\Timberline Office\Shared\JC.exe",
    "C:\Program Files (x86)\Timberline Office\Shared\PJ.exe",
    "C:\Program Files (x86)\Timberline Office\Shared\pm.exe",
    "C:\Program Files (x86)\Timberline Office\Shared\PO.exe",
    "C:\Program Files (x86)\Timberline Office\Shared\Pr.exe",
    "C:\Program Files (x86)\Timberline Office\Shared\pv.exe",
    "C:\Program Files (x86)\Timberline Office\Shared\rt.exe",
    "C:\Program Files (x86)\Timberline Office\Shared\SI.exe",
    "C:\Program Files (x86)\Timberline Office\Shared\sm.exe",
    "C:\Program Files (x86)\Timberline Office\Shared\TC.exe",
    "C:\Program Files (x86)\Timberline Office\Shared\TN.exe",
    "C:\Program Files (x86)\Timberline Office\Shared\TR.exe"
)

$regPath = "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"

# Create key if it does not exist
if (-Not (Test-Path $regPath)) {New-Item -Path $regPath}

# Create registry properties if they do not exist
if (-Not (Get-ItemProperty -Path $regPath -Name $modulePaths[0] -ErrorAction SilentlyContinue)) {
    foreach ($path in $modulePaths) {New-ItemProperty -Path $regPath -Name $path -Value ""}
}

# Get current DPI scaling setting
$currentSetting = (Get-ItemProperty -Path $regPath -Name "C:\Program Files (x86)\Timberline Office\Shared\TS.exe").$modulePaths[0]

# Toggle scaling setting on and off. This setting allows the application to set scaling.
if ($currentSetting -eq "~ HIGHDPIAWARE") {newSetting = ""} else {$newSetting = "~ HIGHDPIAWARE"}

# Apply scaling setting to every executable
foreach ($path in $modulePaths) {Set-ItemProperty -Path $regPath -Name $path -Value $newSetting}
