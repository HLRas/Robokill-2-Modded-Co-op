# Rebuilds "Robokill 2 (Co-op).exe" from src/scripts.
#   powershell -ExecutionPolicy Bypass -File build\build.ps1
# Needs Java 11+ on PATH. FFDec and the Flash Player 32 projector are downloaded into tools/ (git-ignored).
$ErrorActionPreference = 'Stop'
$root  = Split-Path -Parent $PSScriptRoot
$tools = Join-Path $root 'tools'
$out   = Join-Path $root 'out'
$ffdecUrl     = 'https://github.com/jindrapetrik/jpexs-decompiler/releases/download/version26.3.0/ffdec_26.3.0.zip'
$projectorUrl = 'https://fpdownload.macromedia.com/pub/flashplayer/updaters/32/flashplayer_32_sa.exe'

New-Item -ItemType Directory -Force $tools, $out | Out-Null
$ffdec = Join-Path $tools 'ffdec\ffdec.jar'
if (-not (Test-Path $ffdec)) {
  Write-Host 'Downloading FFDec...'
  $zip = Join-Path $tools 'ffdec.zip'
  Invoke-WebRequest $ffdecUrl -OutFile $zip -UseBasicParsing
  Expand-Archive $zip (Join-Path $tools 'ffdec') -Force
  Remove-Item $zip
}
$projector = Join-Path $tools 'flashplayer_32_sa.exe'
if (-not (Test-Path $projector)) {
  Write-Host 'Downloading Flash Player 32 projector...'
  Invoke-WebRequest $projectorUrl -OutFile $projector -UseBasicParsing
}
if ((Get-AuthenticodeSignature $projector).Status -ne 'Valid') { throw "$projector is not validly signed" }

# Stage only the modified classes and compile them into the original SWF.
$stage = Join-Path $out 'stage\scripts'
if (Test-Path (Join-Path $out 'stage')) { Remove-Item (Join-Path $out 'stage') -Recurse -Force }
$classes = Get-Content (Join-Path $PSScriptRoot 'modified-classes.txt') | Where-Object { $_ -and -not $_.StartsWith('#') }
foreach ($c in $classes) {
  $dest = Join-Path $stage $c
  New-Item -ItemType Directory -Force (Split-Path $dest) | Out-Null
  Copy-Item (Join-Path $root "src\scripts\$c") $dest
}
$swf = Join-Path $out 'Robokill2_coop.swf'
if (Test-Path $swf) { Remove-Item $swf }
Write-Host "Compiling $($classes.Count) classes..."
& java -jar $ffdec -importScript (Join-Path $root 'original\Robokill2.swf') $swf $stage
if (-not (Test-Path $swf)) { throw 'FFDec did not produce a SWF (see errors above)' }

# SWF version 21 is needed for controller (GameInput) support; then append it to the projector.
$swfBytes = [System.IO.File]::ReadAllBytes($swf)
$swfBytes[3] = 21
$proj = [System.IO.File]::ReadAllBytes($projector)
# Projector trailer: magic 0xFA123456 then the SWF length, both little-endian.
$trailer = [byte[]](@(0x56, 0x34, 0x12, 0xFA) + [BitConverter]::GetBytes([int32]$swfBytes.Length))
$exe = Join-Path $root 'Robokill 2 (Co-op).exe'
$fs = [System.IO.File]::Create($exe)
$fs.Write($proj, 0, $proj.Length); $fs.Write($swfBytes, 0, $swfBytes.Length); $fs.Write($trailer, 0, $trailer.Length)
$fs.Close()
Write-Host "Built $exe"
