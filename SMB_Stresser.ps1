Import-Module BitsTransfer

############# STRESS CONFIGURATION #############

$ParallelJobs = 30                # Parallel jobs count
$JobSleepTime = 0                 # Time in seconds between jobs (0 for no delay)

########### END STRESS CONFIGURATION ###########


############  START JOBS INSTANCES  ############


For($i = 1; $i -le $ParallelJobs; $i++){
    Start-Job -Name "Job $i" -ScriptBlock $runJob | Out-Null
    Write-Host "Trabajo $i/$ParallelJobs iniciado" -ForegroundColor Green
    Start-Sleep -s $JobSleepTime
}


###################  RUN JOB  ###################

$runJob = {


    ############### JOB CONFIGURATION ###############

    $TempFolder = "C:\Users\Administrador\Desktop\tmp"               # Stress TMP copy folder (It auto-delete on finish job)
    $DestPath = "S:"                                                 # Stress destination folder
    $RandomFilesPerJob = 10                                          # Random files to create per job

    ############# END JOB CONFIGURATION #############


    #Create destination folder if not already exists
    $Path = Get-Item -Path $DestPath -Force -ErrorAction SilentlyContinue
    if ($Path.Exists -ne $true)
        {
            Write-Host "Create directory $DestPath"
            New-Item -Path $DestPath -ItemType directory -Force -ErrorAction SilentlyContinue | Out-Null
        }

    #Create temporal folder if not ae.
    If(!(test-path $TempFolder)){ New-Item -ItemType Directory -Force -Path $TempFolder }

    #Create temporal folder with junk random files
    $tempFolderName = -join ((65..90) + (97..122) | Get-Random -Count 30 | % {[char]$_})
    #md $TempFolder+$tempFolderName
    If ($tempFolderName.Exists -ne $true){
            New-Item -path "$DestPath\$tempFolderName" -ItemType directory -Force -ErrorAction SilentlyContinue | Out-Null

            #Create random files for job
            for($i=0; $RandomFilesPerJob -ne $i; $i++){

                $tempFileName = -join ((65..90) + (97..122) | Get-Random -Count 30 | % {[char]$_})

                #Create random file size
                $randomFileSize = (-join ((1..9) | Get-Random -Count 3))
                $randomFileSize = $randomFileSize -as [int]
                Switch ((-join ((1..4) | Get-Random -Count 1)))
                {
                    1 {$multiplier = 10000000}
                    2 {$multiplier = 1000000}
                    3 {$multiplier = 100000}
                    4 {$multiplier = 10000}
                }
                $randomFileSize = $randomFileSize * $multiplier

                #Create random file and copy it to destpath
                $TMP_fileRandom = "$TempFolder\$tempFolderName\$tempFileName"
                md -Force "$TempFolder\$tempFolderName" | Out-Null
                fsutil file createnew $TMP_fileRandom $randomFileSize
           
                Start-BitsTransfer -Source $TMP_fileRandom -Destination "$DestPath\$tempFolderName" -Description "Job $job - File $i/$RandomFilesPerJob" -DisplayName "Job $job - File $i/$RandomFilesPerJob"
                $duplicateFile = $TMP_fileRandom + "5"
                Start-BitsTransfer -Source "$DestPath\$tempFolderName\$tempFileName" -Destination $duplicateFile -Description "Job2 $job - File $i/$RandomFilesPerJob" -DisplayName "Job2 $job - File $i/$RandomFilesPerJob"


                #Remove temp file
                Remove-Item $TMP_fileRandom

                #Wait random time for new file
                if((Get-Random -Maximum 4) -ne 0){
                    $randomSleep = [uint32](Get-Random -Minimum 200 -Maximum 4000)
                    Start-Sleep -Milliseconds ($randomSleep)
                }
            }
    }
    
    #Remove temp files and folders for this job
    Remove-Item "$TempFolder\$tempFolderName" -Recurse
    Remove-Item "$DestPath\$tempFolderName" -Recurse

    exit

}