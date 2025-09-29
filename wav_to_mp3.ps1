# nainstalujFfmpegPokudChybi
# winget install --id Gyan.FFmpeg.Full --source winget

# overFfmpeg
if (-not (Get-Command ffmpeg -ErrorAction SilentlyContinue)) {
  Write-Error "ffmpeg nenalezen. Nainstaluj ho a spus� znovu."
  exit 1
}

# nastavAdresare
$sourceDir = Get-Location
$targetDir = Join-Path $sourceDir "mp3"

# nastavKvalituVbr
# 0 = nejvy��� kvalita, 2 = vyv�en�, 4 = men�� soubory
$quality = 2

# vytvorCilovouSlozku
New-Item -ItemType Directory -Force -Path $targetDir | Out-Null

# prevedWavNaMp3
Get-ChildItem -Path $sourceDir -Filter *.wav | ForEach-Object {
  # pripravCesty
  $inPath = $_.FullName
  $outPath = Join-Path $targetDir ($_.BaseName + ".mp3")

  # spustFfmpeg
  & ffmpeg -hide_banner -nostdin -y -i $inPath `
    -vn `
    -map_metadata 0 `
    -c:a libmp3lame -q:a $quality `
    $outPath
}
