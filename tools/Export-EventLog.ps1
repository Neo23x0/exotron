[CmdletBinding()]
 Param
     (
     $LogName,
     $Destination
     )
Begin
{
    $el = Get-WinEvent -LogName $LogName
    $el | export-csv $Destination
}
End
{
}