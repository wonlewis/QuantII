#######################
##Lewis Won          ##
##Clean Co. Names    ##
##Quant II           ##
#10 Apr 2018         ##
#######################

##Set working directory
setwd("/home/lewiswon/Documents/MITsecond sem/Quant II/scraping/mykeyfiles")
getwd()

library(binr)
library(dplyr)
library(ggplot2)
library(tidyr)
library(stargazer)
library(Matching)
library(ebal)
library(stargazer)
library(readODS)



##compustat-----------------
compustat  <- read.csv("keycompustat.csv")
cn.compustat <- unique(as.vector(compustat$conm)) #25555
##for diagnostic purposes------------
grep("TRANSUNION", cn.compustat.2)
cn.compustat.2[23727]

##FTC-----------------------
ftc <- read.csv("ftccsv.csv")
cn.ftc <- as.vector(ftc$Description)
cn.ftc <- unique(cn.ftc) ##2828

##lobbying data with FTC as entity----------------
lobby <- read.csv("my.senate.csv")
lobby.unedited <- lobby
lobby.ftc <- dplyr::filter(lobby, grepl('Federal Trade Commission', GovernmentEntities))
cn.lobby.ftc <- as.vector(lobby.ftc$ClientName)  ##8360
cn.lobby.ftc <- unique(cn.lobby.ftc)##1238

##lobby full list-----------------------------
cn.lobby <- as.vector(lobby$ClientName)  
cn.lobby <- unique(cn.lobby)##67746

##for diagnostic purposes-----------
cn.lobby <- as.vector(lobby$ClientName)
length(unique(cn.lobby))

##lobbying data with lobbyists as entity----------
lobby.unedited$ContactFullname <- toupper(lobby.unedited$ContactFullname)
lobbyist <- dplyr::filter(lobby, grepl(paste(ftc.revolve,collapse="|"), ContactFullname))
lobbyist.ftc <- as.vector(lobbyist$ClientName)
lobbyist.ftc <- unique(lobbyist.ftc)

##clean string for cn.compustat--------------
##Capitalise
cn.compustat <- toupper(cn.compustat)
##remove punctuations
cn.compustat.1 <- gsub("[[:punct:]]", "", cn.compustat)
##replace "INCORPORATED" WITH "INC"
cn.compustat.2 <- gsub("INCORPORATED", "INC", cn.compustat.1)
##replace "CORPORATION" with "CORP"
cn.compustat.3 <- gsub("CORPORATION", "CORP", cn.compustat.2)
##replace "COMPANY" with "CO"
cn.compustat.4 <- gsub("COMPANY", "CO", cn.compustat.3)
##remove " LLC "
cn.compustat.6 <- gsub(" LLC", "", cn.compustat.4)
##remove " INC "
cn.compustat.7 <- gsub(" INC", "", cn.compustat.6)
##remove " LTD "
cn.compustat.8 <- gsub(" LTD", "", cn.compustat.7)
##remove " CORP "
cn.compustat.9 <- gsub(" CORP", "", cn.compustat.8)
##replace "GROUP" with "GRP"
cn.compustat.10 <- gsub(" GROUP", "GRP", cn.compustat.9)
##remove spaces
cn.compustat.11 <- gsub(" ", "", cn.compustat.10)
##ensure uniqueness
cn.compustat.cleaned <- unique(cn.compustat.11) ##25530

##clean string for cn.ftc-------------------
##CAPITALISE ALL ALPHABETS
cn.ftc.1 <- toupper(cn.ftc) 
##remove any names after /
cn.ftc.2 <- gsub("/.*", "", cn.ftc.1)
##remove anything after "INC."
cn.ftc.3 <- gsub("(INC.).*", "\\1", cn.ftc.2)
##remove anything after ";"
cn.ftc.4 <- gsub(";.*", "\\1", cn.ftc.3)
##remove "IN IN THE MATTER OF"
cn.ftc.5 <- gsub("IN THE MATTER OF", "", cn.ftc.4)
##remove all punctuations, including c("." "," "")
cn.ftc.6 <- gsub("[[:punct:]]", "", cn.ftc.5)
##remove anything after "ET AL" and "ET AL" itself
cn.ftc.7 <- gsub("ET AL.*", "", cn.ftc.6)
##replace "CORPORATION" with "CO"
cn.ftc.8 <- gsub("CORPORATION", "CORP", cn.ftc.7)
##replace "COMPANY" with "CO"
cn.ftc.9 <- gsub("COMPANY", "CO", cn.ftc.8)
##remove " LLC "
cn.ftc.11 <- gsub(" LLC", "", cn.ftc.9)
##remove " INC "
cn.ftc.12 <- gsub(" INC", "", cn.ftc.11)
##remove " LTD "
cn.ftc.13 <- gsub(" LTD", "", cn.ftc.12)
##remove " CORP "
cn.ftc.14 <- gsub(" CORP", "", cn.ftc.13)
##replace "GROUP" with "GRP"
cn.ftc.15 <- gsub(" GROUP", "GRP", cn.ftc.14)
##remove spaces
cn.ftc.16 <- gsub(" ", "", cn.ftc.15)
##ensure uniqueness
cn.ftc.cleaned <- unique(cn.ftc.16)##2688

##clean string for cn.lobby.ftc-------------
##CAPITALISE ALL ALPHABETS
cn.lobby.ftc.1 <- toupper(cn.lobby.ftc) 
##replace "INCORPORATED" WITH "INC"
cn.lobby.ftc.2 <- gsub("INCORPORATED", "INC", cn.lobby.ftc.1)
##replace "CORPORATION" with "CORP"
cn.lobby.ftc.3 <- gsub("CORPORATION", "CORP", cn.lobby.ftc.2)
##replace "COMPANY" with "CO"
cn.lobby.ftc.4 <- gsub("COMPANY", "CO", cn.lobby.ftc.3)
##remove all punctuations, including c("." "," "")
cn.lobby.ftc.5 <- gsub("[[:punct:]]", "", cn.lobby.ftc.4)
##remove " LLC "
cn.lobby.ftc.7 <- gsub(" LLC", "", cn.lobby.ftc.5)
##remove " INC "
cn.lobby.ftc.8 <- gsub(" INC", "", cn.lobby.ftc.7)
##remove " LTD "
cn.lobby.ftc.9 <- gsub(" LTD", "", cn.lobby.ftc.8)
##remove " CORP "
cn.lobby.ftc.10 <- gsub(" CORP", "", cn.lobby.ftc.9)
##replace "GROUP" with "GRP"
cn.lobby.ftc.11 <- gsub(" GROUP", "GRP", cn.lobby.ftc.10)
##remove spaces
cn.lobby.ftc.12 <- gsub(" ", "", cn.lobby.ftc.11)
##ensure uniqueness
cn.lobby.ftc.cleaned <- unique(cn.lobby.ftc.12)##1133


##clean string for cn.lobby-------------
##CAPITALISE ALL ALPHABETS
cn.lobby.1 <- toupper(cn.lobby) 
##replace "INCORPORATED" WITH "INC"
cn.lobby.2 <- gsub("INCORPORATED", "INC", cn.lobby.1)
##replace "CORPORATION" with "CORP"
cn.lobby.3 <- gsub("CORPORATION", "CORP", cn.lobby.2)
##replace "COMPANY" with "CO"
cn.lobby.4 <- gsub("COMPANY", "CO", cn.lobby.3)
##remove all punctuations, including c("." "," "")
cn.lobby.5 <- gsub("[[:punct:]]", "", cn.lobby.4)
##remove " LLC "
cn.lobby.7 <- gsub(" LLC", "", cn.lobby.5)
##remove " INC "
cn.lobby.8 <- gsub(" INC", "", cn.lobby.7)
##remove " LTD "
cn.lobby.9 <- gsub(" LTD", "", cn.lobby.8)
##remove " CORP "
cn.lobby.10 <- gsub(" CORP", "", cn.lobby.9)
##replace "GROUP" with "GRP"
cn.lobby.11 <- gsub(" GROUP", "GRP", cn.lobby.10)
##remove spaces
cn.lobby.12 <- gsub(" ", "", cn.lobby.11)
##ensure uniqueness
cn.lobby.cleaned <- unique(cn.lobby.12)##56635


##Begin matching tables here-----------------------------
compustat  <- read.csv("keycompustat.csv")
##remove duplicate rows
compustat <- compustat[!duplicated(compustat[c("conm","fyear")]),]
##check for duplicates
View(compustat[duplicated(compustat[c("conm", "fyear")]),])
compustat.unedited <- compustat ## 212126     24
##remove punctuations
compustat$conm <- gsub("[[:punct:]]", "", compustat$conm)
##replace "INCORPORATED" WITH "INC"
compustat$conm <- gsub("INCORPORATED", "INC", compustat$conm)
##replace "CORPORATION" with "CORP"
compustat$conm <- gsub("CORPORATION", "CORP", compustat$conm)
##replace "COMPANY" with "CO"
compustat$conm <- gsub("COMPANY", "CO", compustat$conm)
##remove " LLC "
compustat$conm <- gsub(" LLC", "", compustat$conm)
##remove " INC "
compustat$conm <- gsub(" INC", "", compustat$conm)
##remove " LTD "
compustat$conm <- gsub(" LTD", "", compustat$conm)
##remove " CORP "
compustat$conm <- gsub(" CORP", "", compustat$conm)
##replace "GROUP" with "GRP"
compustat$conm <- gsub(" GROUP", "GRP", compustat$conm)
##remove spaces
compustat$conm <- gsub(" ", "", compustat$conm)

##-------------------------------------------------

##now ready to match with lobby--------------------
##step 1: match with lobby---------------------------
##now load one compustat.ftc
cleaned.lobby <- read.csv("compustat.lobby.FULL.cleaned.csv", sep="")
##match company names: compustat with lobby
match(compustat$conm, cleaned.lobby$s1.i)
##subset by square brackets
cleaned.lobby$s2.i[match(compustat$conm, cleaned.lobby$s1.i)]
##add new variable
compustat$lobby.name=cleaned.lobby$s2.i[match(compustat$conm, cleaned.lobby$s1.i)]


##step 2: clean lobby commpany names----------------------
##now clean company names for compustat.ftc as pre-step to match with compustat
lobby.unedited <- lobby
##CAPITALISE ALL ALPHABETS
lobby$ClientName <- toupper(lobby$ClientName) 
##replace "INCORPORATED" WITH "INC"
lobby$ClientName <- gsub("INCORPORATED", "INC", lobby$ClientName)
##replace "CORPORATION" with "CORP"
lobby$ClientName <- gsub("CORPORATION", "CORP", lobby$ClientName)
##replace "COMPANY" with "CO"
lobby$ClientName <- gsub("COMPANY", "CO", lobby$ClientName)
##remove all punctuations, including c("." "," "")
lobby$ClientName <- gsub("[[:punct:]]", "", lobby$ClientName)
##remove " LLC "
lobby$ClientName <- gsub(" LLC", "", lobby$ClientName)
##remove " INC "
lobby$ClientName <- gsub(" INC", "", lobby$ClientName)
##remove " LTD "
lobby$ClientName <- gsub(" LTD", "", lobby$ClientName)
##remove " CORP "
lobby$ClientName <- gsub(" CORP", "", lobby$ClientName)
##replace "GROUP" with "GRP"
lobby$ClientName <- gsub(" GROUP", "GRP", lobby$ClientName)
##remove spaces
lobby$ClientName <- gsub(" ", "", lobby$ClientName)

##clean up lobby dataset to remove duplicates!!!
cleaned.lobby <- lobby %>%
  group_by(ClientName, Year)%>%
  summarise(amount1 = sum(Amount))

##step 3: match--------------------
##now match names
compustat.lobby <- merge(x=compustat, y=cleaned.lobby, by.x=c("fyear", "lobby.name"), by.y=c("Year", "ClientName"), all.x=TRUE)
##check for duplicates
View(compustat.lobby[duplicated(compustat.lobby[c("conm", "fyear")]),])
##remove duplicates
compustat.lobby <- compustat.lobby[!duplicated(compustat.lobby[c("conm","fyear")]),]
View(compustat.lobby[duplicated(compustat.lobby[c("conm", "fyear")]),])

##now ready to match with ftc--------------------
##step 1: match with ftc---------------------------
##now load one compustat.ftc
cleaned.ftc <- read_ods("compustat.ftc.cleaned.ods")
##match company names: compustat with ftc
match(compustat.lobby$conm, cleaned.ftc$s2name)
##subset by square brackets
cleaned.ftc$s1name[match(compustat.lobby$conm, cleaned.ftc$s2name)]
##add new variable
compustat.lobby$ftcname=cleaned.ftc$s1name[match(compustat.lobby$conm, cleaned.ftc$s2name)]

##step 2: clean ftc commpany names----------------------
##now clean company names for compustat.ftc as pre-step to match with compustat
ftc.unedited <- ftc
##CAPITALISE ALL ALPHABETS
ftc$Description <- toupper(ftc$Description) 
##remove any names after /
ftc$Description <- gsub("/.*", "", ftc$Description)
##remove anything after "INC."
ftc$Description <- gsub("(INC.).*", "\\1", ftc$Description)
##remove anything after ";"
ftc$Description <- gsub(";.*", "\\1", ftc$Description)
##remove "IN IN THE MATTER OF"
ftc$Description <- gsub("IN THE MATTER OF", "", ftc$Description)
##remove all punctuations, including c("." "," "")
ftc$Description <- gsub("[[:punct:]]", "", ftc$Description)
##remove anything after "ET AL" and "ET AL" itself
ftc$Description <- gsub("ET AL.*", "", ftc$Description)
##replace "CORPORATION" with "CO"
ftc$Description <- gsub("CORPORATION", "CORP", ftc$Description)
##replace "COMPANY" with "CO"
ftc$Description <- gsub("COMPANY", "CO", ftc$Description)
##remove " LLC "
ftc$Description <- gsub(" LLC", "", ftc$Description)
##remove " INC "
ftc$Description <- gsub(" INC", "", ftc$Description)
##remove " LTD "
ftc$Description <- gsub(" LTD", "", ftc$Description)
##remove " CORP "
ftc$Description <- gsub(" CORP", "", ftc$Description)
##replace "GROUP" with "GRP"
ftc$Description <- gsub(" GROUP", "GRP", ftc$Description)
##remove spaces
ftc$Description <- gsub(" ", "", ftc$Description)
##change date to just year
a <- as.vector(ftc$Date)
##create a substrRight function
substrRight <- function(x, n){
  substr(x, nchar(x)-n+1, nchar(x))
}
year <- as.numeric(substrRight(a, 4))
##year column created
ftc$initiation=year
ftc <- filter(ftc, initiation>=1999)
compustat.lobby <- filter(compustat.lobby, fyear>=1999)

##step 3: match--------------------
##now match names
compustat.lobby.ftc <- merge(x=compustat.lobby, y=ftc, by.x=c("fyear", "ftcname"), by.y=c("initiation", "Description"), all=TRUE)
sum(table(compustat.lobby.ftc$Case.numbers))
compustat.lobby.ftc <- compustat.lobby.ftc[!duplicated(compustat.lobby.ftc[c("conm","fyear")]),]
sum(table(compustat.lobby.ftc$Case.numbers))
View(compustat.lobby.ftc[duplicated(compustat.lobby.ftc[c("conm", "fyear")]),])


write.csv(compustat.lobby.ftc, "final_dataset.may13.csv")


##backup for lobby ftc---------------------------
##step 2: clean lobby commpany names----------------------
##now clean company names for compustat.ftc as pre-step to match with compustat
lobby.ftc.unedited <- lobby.ftc
##CAPITALISE ALL ALPHABETS
lobby.ftc$ClientName <- toupper(lobby.ftc$ClientName) 
##replace "INCORPORATED" WITH "INC"
lobby.ftc$ClientName <- gsub("INCORPORATED", "INC", lobby.ftc$ClientName)
##replace "CORPORATION" with "CORP"
lobby.ftc$ClientName <- gsub("CORPORATION", "CORP", lobby.ftc$ClientName)
##replace "COMPANY" with "CO"
lobby.ftc$ClientName <- gsub("COMPANY", "CO", lobby.ftc$ClientName)
##remove all punctuations, including c("." "," "")
lobby.ftc$ClientName <- gsub("[[:punct:]]", "", lobby.ftc$ClientName)
##remove " LLC "
lobby.ftc$ClientName <- gsub(" LLC", "", lobby.ftc$ClientName)
##remove " INC "
lobby.ftc$ClientName <- gsub(" INC", "", lobby.ftc$ClientName)
##remove " LTD "
lobby.ftc$ClientName <- gsub(" LTD", "", lobby.ftc$ClientName)
##remove " CORP "
lobby.ftc$ClientName <- gsub(" CORP", "", lobby.ftc$ClientName)
##replace "GROUP" with "GRP"
lobby.ftc$ClientName <- gsub(" GROUP", "GRP", lobby.ftc$ClientName)
##remove spaces
lobby.ftc$ClientName <- gsub(" ", "", lobby.ftc$ClientName)
