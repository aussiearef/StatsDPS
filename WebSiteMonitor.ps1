param(
[String] $uri
)

$result = Measure-Command { Invoke-WebRequest -Uri $uri}
$responseTime= [Math]::Round($result.TotalMilliseconds);

$dataGram= "WebSites.StyleTread.ResponseTime:"+$responseTime+"|ms";

.\statsD.ps1 "graphite.learnGrafana.me" $dataGram
