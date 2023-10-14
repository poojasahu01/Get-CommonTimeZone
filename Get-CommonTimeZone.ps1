#1. Name the function Get-CommonTimeZonefunction  Get-CommonTimeZone{    #You should not be able to supply both input parameters ('Name' and 'Offset') simultaneously    param(    [Parameter(Mandatory=$False, ParameterSetName="Name")]    [string]$Name,    [Parameter(Mandatory=$False, ParameterSetName="Offset")]    [ValidateRange(-12, 13)]     [int]$Offset    )    $ErrorActionPreference = "Stop"    try{        [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12        #2.The function should download a list of all commonly used time zones in JSON format from Github        $url = 'https://raw.githubusercontent.com/dmfilipenko/timezones.json/master/timezones.json'

        $json = (New-Object System.Net.WebClient).DownloadString($url) 

        #3.By default, the function should parse information from the above JSON and return all time zones
        $data = $json | ConvertFrom-Json                }catch {
        $_.Exception
    }    #4.'Name' - if specified, it will return only time zones that have the specified string in their name    if ($Name -like '*Asia*'){        $data.where{$_.Value -match 'Asia'} | select value, abbr, offset, isdst, text, utc | Format-Table
    }

    if ($Name -like '*Africa*'){
        $data.where{$_.Value -match 'Africa'} | select value, abbr, offset,isdst, text, utc | Format-Table
    }

    if ($Name -like '*Europe*'){
        $data.where{$_.Value -match 'Europe'} | select value, abbr, offset, isdst, text, utc | Format-Table
    }

    if ($Name -like '*America*'){
        $data.where{$_.Value -match 'America'} | select value, abbr, offset, isdst, text, utc | Format-Table
    }

    if ($Name -like '*Australia*'){
        $data.where{$_.Value -match 'Australia'} | select value, abbr, offset, isdst, text, utc | Format-Table
    }

    if ($Name -like '*Antarctica*'){
        $data.where{$_.Value -match 'Antarctica'} | select value, abbr, offset, isdst, text, utc | Format-Table
    }


    #5. 'Offset' - if specified, function will return only the time zones with that offset. The function should validate that the provided offset is valid, i.e. between -12 and 12
    if ($Offset){
        $data.where{$_.offset -match $Offset} | select value, abbr, offset, isdst, text, utc | Format-Table
     }

   } 