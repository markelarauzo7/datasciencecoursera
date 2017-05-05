best <- function(state, outcome) {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  outcome_data <- read.csv("outcome-of-care-measures.csv")
  state_codes <- levels(outcome_data[,"State"])
  disease_list <- c("heart attack","heart failure","pneumonia")
  
  ## Check if introduced state abbreviation exists
  if(state %in% state_codes ){
    ## Check if introduced outcome exists
    outcome_data <- outcome_data[outcome_data[,"State"] == state,]
    if(outcome %in% disease_list){
      if(outcome == 'heart attack'){
        print('Entro a heart attack')  
        ## "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
        chosen_death_rate <- outcome_data[,c(2,11)]
      }else if(outcome == 'heart failure'){
        ## "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
        print('Entro a heart failure')
        chosen_death_rate <- outcome_data[,c(2,17)]
      }else{
        ## "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
        print('Entro a Pneumonia')
        chosen_death_rate <-  outcome_data[,c(2,23)]
      }
      ## Output data to csv for further checking
      ## This line could be omitted    
      ## write.csv2(chosen_death_rate,file = paste(state,".csv",sep = ""),sep = ";")
      
      # Auxiliar variable
      values_dt <- chosen_death_rate
      ## Convert factor into Numeric for processing
      values_dt[,2] <- as.character(values_dt[,2])
      values_dt[,2] <- as.numeric(values_dt[,2])
      ## Removes NAs
      values_dt <- values_dt[!is.na(values_dt[,2]),] 
      best_hospitals <- values_dt[values_dt[,2] == min(values_dt[,2]),]
      
      
      ## Result
      if(nrow(best_hospitals) == 1){
        print('Entro a mostrar un hospital')
        print(best_hospitals["Hospital.Name"])
      }else{
        ordered_best_hospitals <- best_hospitals[order(best_hospitals[,1]),]
        print(ordered_best_hospitals[1,1])
      }
      
    }else{
      ## Outcome does not exist
      stop("Invalid outcome.")
    }
    
  }else{
    ## State does not exist
    stop("Invalid state.")
  }
}