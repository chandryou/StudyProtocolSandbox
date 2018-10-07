A Package for Short-term mortality prediction Studies
========================================================

Instructions 
===================

  library('ShortTermMortalityPrediction')
  connectionDetails <- DatabaseConnector::createConnectionDetails(dbms = 'my dbms e.g., sql server',
                                                                server = 'my server',
                                                                user = 'my username',
                                                                password = 'not telling',
                                                                port = 'port number')
execute(connectionDetails = connectionDetails,
                    cdmDatabaseSchema = 'your cdm schema',
                    cohortDatabaseSchema = 'your cohort schema',
                    cohortTable = "cohort",
                    outcomeDatabaseSchema = 'your cohort schema',
                    outcomeTable = "cohort",
                    oracleTempSchema = cohortDatabaseSchema,
                    outputFolder = 'my study results',
                    createCohorts = TRUE,
                    packageResults = TRUE,
                    minCellCount= 5,
                    packageName="ShortTermMortalityPrediction")
```
- Step 7: You can then easily transport these results into a network study package by copying this package https://github.com/OHDSI/StudyProtocolSandbox/tree/master/PredictionNetworkStudySkeleton and running:
  ```r
  code to come soon
```


# Development status

Under development. Do not use
