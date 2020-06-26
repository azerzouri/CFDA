param
(
    #path to json file to save the azure profile. 
    #This prevents for entering Azure login details every time script is run
    [Parameter(Mandatory=$true)]
    [string] $Env = "DEV",
    [Parameter(Mandatory=$true)]
    [bool] $runAll = $false
)

if ($Env -eq "DEV"){
   #Set environment variables
$resourceGroupName="rg_NPRD-DEV"
$dataFactoryName = "e2nprddfcf"
#ADF Pipeline to run the end to end data load from Miosoft output to Asbestos DM
if ($runAll) {
     $pipelineName= "CFDM_End_to_End_All"
 } else {
     $pipelineName= "CFDM_End_to_End_Actuals"
 } 
# $pipelineName= "Truncate_STG_DM" 
$outputFile = "D:\Powershell\Output\Output.txt"
# Connect to Azure using Active Directory Service Principal Authentication 
$passwd = Get-Content "D:\Powershell\Creds\azure_cred.properties" | ConvertTo-SecureString -AsPlainText -Force
$pscredential = New-Object System.Management.Automation.PSCredential('9f713ae4-f576-4ccb-96db-9654b2c907c1', $passwd)
Connect-AzAccount -ServicePrincipal -Credential $pscredential -Tenant e93ade6c-2138-454c-87ec-7353d64d3cbb 

}
elseif ($Env -eq "TEST"){
   #Set environment variables
$resourceGroupName="rg_TEST"
$dataFactoryName = "e2testdfcf"
#ADF Pipeline to run the end to end data load from Miosoft output to Asbestos DM
if ($runAll) {
     $pipelineName= "CFDM_End_to_End_All"
 } else {
     $pipelineName= "CFDM_End_to_End_Actuals"
 } 
# $pipelineName= "Truncate_STG_DM" 
$outputFile = "D:\Powershell\Output\Output.txt"
# Connect to Azure using Active Directory Service Principal Authentication 
$passwd = Get-Content "D:\Powershell\Creds\azure_cred_test.properties" | ConvertTo-SecureString -AsPlainText -Force
$pscredential = New-Object System.Management.Automation.PSCredential('707ce238-e059-44f2-9143-ba78b3c661e3', $passwd)
Connect-AzAccount -ServicePrincipal -Credential $pscredential -Tenant e93ade6c-2138-454c-87ec-7353d64d3cbb
}
elseif ($Env -eq "PROD"){
#Set environment variables
$resourceGroupName="rg_PROD"
$dataFactoryName = "e2proddfcf"
#ADF Pipeline to run the end to end data load from Miosoft output to Asbestos DM
if ($runAll) {
     $pipelineName= "CFDM_End_to_End_All"
 } else {
     $pipelineName= "CFDM_End_to_End_Actuals"
 } 
# $pipelineName= "Truncate_STG_DM"
#$pipelineName= "emailTest"
$outputFile = "D:\Powershell\Output\Output.txt"
# Connect to Azure using Active Directory Service Principal Authentication 
$passwd = Get-Content "D:\Powershell\Creds\AzureDevOpsPROD.properties" | ConvertTo-SecureString -AsPlainText -Force
$pscredential = New-Object System.Management.Automation.PSCredential('45ab316f-3334-4dcc-9eb2-86f8bc37282f', $passwd)
Connect-AzAccount -ServicePrincipal -Credential $pscredential -Tenant e93ade6c-2138-454c-87ec-7353d64d3cbb
}

try
{

#Run the Data Factory Pipeline
$runId = Invoke-AzDataFactoryV2Pipeline -ResourceGroupName $resourceGroupName -DataFactoryName $dataFactoryName -PipelineName $pipelineName

Write-Host $runId -ForegroundColor DarkYellow
#Checking the Status of the pipeline
while($true)
{
    $result = Get-AzDataFactoryV2PipelineRun -DataFactoryName $dataFactoryName -ResourceGroupName $resourceGroupName -PipelineRunId $runId 
    if (($result | Where-Object { $_.Status -eq "InProgress" } | Measure-Object).count -ne 0) 
        {
                Write-Host "Pipeline run status: In Progress " -foregroundcolor "Yellow"
                $pipelineName + " run status: In Progress at " + (get-date -Format MM-dd-yyyy_HH_mm_ss) -join "`r`n"` | Out-File $outputFile -Append
                Start-Sleep -Seconds 360
        }
    else 
        {
                Write-Host "Pipeline '"$pipelineName"' run finished. Result:" -foregroundcolor "Green" 
                $pipelineName + " run status: Succeded at " + (get-date -Format MM-dd-yyyy_HH_mm_ss) -join "`r`n"` | Out-File $outputFile -Append
                "Result:" -join "`r`n"` | Out-File $outputFile -Append
                $result >> $outputFile
                break
        }        
}

}
catch
{
    $problem = $true
    $errormessage = $_.Exception.Message 
}
finally
{
    if ($problem)
    {
    
        Write-Host $errorMessage
        $errorMessage -join "`r`n"` | Out-File $outputFile -Append
    }
    else
    {
        if ($result.Status -eq "Succeeded")
        {   
            'Entire process is completed' + -join "`r`n"` | Out-File $outputFile -Append
            Exit 
        }
        else
        {
            $result.Error -join "`r`n"` | Out-File $outputFile -Append 
            EXit
        }
    }
}
