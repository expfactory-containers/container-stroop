######################################
# Imports
######################################
library("jsonlite")
library("effsize")  # cohen.d
library("lsr")
library("pwr")


######################################
# Prepare expfactory Stroop data
######################################

# Set working directory
setwd("expfactory")

# Get all json data files in directory
keys <- list.files(path = ".", full.names = TRUE, recursive = TRUE)

# Make a data frame to hold the results
#   Each row will be a participant
m <- data.frame(matrix(0, ncol = 13, nrow = 0))
colnames(m) <- c("subj", 
                 "RT_pr",
                 "RT_test",
                 "RT_incong",
                 "RT_cong", 
                 "Acc_pr", 
                 "Acc_test", 
                 "Acc_incong",
                 "Acc_cong", 
                 "Attn_checks",
                 "TimeSpent",
                 "N_test",
                 "N_pr")


######################################
# Process expfactory Stroop data
######################################

# Loop through the files
for(i in 1:length(keys)) {
  
  parts <- strsplit(keys[i],"/")[[1]]
  
  # Subject identifier
  subj <- parts[2]
    
  # File is double-encoded so we need to double-decode
  d <- fromJSON(keys[i])
  d <- fromJSON(d$data)
  
  # Mean reaction time for the practice block
  #   (Note: RTs are in milliseconds)
  RT_pr <- round(mean(d[which(d$exp_stage == "practice" 
                              & d$trial_type == "poldrack-categorize" 
                              & d$rt > -1),]$rt))
  
  # Mean reaction time for the test block
  RT_test <- round(mean(d[which(d$exp_stage == "test" 
                                & d$trial_type == "poldrack-categorize" 
                                & d$rt > -1),]$rt))
  
  # Mean reaction time for the incongruent stimuli in test block
  #   excludes trials without a response (i.e., timeout)
  RT_incong <- round(mean(d[which(d$exp_stage == "test" 
                                  & d$trial_type == "poldrack-categorize" 
                                  & d$rt > -1 
                                  & d$condition == "incongruent"),]$rt))
  
  # Mean reaction time for the congruent stimuli in test block
  #   excludes trials without a response (i.e., timeout)
  RT_cong <- round(mean(d[which(d$exp_stage == "test" 
                                & d$trial_type == "poldrack-categorize" 
                                & d$rt > -1 
                                & d$condition == "congruent"),]$rt))
  
  # Accuracy in practice block
  Acc_pr <- round(length(d[which(d$exp_stage == "practice" & d$trial_type == "poldrack-categorize" & d$correct == TRUE),]$correct) / 
    length(d[which(d$exp_stage == "practice" & d$trial_type == "poldrack-categorize"),]$correct), 2)
  
  # Accuracy in test block
  Acc_test <- round(length(d[which(d$exp_stage == "test" & d$trial_type == "poldrack-categorize" & d$correct == TRUE),]$correct) / 
    length(d[which(d$exp_stage == "test" & d$trial_type == "poldrack-categorize"),]$correct), 2)
  
  # Accuracy for incongruent stimuli in test block
  Acc_incong <- round(length(d[which(d$exp_stage == "test" & d$trial_type == "poldrack-categorize" & d$condition == "incongruent" & d$correct == TRUE),]$correct) / 
    length(d[which(d$exp_stage == "test" & d$trial_type == "poldrack-categorize" & d$condition == "incongruent"),]$correct), 2)
  
  # Accuracy for congruent stimuli in test block
  Acc_cong <-round( length(d[which(d$exp_stage == "test" & d$trial_type == "poldrack-categorize" & d$condition == "congruent" & d$correct == TRUE),]$correct) / 
    length(d[which(d$exp_stage == "test" & d$trial_type == "poldrack-categorize" & d$condition == "congruent"),]$correct), 2)
  
  # Percentage of attention checks passed
  Attn_checks <- round(length(d[which(d$trial_type == "attention-check" & d$correct == TRUE),]$correct) / 
    length(d[which(d$trial_type == "attention-check"),]$correct), 2)
  
  # Time spent on the task (convert to minutes)
  TimeSpent <- round(d[NROW(d),]$time_elapsed/1000/60, 2)
  
  # Number of trials in test block
  N_test <- NROW(d[which(d$exp_stage == "test" & d$trial_type == "poldrack-categorize"),])
  
  # Number of trials in practice block
  N_pr <- NROW(d[which(d$exp_stage == "practice" & d$trial_type == "poldrack-categorize"),])
  
  m <- rbind(m, data.frame(subj, RT_pr, RT_test, RT_incong, RT_cong, Acc_pr, Acc_test, Acc_incong, Acc_cong, Attn_checks, TimeSpent, N_test, N_pr))
  
}


######################################
# Analyses
######################################

#########
# Stroop effect

# t-test (incongruent vs. congruent)
t.test(m$RT_incong, m$RT_cong, paired=TRUE)

# Effect size
cohen.d(m$RT_incong, m$RT_cong, paired=TRUE)
