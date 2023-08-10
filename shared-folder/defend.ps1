function testInternetAccess()
{

Invoke-WebRequest -Uri https://ipinfo.io/ip -UseBasicParsing | Select-Object StatusCode
}

#run testInternetAccess function
testInternetAccess