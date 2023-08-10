function testInternetAccess()
{
#invoke-webRequest sends a web request and returnes the response
#can use -UseBasicParsing | Select-Object StatusCode to display its status code 200 means OK
#I used the website ipinfo.io/ip to check internet connection, it is a simple service that returns
#the ip address of the request and has high avaliability
$webResponse = Invoke-WebRequest -Uri https://ipinfo.io/ip

#checks the response for the flag StatusCode and if its equal to 200 returns internet connection successfull
if($webResponse.StatusCode -eq 200)
{
echo "Web response 200 iternet connection successful"
 
}else
{
#if any other response assumes the internet is down and will attempt to communicate with a alternate server
#to check if the server is down or if the internet is definitly down.
echo "web response returned $webRespons"
echo "web response failed attempting alternate server"
}
}

#run testInternetAccess function
testInternetAccess