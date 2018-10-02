# Copyright 2018 Observational Health Data Sciences and Informatics
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#' Create the analyses details
#'
#' @details
#' This function creates files specifying the analyses that will be performed.
#'
#' @param workFolder        Name of local folder to place results; make sure to use forward slashes
#'                            (/)
#'
#' @export
#' 
#' 
#' 

createAnalysesDetails <- function(workFolder) {
   # 1) ADD MODELS you want
  modelSettingList <- list(PatientLevelPrediction::setAdaBoost(),
                           PatientLevelPrediction::setLassoLogisticRegression(),
                           PatientLevelPrediction::setGradientBoostingMachine(), 
                           PatientLevelPrediction::setDecisionTree(), 
                           PatientLevelPrediction::setNaiveBayes(),
                           PatientLevelPrediction::setRandomForest()
                           )
  
  # 2) ADD POPULATIONS you want
  pop1 <- PatientLevelPrediction::createStudyPopulationSettings(riskWindowStart = 181, 
                                        riskWindowEnd = 1825,
                                        requireTimeAtRisk = T, 
                                        minTimeAtRisk = 1644, 
                                        includeAllOutcomes = T)
  populationSettingList <- list(pop1)
  
  # 3) ADD COVARIATES settings you want
  covariateSettings1 <- FeatureExtraction::createCovariateSettings(useDemographicsGender = FALSE,
                                                                   useDemographicsAge = FALSE, 
                                                                   useDemographicsAgeGroup = FALSE,
                                                                   useDemographicsRace = FALSE, 
                                                                   useDemographicsEthnicity = FALSE,
                                                                   useDemographicsIndexYear = FALSE, 
                                                                   useDemographicsIndexMonth = FALSE,
                                                                   useDemographicsPriorObservationTime = FALSE,
                                                                   useDemographicsPostObservationTime = FALSE,
                                                                   useDemographicsTimeInCohort = FALSE,
                                                                   useDemographicsIndexYearMonth = FALSE,
                                                                   useConditionOccurrenceLongTerm = TRUE,
                                                                   useDrugExposureLongTerm = TRUE, 
                                                                   useProcedureOccurrenceLongTerm = TRUE,
                                                                   useMeasurementLongTerm = TRUE, 
                                                                   useMeasurementValueLongTerm = TRUE,
                                                                   useObservationLongTerm = TRUE, 
                                                                   useCharlsonIndex = FALSE, 
                                                                   useDcsi = FALSE, 
                                                                   useChads2 = FALSE,
                                                                   useChads2Vasc = FALSE, 
                                                                   longTermStartDays = -3650,
                                                                   mediumTermStartDays = -180, shortTermStartDays = -30, endDays = 180,
                                                                   includedCovariateConceptIds = c(), addDescendantsToInclude = FALSE,
                                                                   excludedCovariateConceptIds = c(), addDescendantsToExclude = FALSE,
                                                                   includedCovariateIds = c())
  
  covariateSettingList <- list(covariateSettings1) 
  # ADD COHORTS
  cohortIds <- c(873)  # add all your Target cohorts here
  outcomeIds <- c(756)   # add all your outcome cohorts here
  
  # this will then generate and save the json specification for the analysis
  PatientLevelPrediction::savePredictionAnalysisList(workFolder=workFolder,
                                                     cohortIds,
                                                     outcomeIds,
                                                     cohortSettingCsv =file.path(workFolder, 'CohortsToCreate.csv'), 
                                                     covariateSettingList,
                                                     populationSettingList,
                                                     modelSettingList,
                                                     maxSampleSize= NULL,
                                                     washoutPeriod=0,
                                                     minCovariateFraction=0.001,
                                                     normalizeData=T,
                                                     testSplit='person',
                                                     testFraction=0.3,
                                                     splitSeed=1,
                                                     nfold=2,
                                                     verbosity="INFO")
  }
