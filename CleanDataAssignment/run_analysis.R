rm(list=ls())
library('dplyr')

## Download file
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","data.zip")
unzip("data.zip")

if(file.exists("UCI HAR dataset")){
  
  ## Change working directory to unzipped directory 
  setwd(paste(getwd(),"UCI HAR dataset/", sep="/"))
  root_dir <- getwd()    
  
  ## Activity classes
  activity_labels_df <- read.table("activity_labels.txt",sep = " ")
  ## Features
  features_df <- read.table("features.txt", sep = " ")
  
  ## -----------------------------------------------------------------------------------
  ## Process TEST directory data
  setwd(paste(getwd(),"test",sep="/"))
  subject_test_df <- read.table("subject_test.txt")
  Y_test_df <- read.table("y_test.txt")
  X_test_df <- read.table("X_test.txt")
  
  ## Merging process
  df_test <- merge(Y_test_df,activity_labels_df,by.x = "V1",by.y = "V1", sort = FALSE)
  ## Add colum names after every merge process
  df_test <- rename(df_test,Act_class_no = V1, Act_class_name = V2)
  
  ## Subject test_processing
  df_test <- mutate(df_test,Subject_no = subject_test_df[,1])
  
  ## Reordern columns for better data presentation
  df_test <- select(df_test,c(3,2,1))    
  
  ## X_test processing
  features_test <- features_df[,2]
  features_test <- as.character(features_test)
  names(X_test_df) <- features_test
  X_test_df$id <- 1:nrow(X_test_df)
  
  df_test$id <- 1:nrow(df_test)
  df_test <- merge(df_test,X_test_df,x.by = "id",y.by = "id")
  
  ##Inertial signals processing
  setwd(paste(getwd(),"Inertial Signals",sep="/"))
  
  ## Get Inertial Signals Data
  body_acc_x_test_df <- read.table("body_acc_x_test.txt",col.names = rep("body_acc_x_", n = 128, length.out = 128))
  body_acc_y_test_df <- read.table("body_acc_y_test.txt",col.names = rep("body_acc_y_", n = 128, length.out = 128))
  body_acc_z_test_df <- read.table("body_acc_z_test.txt",col.names = rep("body_acc_z_", n = 128, length.out = 128))
  body_gyro_x_test_df <- read.table("body_gyro_x_test.txt",col.names = rep("body_gyro_x_", n = 128, length.out = 128))
  body_gyro_y_test_df <- read.table("body_gyro_y_test.txt",col.names = rep("body_gyro_y_", n = 128, length.out = 128))
  body_gyro_z_test_df <- read.table("body_gyro_z_test.txt",col.names = rep("body_gyro_z_", n = 128, length.out = 128))
  total_acc_x_test_df <- read.table("total_acc_x_test.txt",col.names = rep("total_acc_x_", n = 128, length.out = 128))
  total_acc_y_test_df <- read.table("total_acc_y_test.txt",col.names = rep("total_acc_y_", n = 128, length.out = 128))
  total_acc_z_test_df <- read.table("total_acc_z_test.txt",col.names = rep("total_acc_z_", n = 128, length.out = 128))
  
  Inertial_signal_test_dfs <- list(body_acc_x_test_df,body_acc_y_test_df,body_acc_z_test_df,
                                   body_gyro_x_test_df,body_gyro_y_test_df,body_gyro_z_test_df,
                                   total_acc_x_test_df,total_acc_y_test_df,total_acc_z_test_df)
  
  for (i in 1:length(Inertial_signal_test_dfs)) {
    Inertial_signal_test_dfs[[i]]$id <- 1:nrow(Inertial_signal_test_dfs[[i]])
    df_test <- merge(df_test,Inertial_signal_test_dfs[[i]],x.by = 'id',y.by = 'id')
  }
  
  ## Delete useless objects and store remaining environment
  rm(features_test)
  rm(X_test_df)
  rm(Y_test_df)
  rm(subject_test_df)
  rm(Inertial_signal_test_dfs)
  rm(body_acc_x_test_df)
  rm(body_acc_y_test_df)
  rm(body_acc_z_test_df)
  rm(body_gyro_x_test_df)
  rm(body_gyro_y_test_df)
  rm(body_gyro_z_test_df)
  rm(total_acc_x_test_df)
  rm(total_acc_y_test_df)
  rm(total_acc_z_test_df)
  ##save.image(file = 'test.RData')
  setwd(root_dir)
  
  ## -------------------------------------------------------------------------
  ## Process TRAIN directory data
  setwd(paste(root_dir,"train",sep="/"))
  subject_train_df <- read.table("subject_train.txt")
  Y_train_df <- read.table("y_train.txt")
  X_train_df <- read.table("X_train.txt")
  
  ##Merging process
  df_train <- merge(Y_train_df,activity_labels_df,by.x = "V1",by.y = "V1", sort = FALSE)
  ##Add colum names after every merge process
  df_train <- rename(df_train,Act_class_no = V1, Act_class_name = V2)
  
  ##Subject test_processing
  df_train <- mutate(df_train,Subject_no = subject_train_df[,1])
  
  ## Reordern columns for better data presentation
  df_train <- select(df_train,c(3,2,1))  
  
  ##X_test processing
  features_train <- features_df[,2]
  features_train <- as.character(features_train)
  names(X_train_df) <- features_train
  X_train_df$id <- 1:nrow(X_train_df)
  
  ## Add id extra column for merging
  df_train$id <- 1:nrow(df_train)
  df_train <- merge(df_train,X_train_df,x.by = "id",y.by = "id")
  
  ##Inertial signals processing
  setwd(paste(getwd(),"Inertial Signals",sep="/"))
  
  ## Get Inertial Signals Data
  body_acc_x_train_df <- read.table("body_acc_x_train.txt",col.names = rep("body_acc_x_", n = 128, length.out = 128))
  body_acc_y_train_df <- read.table("body_acc_y_train.txt",col.names = rep("body_acc_y_", n = 128, length.out = 128))
  body_acc_z_train_df <- read.table("body_acc_z_train.txt",col.names = rep("body_acc_z_", n = 128, length.out = 128))
  body_gyro_x_train_df <- read.table("body_gyro_x_train.txt",col.names = rep("body_gyro_x_", n = 128, length.out = 128))
  body_gyro_y_train_df <- read.table("body_gyro_y_train.txt",col.names = rep("body_gyro_y_", n = 128, length.out = 128))
  body_gyro_z_train_df <- read.table("body_gyro_z_train.txt",col.names = rep("body_gyro_z_", n = 128, length.out = 128))
  total_acc_x_train_df <- read.table("total_acc_x_train.txt",col.names = rep("total_acc_x_", n = 128, length.out = 128))
  total_acc_y_train_df <- read.table("total_acc_y_train.txt",col.names = rep("total_acc_y_", n = 128, length.out = 128))
  total_acc_z_train_df <- read.table("total_acc_z_train.txt",col.names = rep("total_acc_z_", n = 128, length.out = 128))
  
  Inertial_signal_train_dfs <- list(body_acc_x_train_df,body_acc_y_train_df,body_acc_z_train_df,
                                    body_gyro_x_train_df,body_gyro_y_train_df,body_gyro_z_train_df,
                                    total_acc_x_train_df,total_acc_y_train_df,total_acc_z_train_df)
  
  for (i in 1:length(Inertial_signal_train_dfs)) {
    Inertial_signal_train_dfs[[i]]$id <- 1:nrow(Inertial_signal_train_dfs[[i]])
    df_train <- merge(df_train,Inertial_signal_train_dfs[[i]],x.by = 'id',y.by = 'id')
  }
  
  ## Delete useless objects and store remaining environment
  rm(features_train)
  rm(X_train_df)
  rm(Y_train_df)
  rm(subject_train_df)
  rm(Inertial_signal_train_dfs)
  rm(body_acc_x_train_df)
  rm(body_acc_y_train_df)
  rm(body_acc_z_train_df)
  rm(body_gyro_x_train_df)
  rm(body_gyro_y_train_df)
  rm(body_gyro_z_train_df)
  rm(total_acc_x_train_df)
  rm(total_acc_y_train_df)
  rm(total_acc_z_train_df)
  ##save.image(file = 'train.RData')
  
  ## Combine both dataframes
  final_df <- bind_rows(df_test,df_train)
  ## Reorder df by Subject number
  final_df <- arrange(final_df,Subject_no)
  
  ## Clean up the environment
  rm(df_test)
  rm(df_train)
  
  ## -------------------------------------------------------------------------
  ## Tidy Dataframe creation process
  mean_std_measurements <- grep("std|mean", features_df[,2], perl=TRUE, value=FALSE)
  list_colnames <- colnames(final_df)[4 + mean_std_measurements]
  tidy_df <- final_df[,1:4]
  for(a in 1:length(mean_std_measurements)){
    tidy_df<-cbind(tidy_df, final_df[,a + 4])
    names(tidy_df)[5:ncol(tidy_df)] <- list_colnames
  }
  tidy_df <- group_by(tidy_df,Subject_no, Act_class_name)
  tidy_df <- summarise_each(tidy_df,funs(mean),5:ncol(tidy_df))
}else{
  stop('Something went wrong during download or uncompressing.')
}
