##match cn.compustat.2 WITH cn.ftc.10
# Method 2: applying different string matching methods
#osa Optimal string aligment, (restricted Damerau-Levenshtein distance).
#lv Levenshtein distance (as in R’s native adist).
#dl Full Damerau-Levenshtein distance.
#hamming Hamming distance (a and b must have same nr of characters).
#lcs Longest common substring distance.
#qgram q-gram distance.
#cosine cosine distance between q-gram profiles
#jaccard Jaccard distance between q-gram profiles
#jw Jaro, or Jaro-Winker distance.

#install.packages('stringdist')
library(stringdist)
library(reshape2)
one <- cn.compustat.cleaned
two <- cn.ftc.cleaned

distance.methods<-c('jw')
dist.methods<-list()
for(m in 1:length(distance.methods)){
  dist.name.enh<-matrix(NA, ncol = length(one),nrow = length(two))
  store.lapply <- lapply(one, stringdist, two, method=distance.methods[m])
  for (j in 1:length(one)){
    dist.name.enh[,j] <- unlist(store.lapply[j])
  }
  dist.methods[[distance.methods[m]]]<-dist.name.enh
}

match.s1.s2.enh<-NULL
for(m in 1:length(dist.methods)){
  
  dist.matrix<-as.matrix(dist.methods[[distance.methods[m]]])
  min.name.enh<-apply(dist.matrix, 1, base::min)
  for(i in 1:nrow(dist.matrix))
  {
    s2.i<-match(min.name.enh[i],dist.matrix[i,])
    s1.i<-i
    match.s1.s2.enh<-rbind(data.frame(s2.i=s2.i,s1.i=s1.i,s2name=one[s2.i], s1name=two[s1.i], adist=min.name.enh[i],method=distance.methods[m]),match.s1.s2.enh)
  }
}
# Let's have a look at the results
library(reshape2)
matched.names.matrix.1<-dcast(match.s1.s2.enh,s2.i+s1.i+s2name+s1name~method, value.var = "adist")
View(matched.names.matrix.1)
table(matched.names.matrix.1$jaccard<0.1)
write.csv(matched.names.matrix.1, file="compustat.ftc.csv")


a<- read.csv("compustat.ftc.csv")


##-------------------------------------------------------
##match cn.compustat.2 WITH cn.ftc.10
# Method 2: applying different string matching methods
#osa Optimal string aligment, (restricted Damerau-Levenshtein distance).
#lv Levenshtein distance (as in R’s native adist).
#dl Full Damerau-Levenshtein distance.
#hamming Hamming distance (a and b must have same nr of characters).
#lcs Longest common substring distance.
#qgram q-gram distance.
#cosine cosine distance between q-gram profiles
#jaccard Jaccard distance between q-gram profiles
#jw Jaro, or Jaro-Winker distance.

#install.packages('stringdist')
library(stringdist)
library(reshape2)
one <- cn.compustat.cleaned
two <- cn.lobby.ftc.cleaned

distance.methods<-c('jw')
dist.methods<-list()
for(m in 1:length(distance.methods)){
  dist.name.enh<-matrix(NA, ncol = length(one),nrow = length(two))
  store.lapply <- lapply(one, stringdist, two, method=distance.methods[m])
  for (j in 1:length(one)){
    dist.name.enh[,j] <- unlist(store.lapply[j])
  }
  dist.methods[[distance.methods[m]]]<-dist.name.enh
}

match.s1.s2.enh<-NULL
for(m in 1:length(dist.methods)){
  
  dist.matrix<-as.matrix(dist.methods[[distance.methods[m]]])
  min.name.enh<-apply(dist.matrix, 1, base::min)
  for(i in 1:nrow(dist.matrix))
  {
    s2.i<-match(min.name.enh[i],dist.matrix[i,])
    s1.i<-i
    match.s1.s2.enh<-rbind(data.frame(s2.i=s2.i,s1.i=s1.i,s2name=one[s2.i], s1name=two[s1.i], adist=min.name.enh[i],method=distance.methods[m]),match.s1.s2.enh)
  }
}
# Let's have a look at the results
library(reshape2)
matched.names.matrix.2<-dcast(match.s1.s2.enh,s2.i+s1.i+s2name+s1name~method, value.var = "adist")
View(matched.names.matrix.2)
table(matched.names.matrix.2$jaccard<0.1)
write.csv(matched.names.matrix.2, file="compustat.lobby.csv")


##for Editing Purposes with ODS----------
library(readODS)
a <- read.csv("compustat.ftc.csv")
a.order <- a[order(a$jw),]
write_ods(a.order, "compustat.ftc.sorted.ods")

b <- read.csv("compustat.lobby.csv")
b.order <- b[order(b$jw),]
write_ods(b.order, "compustat.lobby.sorted.ods")


##match cn.compustat.2 WITH cn.lobby.cleaned
# Method 2: applying different string matching methods
#osa Optimal string aligment, (restricted Damerau-Levenshtein distance).
#lv Levenshtein distance (as in R’s native adist).
#dl Full Damerau-Levenshtein distance.
#hamming Hamming distance (a and b must have same nr of characters).
#lcs Longest common substring distance.
#qgram q-gram distance.
#cosine cosine distance between q-gram profiles
#jaccard Jaccard distance between q-gram profiles
#jw Jaro, or Jaro-Winker distance.

#install.packages('stringdist')
library(stringdist)
library(reshape2)
two <- cn.lobby.cleaned
one <- cn.compustat.cleaned

  store.lapply <- lapply(one, stringdist, two, method="jw")
  
  ##the minimum value of cn.lobby.cleaned matched with each cn.compustat.cleaned (one)
  ##min(unlist(store.lapply[i])) -->i indicates position in cn.compustat.cleaned (one)
  
  ##the position of each minimum value-->indicates position in cn.lobby.cleaned (two)
  ##which.min(unlist(store.lapply[i])) --> indicates position in cn.lobby.cleaned (two)

match.s1.s2.enh<-NULL
  for(i in 1:length(store.lapply)){
    s1.i<-i
    s2.i<-which.min(unlist(store.lapply[i]))
    match.s1.s2.enh<-rbind(data.frame(s2.i=s2.i,s1.i=s1.i,s2name=two[s2.i], s1name=one[s1.i], adist=min(unlist(store.lapply[i])),method='jw'),match.s1.s2.enh)
  }


table(match.s1.s2.enh$adist<=0.1)
arranged.full.lobby <- match.s1.s2.enh%>%
  arrange(adist)
write.csv(arranged.full.lobby, file="compustat.ftc.FULL.csv")
full.lobby <- filter(match.s1.s2.enh, adist==0)
write_ods(full.lobby, "compustat.lobby.full.2.ods")


# Let's have a look at the results
library(reshape2)
matched.names.matrix.1<-dcast(match.s1.s2.enh,s2.i+s1.i+s2name+s1name~method, value.var = "adist")
View(matched.names.matrix.1)
table(matched.names.matrix.1$jaccard<0.1)
write.csv(matched.names.matrix.1, file="compustat.ftc.csv")


a<- read.csv("compustat.ftc.csv")

