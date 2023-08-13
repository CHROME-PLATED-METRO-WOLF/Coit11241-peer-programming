

function testInternetAccess()
{
    #invoke-webRequest sends a web request and returnes the response
    #can use -UseBasicParsing | Select-Object StatusCode to display its status code 200 means OK
    #I used the website ipinfo.io/ip to check internet connection, it is a simple service that returns
    #the ip address of the request and has high avaliability
    try{
    $webResponse = Invoke-WebRequest -Uri https://ipinfo.io/ip 
    }catch
    {
    #catch and do nothing, if a error happens it means internet is not working and therefore should return false, prevents ugly error messages in console when there is no internet
    }
    #checks the response for the flag StatusCode and if its equal to 200 returns internet connection successfull
    if($webResponse.StatusCode -eq 200)
    {
     
        return $true, $webResponse.content;
    }else
    {
        #if any other response assumes the internet is down and will attempt to communicate with a alternate server
        #to check if the server is down or if the internet is definitly down.
        try
        {
        $webResponse = Invoke-WebRequest -Uri www.google.com
        }catch
        {
        #catch and do nothing, if a error happens it means internet is not working and therefore should return false, prevents ugly error messages in console when there is no internet
        }
        if($webResponse.StatusCode -eq 200)
        {    
            #second connection sucsessful
            return $true
        }else
        {
            #second connection failed
            return $false
        }
    }
    return $false;
}

function enableRestrictInternet()
{
    #sets proxy server to http://proxy which doesnt exist and enables it effectively blocking internet
    [System.Net.HttpWebRequest]::DefaultWebProxy = New-Object System.Net.WebProxy("http://proxy",$true)
}

function resetRestrictInternet()
{
    #sets proxy server to null removing the proxy and allowing internet
    [System.Net.HttpWebRequest]::DefaultWebProxy = New-Object System.Net.WebProxy($null)
}





#check command line for passed in arguments if they equal testInternetAccess or enableRestrictInternet or resetRestrictInternet run coresponding function
if($args[0] -eq "testInternetAccess")
{
    Write-Output "testing internet access"
    #run testInternetAccess function
    if(testInternetAccess)
    {
        Write-Output "Web response 200 iternet connection successful"
    }else
    {
        Write-Output "Web request failed no internet connection"
    }
}elseIf($args[0] -eq "enableRestrictInternet")
{
    Write-Output "restricting internet access"
    enableRestrictInternet
    if(testInternetAccess)
    {
        Write-Output "error: Web response 200 internet still avaliable"
        Write-Output "please contact your administrator"
    }else
    {
        Write-Output "success: no internet connection"
    }
}elseIf($args[0] )
{
    Write-Output "re-enabling internet"
    resetRestrictInternet
    if(testInternetAccess -eq $true)
    {
        Write-Output "success: Web response 200 iternet connection successful"
    }else
    {
        Write-Output "Web request failed no internet connection"
    }
}else
{
    Write-Output "Please enter a valid option: testInternetAccess or enableRestrictInternet or resetRestrictInternet"
}