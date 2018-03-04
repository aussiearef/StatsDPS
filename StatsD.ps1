param(
[String] $address,
[String] $dataGram
)

$ipAddresses = [System.Net.Dns]::GetHostAddresses($address.Trim());
$ipAddress=$ipAddresses[0];

$endPoint = New-Object System.Net.IPEndPoint($ipAddress, 8125);
$udpClient = New-Object System.Net.Sockets.UdpClient;

$encodedData=[System.Text.Encoding]::ASCII.Getbytes($dataGram);
$udpClient.Send($encodedData, $encodedData.Length, $endPoint);
$udpClient.Close();

