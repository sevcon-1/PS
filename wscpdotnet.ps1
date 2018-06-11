param (
    $localPath = "c:\tmp\gets\",
    $remotePath = "/",
    $fileName = "readme.txt"
)
   
# Read XML configuration file
[xml]$config = Get-Content "c:\tmp\pswd.xml"
 
#echo $config.Configuration.UserName
#echo $config.Configuration.Password

$user = ConvertTo-SecureString $config.Configuration.UserName
echo $user

try
{
    # Load WinSCP .NET assembly
    Add-Type -Path "C:\Users\sevco\Downloads\Compressed\WinSCP-5.13.2-Automation\WinSCPnet.dll"
 
    # Setup session options
    $sessionOptions = New-Object WinSCP.SessionOptions -Property @{
        Protocol = [WinSCP.Protocol]::Sftp
        HostName = "test.rebex.net"
        UserName = "demo"
        #Password = "password"
        SecurePassword = ConvertTo-SecureString $config.Configuration.Password
        #SshHostKeyFingerprint = "ssh-rsa 2048 xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx"
        SshHostKeyFingerprint = "ssh-ed25519 256 d7Te2DHmvBNSWJNBWik2KbDTjmWtYHe2bvXTMM9lVg4="
    }
 
    $session = New-Object WinSCP.Session
 
    try
    {
        # Connect
        $session.Open($sessionOptions)
 
        # Format timestamp
        $stamp = $(Get-Date -Format "yyyyMMddHHmmss")
 
        # Download the file and throw on any error
        $session.GetFiles(
            ($remotePath + $fileName),
            ($localPath + $fileName + "." + $stamp)).Check()
    }
    finally
    {
        # Disconnect, clean up
        $session.Dispose()
    }
 
    exit 0
}
catch
{
    Write-Host "Error: $($_.Exception.Message)"
    exit 1
}