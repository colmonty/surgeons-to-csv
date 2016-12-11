$sourceUrl = "http://njrsurgeonhospitalprofile.org.uk/SurgeonListing/GetPageData?letter=%25"
$destinationFilePath = $PSScriptRoot + "\surgeons.csv"
Write-Host $destinationFilePath

Write-Host "Getting source content..."
$rawContent = (Invoke-WebRequest -Uri $sourceUrl).Content
$trimmedContent = $rawContent.TrimStart('"').TrimEnd('"')

$template = @'
------WebKitFormBoundaryAoNdfgM0uhQhLVtH
Content-Disposition: form-data; name="action"

unescape
------WebKitFormBoundaryAoNdfgM0uhQhLVtH
Content-Disposition: form-data; name="target"

javascript
------WebKitFormBoundaryAoNdfgM0uhQhLVtH
Content-Disposition: form-data; name="inputString"

{0}
------WebKitFormBoundaryAoNdfgM0uhQhLVtH--
'@

$body = $template -F $trimmedContent
$unescapeUri = "http://www.freeformatter.com/javascript-escape.html"
Write-Host "Sending unquoted content to be un-escaped..."
$escapedResponse = Invoke-WebRequest -Uri $unescapeUri `
                                     -Method Post `
                                     -Body $body `
                                     -ContentType "multipart/form-data; boundary=----WebKitFormBoundaryAoNdfgM0uhQhLVtH"

Write-Host "Parsing the content, converting to CSV and saving..."                               
$psObject = $escapedResponse.ParsedHtml.getElementsByTagName('textarea')[1].Value | ConvertFrom-Json
$psObject | Export-Csv $destinationFilePath -NoTypeInformation
Write-Host "Complete!  File surgeons.csv saved to disk"