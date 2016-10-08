# Surgeons To CSV

Surgeon data source: http://njrsurgeonhospitalprofile.org.uk/SurgeonListing/GetPageData?letter=%25

Unfortunately this data is in a JavaScript-escaped, quoted string of JSON.     
As a result, converting the data into CSV format isn't as easy as it should be.   
Just to make matters more difficult, PowerShell doesn't include in-built or even reference-able libraries to JavaScript unescape the string.   
As a result, we have to use a crappy online formatter which is not meant to be consumed like an API, from a script.

## Instructions:
1. Click on the `surgeons.ps1` file
2. To the top right of the code/script, right click the `Raw` button
3. Select `Save as` and ensure it keeps its original name and especially the `ps1` extension - `surgeons.ps1`
4. Press the Windows key, type 'PowerShell' and *right* click 'PowerShell' (might be 'Windows PowerShell', depending on your system)
5. Select `Run as Administrator` and confirm the prompts
6. The PowerShell 'command line' will eppear.
7. Enter the command 
```
Set-ExecutionPolicy -ExecutionPolicy Unrestricted
```
8. Use the `cd` command to Change Directory to wherever you saved the `surgeons.ps1` file in step 3, above.
For example:
```
cd c:\users\colin\documents
```
If you prefer, you can navigate one step at a time, as below:
```
cd c:\
cd users
cd colin
cd documents
```
9. Type `ls` to list the contents of the current directory - check that `surgeons.ps1` is there.
10. Type:
```
.\surgeons.ps1
```
This will run the script, which should, depending on your Internet connection speed, take about 10 seconds.
11. Open the folder by typing:
```
explorer .
```
12. You should see the file `surgeons.csv` in the folder - open it with Excel and do with it as you please.