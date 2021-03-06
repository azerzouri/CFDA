<#
Compare-Recordsets.ps1
Created by :Aziz
Runs recordset returning SQL on two instances 
and compares the output.


usage

Set-location d:\tmp  ### This is the location of the ps1 script
cls
.\Compare-Recordsets.ps1 -Instance1 "MHT04SQLMIG\MIG3" `
			            -Instance2 "opsdw" `
                        -OutputFolder "D:\tmp\Output\" ` #resultseroutputfolder
                        -Prefix1 "USE RIAPPLDB; `r" `
                        -Prefix2 "USE Prod_RIAPPLDB; `r";
#>



# Parms
	Param
		(
			[String] $Instance1,
			[String] $Instance2,
			[String] $Prefix1,			
			[String] $Prefix2,	
			[String] $OutputFolder
		)
	If ($OutputFolder -eq "") {$OutputFolder = "C:\Temp\"}
   
# Setup
	$SQL = '--SELECT
    --				INT_ERROR_CODE,
    --				INT_ERROR_DESC,
    --				COUNT(SOURCE_SEQ_NUM) as ''Occurrences'',
    --				ERR_SEVERITY
    --			FROM
    --				RI.RIVERRSRC WITH (NOLOCK)
    --			WHERE
    --				EXTERNAL_SEQ_NO = (SELECT MAX(EXTERNAL_SEQ_NO) AS EXTERNAL_SEQ_NO 
    --				FROM [RI].[RIVPROCS] 
    --				WHERE [PROCESS_GROUP] = ''DIM''
    --				AND PROCESS_CODE = 9999)
    --				AND INT_ERROR_CODE <> 841
    --			GROUP BY
    --				INT_ERROR_CODE,
    --				INT_ERROR_DESC,
    --				ERR_SEVERI
			SELECT
				a.EXTERNAL_SEQ_NO,
				a.SOURCE_SEQ_NUM,
				a.INT_ERROR_CODE,
				a.INT_ERROR_DESC,
				a.ERR_SEVERITY,
				b.DATA_SOURCE,
				b.COMPANY_CODE,
				b.POLICY_NO,
				b.OBJECT_ID,
				b.TRAN_NO,
				b.DOCUMENT_TYPE,
				b.CLAIM_ID,
				b.SUB_CLAIM_ID,
				b.ACCOUNTING_MONTH,
				d.ACCOUNTING_ITEM,
				d.ACOUNTING_AMOUNT
			FROM
				RI.RIVERRSRC a WITH (NOLOCK)
				JOIN RI.RISRCINTRF b ON a.SOURCE_SEQ_NUM = b.SOURCE_SEQ_NUM
				LEFT JOIN RI.RISAITMINT d ON a.SOURCE_SEQ_NUM = d.SOURCE_SEQ_NUM
			WHERE
				a.EXTERNAL_SEQ_NO = (SELECT MAX(EXTERNAL_SEQ_NO) AS EXTERNAL_SEQ_NO 
				FROM [RI].[RIVPROCS] 
				WHERE [PROCESS_GROUP] = ''DIM''
				AND PROCESS_CODE = 9999)
				AND INT_ERROR_CODE <> 841'
	$LoopCnt = 1
        
    $Inst1NoSlash = $Instance1 -creplace "\\", "-"    
    $Inst2NoSlash = $Instance2 -creplace "\\", "-"

    $s = "ComparisonReport_"+$Inst1NoSlash+"_"+$Inst2NoSlash+".txt"
    
    $OutFile1 = $OutputFolder+"OutputFile1_"+$Inst1NoSlash+".csv"
    $OutFile2 = $OutputFolder+"OutputFile2_"+$Inst2NoSlash+".csv"
    $ComparisonRpt = $OutputFolder+"ComparisonReport_"+$Inst1NoSlash+"_"+$Inst2NoSlash+".txt"

# Create folder if it doesn't exist
    If ((Test-Path $OutputFolder) -eq $false) {New-Item -path $OutputFolder -type directory}
    
# Connect and run a command using SQL Native Client, Returns a recordset

While ($LoopCnt -le 2)
	{
		# Create and open a database connection
			If ($LoopCnt -eq 1) {$connstr = "server="+$Instance1+";database=master;Integrated Security=sspi"}
			Else {$connstr = "server="+$Instance2+";database=master;Integrated Security=sspi"}
    		$sqlConnection = new-object System.Data.SqlClient.SqlConnection $connstr
    		$sqlConnection.Open()

		# Create a command object
    		$sqlCommand = $sqlConnection.CreateCommand()
 			If ($LoopCnt -eq 1) {$sqlCommand.CommandText = $Prefix1 + $SQL} 
			Else {$sqlCommand.CommandText = $Prefix2 + $SQL}
            
		# Execute the Command
    		$sqlReader = $sqlCommand.ExecuteReader() 
	
		# Parse the records.  Get each column value in each row and build a csv string.  
		# Don't put a comma at the end of the row.  Run this loop for eact instance.
    		$i = 0
			$j = 0
			$Output = ""
    		$colcnt = $sqlReader.FieldCount
    		If ($LoopCnt -eq 1) {$str = $Instance1 + "`n<="}
			Else {$str = $Instance2 + "`n=>"}
			
		#Write Field Names		
			While ($j -lt $colcnt)
           		{
               		If (($colcnt - $j) -gt 1)
						{$str = $str + $sqlReader.GetName($j) + ","}
					Else
						{$str = $str + $sqlReader.GetName($j)}
               		$j = $j + 1
    			}
					$str = $str + "`n"
               		$j = 0
			
		#Write Data
			while ($sqlReader.Read()) 
        		{
            		while ($i -lt $colcnt)
                		{
                    		If (($colcnt - $i) -gt 1)
								{$str = $str + $sqlReader[$i] + ","}
							Else
								{$str = $str + $sqlReader[$i]}
                    		$i = $i + 1
    					}
                		$i = 0
					$Output = $Output + $str + "`n"
					#If ($LoopCnt -eq 1) {$Output = $Output + $str + "`n"}
					#Else {$Output = $Output + $str + "`n"}
					$str = ""
        		}
		
		# Write the recordset to a .csv file.
    		If ($LoopCnt -eq 1) {$Output | out-file $OutFile1}
			Else {$Output | out-file $OutFile2}
      
		# Close the database connection
    		$sqlConnection.Close()
		
		# Increment $LoopCnt
			$LoopCnt = $LoopCnt + 1
	}
		
# Compare the files
    Compare-Object -ReferenceObject $(Get-Content $OutFile1) `
                   -DifferenceObject $(Get-Content $OutFile2) `
                   | Format-Table -auto |out-file $ComparisonRpt
    
# check to see if comparison resulting file has any data   
if (-not ((Get-Content $OutputFolder$s | Select-Object -Index 5) -match '\S'))
{
    $return = 0
    return $return
    
}
else {
    $return = -1
    return $return
}
 
 
 