function testInternetAccess()
{
#invoke-webRequest sends a web request and returnes the response
#can use -UseBasicParsing | Select-Object StatusCode to display its status code 200 means OK
#I used the website ipinfo.io/ip to check internet connection, it is a simple service that returns
#the ip address of the request and has high avaliability
$webResponse = Invoke-WebRequest -Uri https://ipinfo.io/ip


if($webResponse.StatusCode -eq 200)
{
echo "Web response 200 iternet connection successful"
 
}else
{
echo "web response returned $webRespons"
echo "web response failed attempting alternate server"
}
}

#run testInternetAccess function
testInternetAccess