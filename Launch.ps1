$EnginePath = 'B:\Engines\lovr\build\Debug'
$ProjectPath = 'D:\Projects\Experimenting\LOVRTest'

Write-Host "Launching Project"

#Push-Location
#Set-Location $EnginePath
$WorkingPath = Join-Path $EnginePath '\lovr.exe' 
Start-Process -FilePath $WorkingPath -ArgumentList "--console", $ProjectPath, "--watch"