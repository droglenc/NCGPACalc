## Use this to convert an Excel file from Jenzabar to an Excel file that
## can be modified to include course grade projections and then loaded
## into the NC_GPA_Calculator_TEMPLATE.Rmd to make a grade projection
## transcript.

library(readxl)
library(FSA)
library(dplyr)
library(xlsx)

d <- read_excel("Rodmaker, J. Course Inquiry.xlsx") %>%
  rename(AY=yr_cde,Sem=trm_cde,Course=adv_req_cde,
         Credits=credit_hrs,Grade=grade_cde,Repeated=repeat_flag) %>%
  mutate(AY=as.numeric(AY),
         Sem=mapvalues(Sem,from=c("05","10","20","30"),
                       to=c("SU","F","W","S")),
         Sem=ifelse(grepl("T",Sem),"TRANSFER",Sem),
         Grade=ifelse(Grade=="TR","S",Grade),
         Major1="",Major2="",Notes="") %>%
  select(AY,Sem,Course,Credits,Major1,Major2,Grade,Repeated,Notes) %>%
  as.data.frame() %>%
  write.xlsx("RodmakerGrades.xlsx",row.names=FALSE,showNA=FALSE)
  
