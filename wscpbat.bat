open sftp://demo:password@test.rebex.net/ -hostkey=*
# Get file
get %1% c:\tmp\
close
# Exit WinSCP
exit