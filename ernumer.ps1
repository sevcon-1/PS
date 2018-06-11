    # Load WinSCP .NET assembly
    Add-Type -Path "C:\Users\sevco\Downloads\Compressed\WinSCP-5.13.2-Automation\WinSCPnet.dll"
 
    # Setup session options
    $sessionOptions = New-Object WinSCP.SessionOptions -Property @{
        Protocol = [WinSCP.Protocol]::Sftp
        HostName = "test.rebex.net"
        UserName = "demo"
        Password = "password"
        #SecurePassword = ConvertTo-SecureString $config.Configuration.Password
        #SshHostKeyFingerprint = "ssh-rsa 2048 xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx"
        SshHostKeyFingerprint = "ssh-ed25519 256 d7Te2DHmvBNSWJNBWik2KbDTjmWtYHe2bvXTMM9lVg4="
    }
 
    $session = New-Object WinSCP.Session
        # Connect
        $session.Open($sessionOptions)


$remotePath = "/"
$localPath = "C:\tmp\gets"
 
$files = $session.EnumerateRemoteFiles($remotePath, "*.txt", [WinSCP.EnumerationOptions]::None)
foreach ($fileInfo in $files)
{
    # Resolve actual file name by removing the .done extension
    $remoteFilePath = $fileInfo.FullName -replace ".done$", ""
    Write-Host $remoteFilePath
    Write-Host "Downloading $remoteFilePath ..."
    # Download and delete
    $session.GetFiles(
        [WinSCP.RemotePath]::EscapeFileMask($remoteFilePath), $localPath + "\*", $False).Check() 
    # Delete ".done" file
    #$session.RemoveFiles([WinSCP.RemotePath]::EscapeFileMask($fileInfo.FullName)).Check()
}

