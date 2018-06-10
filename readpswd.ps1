# Read XML configuration file
[xml]$config = Get-Content "c:\tmp\pswd.xml"
 
## Use read credentials
#$sessionOptions = New-Object WinSCP.SessionOptions -Property @{
#    Protocol = [WinSCP.Protocol]::Sftp
#    HostName = "example.com"
#    UserName = $config.Configuration.UserName
#    Password = $config.Configuration.Password
#}


#echo $config.Configuration.UserName
#echo $config.Configuration.Password

$user = ConvertTo-SecureString $config.Configuration.UserName
echo $user




