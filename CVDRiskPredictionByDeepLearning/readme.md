A Package Skeleton for Patientl-Level Prediction Studies
========================================================

A skeleton package, to be used as a starting point when implementing patient-level prediction studies.

Vignette: [Using the package skeleton for patient-level prediction studies](https://raw.githubusercontent.com/OHDSI/StudyProtocolSandbox/master/CVDRiskPredictionByDeepLearning/inst/doc/UsingSkeletonPackage.pdf)

Instructions 
===================

- Step 1: Change package name, readme and description (replace (CVDRiskPredictionByDeepLearning with the package name)
- Step 2: Change all references of package name [in Main.R lines 101 and 126, CreateCohorts.R lines 27,37 and 42, CreateAllCohorts.R lines 62 and 77, readme.md and in PackageMaintenance.R]
- Step 3: Add inst/settings/CohortToCreate.csv - a csv containing three columns, cohortId, atlasId and name - the cohorts in your local atlas with the atlasId will be downloaded into the package and given the cohortId cohort_definition_id when the user creates the cohorts.
- Step 4: Create prediction analysis detail r code that specifies the models, populations, covariates, Ts and Os used in the study (extras/CreatePredictionAnalysisDetails)
- Step 5: Run package management to extract cohorts (using CohortToCreate.csv) and create json specification (using extras/CreatePredictionAnalysisDetails.R)
- Step 6: Now build the package by clicking the R studio 'Install and Restart' button in the built tab 
- Step 7: Share the package and get people to install by running but replace 'CVDRiskPredictionByDeepLearning' with your study name:
```r
  # get the latest PatientLevelPrediction
  install.packages("devtools")
  devtools::install_github("OHDSI/PatientLevelPrediction")
  # check the package
  PatientLevelPrediction::checkPlpInstallation()
  
  # install the network package
  devtools::install_github(OHDSI/CVDRiskPredictionByDeepLearning)
```

- Step 8: Get users to execute the study by running the code in (extras/CodeToRun.R) but replace 'CVDRiskPredictionByDeepLearning' with your study name:
```r
  library(CVDRiskPredictionByDeepLearning)
  # USER INPUTS
#=======================
# Specify where the temporary files (used by the ff package) will be created:
options(fftempdir = "s:/FFtemp")

# The folder where the study intermediate and result files will be written:
outputFolder <- "s:/CVDRiskPredictionByDeepLearningResults"

# Details for connecting to the server:
dbms <- "pdw"
user <- NULL
pw <- NULL
server <- Sys.getenv('server')
port <- Sys.getenv('port')

connectionDetails <- DatabaseConnector::createConnectionDetails(dbms = dbms,
                                                                server = server,
                                                                user = user,
                                                                password = pw,
                                                                port = port)

# Add the database containing the OMOP CDM data
cdmDatabaseSchema <- 'cdm_database.dbo'
# Add a database with read/write access as this is where the cohorts will be generated
cohortDatabaseSchema <- 'workdatabase.dbo'

# table name where the cohorts will be generated
cohortTable <- 'CVDRiskPredictionByDeepLearningCohort'
#=======================

execute(connectionDetails = connectionDetails,
        cdmDatabaseSchema = cdmDatabaseSchema,
        cohortDatabaseSchema = cohortDatabaseSchema,
        cohortTable = cohortTable,
        outputFolder = outputFolder,
        createCohorts = T,
        runAnalyses = T,
        packageResults = T,
        createValidationPackage = F,
        minCellCount= 5)
```
- [Still Under Development] Step 9: You can then easily transport these results into a network study package by running:
  ```r
  
  execute(connectionDetails = connectionDetails,
        cdmDatabaseSchema = cdmDatabaseSchema,
        cohortDatabaseSchema = cohortDatabaseSchema,
        cohortTable = cohortTable,
        outputFolder = outputFolder,
        createCohorts = F,
        runAnalyses = F,
        packageResults = F,
        createValidationPackage = T,
        minCellCount= 5)
  

```


# Development status
Under development. Do not use
