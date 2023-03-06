$logFile = "C:\Users\Xavier\Desktop\StaiDBCopy\log.info"
$timeStarted = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
Add-Content $logFile "Script started execution at: $timeStarted"

$sqliteExePath = "C:\temp\DBBackup\sqlite"
Set-Location $sqliteExePath

$staiDB = "C:\Users\xavier\.stai\mainnet\db\blockchain_v2_mainnet.sqlite"
$dbFolderWithStaiDB = "C:\temp\DBBackup\TempDB\"

if (Test-Path "$dbFolderWithStaiDB\blockchain_v2_mainnet.sqlite") {
    Remove-Item -Path "$dbFolderWithStaiDB\blockchain_v2_mainnet.sqlite" -Force
}

& ".\sqlite3.exe" $staiDB "VACUUM INTO '$dbFolderWithStaiDB\blockchain_v2_mainnet.sqlite'"

$dbFileCompressed = "C:\MEGA\STAIdb\blockchain_v2_mainnet.zip"

if (Test-Path $dbFileCompressed) {
    Remove-Item -Path $dbFileCompressed -Force
}

Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::CreateFromDirectory($dbFolderWithStaiDB, $dbFileCompressed)

Remove-Item -Path "$dbFolderWithStaiDB\blockchain_v2_mainnet.sqlite" -Force

$timeFinished = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
Add-Content $logFile "Script finished execution at: $timeFinished"
