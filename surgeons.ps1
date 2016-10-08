$sourceUrl = "http://njrsurgeonhospitalprofile.org.uk/SurgeonListing/GetPageData?letter=%25"

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
$unescapeUri = "http://www.freeformatter.com/string-escaper.html"
$escapedResponse = Invoke-WebRequest -Uri $unescapeUri `
                                     -Method Post `
                                     -Body $body `
                                     -ContentType "multipart/form-data; boundary=----WebKitFormBoundaryAoNdfgM0uhQhLVtH"
                                    
$psObject = $escapedResponse.ParsedHtml.getElementsByTagName('textarea')[1].Value | ConvertFrom-Json
$psObject | Export-Csv 'C:\src\surgeons\surgeons.csv' -NoTypeInformation