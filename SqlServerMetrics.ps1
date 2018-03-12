param(
  [parameter(Mandatory=$false, ValueFromPipeline=$true)]
  [string]
  $ip="127.0.0.1",
  
  [parameter(Mandatory=$false, ValueFromPipeline=$true)]
  [string]
  $storedProcedure="YOUR STORED PROCEDURE NAME HERE"
)

$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = "Server=(local);Database=<YOUR DATABASE NAME>;user=<YOUR DB USER>;password=<YOUR DB PASSWORD>"
$SqlCmd = New-Object System.Data.SqlClient.SqlCommand
$SqlCmd.CommandText = $storedProcedure
$SqlCmd.Connection = $SqlConnection
$SqlCmd.CommandType = [System.Data.CommandType]::StoredProcedure;
$SqlConnection.Open()
$result = $SqlCmd.ExecuteScalar()
$SqlConnection.Close()
$metric = "<YOUR METRIC NAME HERE>"+$result.ToString()+"|g"


# USE [System.Net.Dns]::GetEntries  instead, if you use a domain name rather than an IP address.
$ipAddress=[System.Net.IPAddress]::Parse($ip) 


$endPoint=New-Object System.Net.IPEndPoint($ipAddress, $port)
$udpclient=New-Object System.Net.Sockets.UdpClient


$encodedData=[System.Text.Encoding]::ASCII.GetBytes($metric)
$bytesSent=$udpclient.Send($encodedData,$encodedData.length,$endPoint)


$udpclient.Close()