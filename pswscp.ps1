#$OutputVariable = (Shell command) | Out-String
$here=$pwd

$WinSCPPath = 'C:\PROGRA~2\WinSCP'
Set-Location -Path $WinSCPPath
$fname="readme1.txt"
.\winscp.com /ini=nul /script=C:\Users\sevco\Dropbox\00MyDocumentsAsus\GitHub\PS\wscpget.txt  /parameter $fname
Set-Location -Path $here