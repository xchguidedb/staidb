$logFile = "C:\Users\Xavier\Desktop\StaiDBCopy\log.info"   

$timeStarted = get-date -format 'yyyy-MM-dd HH:mm:ss'

Add-Content $logFile "Script started execution at: $timeStarted"

$sqliteExePath = "C:\temp\DBBackup\sqlite"

Set-Location $sqliteExePath

$staiDB = "C:\Users\xavier\.stai\mainnet\db\blockchain_v2_mainnet.sqlite"

$dbFolderWithStaiDB = "C:\temp\DBBackup\TempDB\"

if (Test-Path $dbFolderWithStaiDB\blockchain_v2_mainnet.sqlite) {
  Remove-Item -Path $dbFolderWithStaiDB\blockchain_v2_mainnet.sqlite -Force
}

.\sqlite3.exe $staiDB "VACUUM INTO '$dbFolderWithStaiDB\blockchain_v2_mainnet.sqlite'"

$dbFileCompressed="C:\MEGA\STAI\blockchain_v2_mainnet.sqlite"

$WinRarExe = "C:\Program Files\WinRAR\winrar.exe"

$argList = @("a","-ep",  ('"'+$dbFileCompressed+'"'), ('"'+$dbFolderWithStaiDB+'"'))

if (Test-Path $dbFileCompressed) {
  Remove-Item -Path $dbFileCompressed -Force
}

Start-Process -FilePath $WinRarExe -ArgumentList $argList -NoNewWindow -Wait

Start-Sleep -Seconds 30

if (Test-Path $dbFolderWithStaiDB\blockchain_v2_mainnet.sqlite) {
  Remove-Item -Path $dbFolderWithStaiDB\blockchain_v2_mainnet.sqlite -Force
}

$timeFinished = get-date -format 'yyyy-MM-dd HH:mm:ss'

Add-Content $logFile "Script finished execution at: $timeFinished"