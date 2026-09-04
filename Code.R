#body variables: scaled mass index, wing, tarsus, tail, beak depth, beak length, beak width
#territory variables: avg veg height, avg canopy, percentage of trees, percentage of shrubs, num shrubs, num trees
#GIS variables: territory size, maximum veg height, percent low veg, percent high veg 
#song variables: number of song types, number of unique note types, avg song length, avg song bw, avg note bw, avg song pfc min

library(MuMIn)
library(car)
library(performance)


#_________________________

#MORPHOMETRIC VARIABLE REGRESSION:

#____________

#number of unique note types / scaled mass index  


uninotetype <-lm(uni_notetyp ~ scale(scaledmass) + scale(wing) + scale(tail) + scale(tarsus) + scale(beak_l) +  scale(beak_w) + scale(beak_d), Morphometrics_Song)

options(na.action = "na.fail")
all.parms<-lm(uni_notetyp ~ scale(scaledmass) + scale(wing) + scale(tail) + scale(tarsus) + scale(beak_l) + scale(beak_w) + scale(beak_d), Morphometrics_Song)
all.parms 
results<-dredge(all.parms)
results

#4 models; third one with beak width and scaled mass index is only one with relevant variable

uninotetyp3 <- lm(uni_notetyp ~ scale(scaledmass) + scale(beak_w), Morphometrics_Song)
confint(uninotetyp3,level = 0.90)
#scaled mass index doesnt cross zero
summary(uninotetyp3)
check_model(uninotetyp3, residual_type = "normal")

#plot:

library(effects)
library(ggplot2)

coneffect <-predictorEffect("scaledmass", uninotetyp3)
coneffectDF<-data.frame(coneffect)
head(coneffectDF)

scaledmassplot<-ggplot(data=coneffectDF,aes(x=scaledmass,y=fit))+geom_line(color="black",lwd=1.5)+geom_ribbon(aes(ymin=fit-se,ymax=fit+se),fill="black",alpha=.2,lwd=.1)+theme(text=element_text(family="Times New Roman", face="bold", size=12))
scaledmassplot

scaledmassplot2<-scaledmassplot+labs(x="Scaled Mass Index",y="Number of Unique Note Types")+theme_classic()+theme(text=element_text(family="Times New Roman", size=12)) +theme(panel.border= element_rect(colour="black",fill=NA,size=1),panel.grid.major= element_blank(),panel.grid.minor= element_blank(),axis.line= element_line(colour="black"),axis.text.x= element_text(color="black",size=12),axis.text.y= element_text(color="black",size=12),axis.title.x= element_text(color="black",face="bold", size=14),axis.title.y= element_text(color="black", face="bold", size=14))+geom_hline(yintercept=0,linetype="dashed",color="gray",size=.6) + labs(subtitle="(a)", face="italic") + theme(plot.subtitle= element_text(face="italic",size=14))
scaledmassplot2

scaledmassplot3<-scaledmassplot+geom_point(data=Morphometrics_Song,aes(x=scaledmass,y=uni_notetyp),color="black",size=3.1,pch=19)+labs(x="Scaled Mass Index",y="Number of Unique Note Types")+theme_classic() +theme(text=element_text(family="Times New Roman", size=12)) +theme(panel.border= element_rect(colour="black",fill=NA,size=1),panel.grid.major= element_blank(),panel.grid.minor= element_blank(),axis.line= element_line(colour="black"),axis.text.x= element_text(color="black",size=12),axis.text.y= element_text(color="black",size=12),axis.title.x= element_text(color="black",face="bold", size=14),axis.title.y= element_text(color="black", face="bold", size=14))+geom_hline(yintercept=0,linetype="dashed",color="gray",size=.6) + theme(plot.subtitle= element_text(face="italic",size=14))
scaledmassplot3

#MSOO is outlier -> take it out

Morphometrics_Song2<-subset(Morphometrics_Song, scaledmass > 7)

options(na.action = "na.fail")
all.parms<-lm(uni_notetyp ~ scale(scaledmass) + scale(wing) + scale(tail) + scale(tarsus) + scale(beak_l) + scale(beak_w) + scale(beak_d), Morphometrics_Song2)
all.parms 
results<-dredge(all.parms)
results

#3 total models but scaled mass index + beak width is only one with relevant variable

uninotetyp3 <- lm(uni_notetyp ~ scale(scaledmass) + scale(beak_w), Morphometrics_Song2)
confint(uninotetyp3,level = 0.90) 
summary(uninotetyp3)
check_model(uninotetyp3, residual_type = "normal")

#relevant info: 
#conf interval (90): -7.964, -0.089
#beta: -4.026
#std err: 2.301
#t value: -1.749 
#r squared: 0.122(multiple), 0.049(adjusted)

coneffect <-predictorEffect("scaledmass", uninotetyp3)
coneffectDF<-data.frame(coneffect)
head(coneffectDF)

#plot:

scaledmassindexplot<-ggplot(data=coneffectDF,aes(x=scaledmass,y=fit))+geom_line(color="black",lwd=1.5)+geom_ribbon(aes(ymin=fit-se,ymax=fit+se),fill="black",alpha=.2,lwd=.1)+theme(text=element_text(family="Times New Roman", face="bold", size=12))
scaledmassindexplot

scaledmassindexplot2<-scaledmassindexplot+labs(x="Scaled Mass Index",y="Number of Unique Note Types")+theme_classic()+theme(text=element_text(family="Times New Roman", size=12)) +theme(panel.border= element_rect(colour="black",fill=NA,size=1),panel.grid.major= element_blank(),panel.grid.minor= element_blank(),axis.line= element_line(colour="black"),axis.text.x= element_text(color="black",size=12),axis.text.y= element_text(color="black",size=12),axis.title.x= element_text(color="black",face="bold", size=14),axis.title.y= element_text(color="black", face="bold", size=14))+geom_hline(yintercept=0,linetype="dashed",color="gray",size=.6, face="italic") + theme(plot.subtitle= element_text(face="italic",size=14))
scaledmassindexplot2

scaledmassindexplot3<-scaledmassindexplot+geom_point(data=Morphometrics_Song2,aes(x=scaledmass,y=uni_notetyp),color="black",size=3.1,pch=19)+labs(x="Scaled Mass Index",y="Number of Unique Note Types")+theme_classic() +theme(text=element_text(family="Times New Roman", size=12)) +theme(panel.border= element_rect(colour="black",fill=NA,size=1),panel.grid.major= element_blank(),panel.grid.minor= element_blank(),axis.line= element_line(colour="black"),axis.text.x= element_text(color="black",size=12),axis.text.y= element_text(color="black",size=12),axis.title.x= element_text(color="black",face="bold", size=14),axis.title.y= element_text(color="black", face="bold", size=14))+geom_hline(yintercept=0,linetype="dashed",color="gray",size=.6) + theme(plot.subtitle= element_text(face="italic",size=14))
scaledmassindexplot3

#_________

#average song bw / beak length 

options(na.action = "na.fail")
all.parms<-lm(avg_songbw ~ scale(scaledmass) + scale(wing) + scale(tail) + scale(tarsus) + scale(beak_l) +  scale(beak_w) +  scale(beak_d), Morphometrics_Song)
all.parms 
results<-dredge(all.parms)
results

#7 total models but beak length + beak width is only one with relevant variable

avgsongbw <- lm(avg_songbw ~ scale(beak_l)+scale(beak_w), Morphometrics_Song)
confint(avgsongbw,level = 0.90)

summary(avgsongbw)
check_model(avgsongbw, residual_type = "normal")

#relevant info: 
#conf interval (90):3.499769, 360.23629
#beta: 181.87
#std err: 104.42
#t value: 1.742 
#r squared: 0.114(multiple), 0.044 (adjusted)

#plot:

coneffect <-predictorEffect("beak_l", avgsongbw)
coneffectDF<-data.frame(coneffect)
head(coneffectDF)

beakplot<-ggplot(data=coneffectDF,aes(x=beak_l,y=fit))+geom_line(color="black",lwd=1.5)+geom_ribbon(aes(ymin=fit-se,ymax=fit+se),fill="black",alpha=.2,lwd=.1)+ylim(2000, 5000)+theme(text=element_text(family="Times New Roman", face="bold", size=12))
beakplot

beakplot3<-beakplot+geom_point(data=Morphometrics_Song,aes(x=beak_l,y=avg_songbw),color="black",size=3.1,pch=19)+labs(x="Beak Length (mm)",y="Average Song Bandwidth (Hz)")+theme_classic() +theme(text=element_text(family="Times New Roman", size=12)) +theme(panel.border= element_rect(colour="black",fill=NA,size=1),panel.grid.major= element_blank(),panel.grid.minor= element_blank(),axis.line= element_line(colour="black"),axis.text.x= element_text(color="black",size=12),axis.text.y= element_text(color="black",size=12),axis.title.x= element_text(color="black",face="bold", size=14),axis.title.y= element_text(color="black", face="bold", size=14))+geom_hline(yintercept=0,linetype="dashed",color="gray",size=.6) + labs(subtitle="(a)", face="italic")+ theme(plot.subtitle= element_text(face="italic",size=14))+ theme(plot.margin=unit(c(0.1,0.4,0.1,0.1), 'cm'))
beakplot3

#_______

#average note bw / beak length 

options(na.action = "na.fail")
all.parms<-lm(avg_note_bw ~ scale(scaledmass) + scale(wing) + scale(tail) + scale(tarsus) + scale(beak_l) +  scale(beak_w) +  scale(beak_d), Morphometrics_Song)
all.parms 
results<-dredge(all.parms)
results

#8 total models, only this one had relevant variable

avgnotebw5 <- lm(avg_note_bw ~ scale(beak_w) + scale(beak_l), Morphometrics_Song)
confint(avgnotebw5,level = 0.90)

summary(avgnotebw5)
check_model(avgnotebw5, residual_type = "normal")

#relevant info: 
#conf interval (90): 14.31541, 185.0280
#beta: 99.67      
#std err: 49.97    
#t value: 1.995
#r squared: 0.138(multiple), 0.069(adjusted)

#plot: 

coneffect <-predictorEffect("beak_l", avgnotebw5)
coneffectDF<-data.frame(coneffect)
head(coneffectDF)

beakbwplot<-ggplot(data=coneffectDF,aes(x=beak_l,y=fit))+geom_line(color="black",lwd=1.5)+geom_ribbon(aes(ymin=fit-se,ymax=fit+se),fill="black",alpha=.2,lwd=.1)+ylim(750, 2000)+theme(text=element_text(family="Times New Roman", face="bold", size=12))
beakbwplot

beakbwplot3<-beakbwplot+geom_point(data=Morphometrics_Song,aes(x=beak_l,y=avg_note_bw),color="black",size=3.1,pch=19)+labs(x="Beak Length (mm)",y="Average Note Bandwidth (Hz)")+theme_classic() +theme(text=element_text(family="Times New Roman", size=12)) +theme(panel.border= element_rect(colour="black",fill=NA,size=1),panel.grid.major= element_blank(),panel.grid.minor= element_blank(),axis.line= element_line(colour="black"),axis.text.x= element_text(color="black",size=12),axis.text.y= element_text(color="black",size=12),axis.title.x= element_text(color="black",face="bold", size=14),axis.title.y= element_text(color="black", face="bold", size=14))+geom_hline(yintercept=0,linetype="dashed",color="gray",size=.6) + labs(subtitle="(b)", face="italic")+ theme(plot.subtitle= element_text(face="italic",size=14)) + theme(plot.margin=unit(c(0.1,0.4,0.1,0.1), 'cm'))
beakbwplot3

#all other song variables had no relevant relationships with morphometric variables 

#_________________________________________________________________________

#HAND MEASURED TERRITORY VARIABLE REGRESSION

#_______

#number of song types / average vegetation height 

options(na.action = "na.fail")
all.parms<-lm(num_songtyp ~ scale(avgcanopy_tenm) + scale(avgvegh_tenm) + scale(shrub_percent) + scale(tree_percent) +  scale(number_shrubs) +  scale(number_trees), Territory_Song)
all.parms 
results<-dredge(all.parms)
results

songtypesterr <- lm(num_songtyp ~ scale(avgvegh_tenm), Territory_Song)
confint(songtypesterr,level = 0.90)

check_model(songtypesterr, residual_type = "normal")
summary(songtypesterr)

#relevant info: 
#conf interval (90): 0.031, 2.616
#beta: 1.324    
#std err: 0.743   
#t value: 1.781
#r squared: 0.157(multiple), 0.101(adjusted)

#plot:

coneffect <-predictorEffect("avgvegh_tenm", songtypesterr)
coneffectDF<-data.frame(coneffect)
head(coneffectDF)

terrplot<-ggplot(data=coneffectDF,aes(x=avgvegh_tenm,y=fit))+geom_line(color="black",lwd=1.5)+geom_ribbon(aes(ymin=fit-se,ymax=fit+se),fill="black",alpha=.2,lwd=.1)+ylim(5,25)+theme(text=element_text(family="Times New Roman", face="bold", size=12))
terrplot

terrplot2<-terrplot+labs(x="Average Vegetation Height (cm)",y="Number of Song Types")+theme_classic()+theme(text=element_text(family="Times New Roman", size=12)) +theme(panel.border= element_rect(colour="black",fill=NA,size=1),panel.grid.major= element_blank(),panel.grid.minor= element_blank(),axis.line= element_line(colour="black"),axis.text.x= element_text(color="black",size=12),axis.text.y= element_text(color="black",size=12),axis.title.x= element_text(color="black",face="bold", size=14),axis.title.y= element_text(color="black", face="bold", size=14))+geom_hline(yintercept=0,linetype="dashed",color="gray",size=.6) + labs(subtitle="(a)", face="italic") + theme(plot.subtitle= element_text(face="italic",size=14))
terrplot2

terrplot3<-terrplot+geom_point(data=Territory_Song,aes(x=avgvegh_tenm,y=num_songtyp),color="black",size=3.1,pch=19)+labs(x="Average Vegetation Height (cm)",y="Number of Song Types")+theme_classic() +theme(text=element_text(family="Times New Roman", size=12)) +theme(panel.border= element_rect(colour="black",fill=NA,size=1),panel.grid.major= element_blank(),panel.grid.minor= element_blank(),axis.line= element_line(colour="black"),axis.text.x= element_text(color="black",size=12),axis.text.y= element_text(color="black",size=12),axis.title.x= element_text(color="black",face="bold", size=14),axis.title.y= element_text(color="black", face="bold", size=14))+geom_hline(yintercept=0,linetype="dashed",color="gray",size=.6) + theme(plot.subtitle= element_text(face="italic",size=14))
terrplot3

#all other song variables had no relevant relationships with hand measured territory variables 

#__________________________________________________________________________

#GIS TERRITORY VARIABLE REGRESSION

#__________________

#average song bandwidth / percentage of high veg (2-3m)

options(na.action = "na.fail")
all.parms<-lm(avg_songbw ~ scale(terr_size) + scale(max_height)  + scale(low) + scale(high), GIS_Song)
all.parms 
results<-dredge(all.parms)
results

#3 models, high veg does not cross zero in top model 

songbwGIS1  <- lm(avg_songbw ~ scale(high), GIS_Song)
confint(songbwGIS1,level = 0.95) 

check_model(songbwGIS1, residual_type = "normal")
summary(songbwGIS1)

#relevant info: 
#conf interval (95): 41.938, 329.044
#beta: 185.49  
#std err: 70.47
#t value: 2.632
#r squared: 0.178(multiple), 0.152(adjusted)

#graph:
coneffect <-predictorEffect("high", songbwGIS1)
coneffectDF<-data.frame(coneffect)
head(coneffectDF)

songbwGISplot<-ggplot(data=coneffectDF,aes(x=high,y=fit))+geom_line(color="black",lwd=1.5)+geom_ribbon(aes(ymin=fit-se,ymax=fit+se),fill="black",alpha=.2,lwd=.1)+ylim(3000, 5000) + theme(text=element_text(family="Times New Roman", face="bold", size=12))
songbwGISplot

songbwGISplot2<-songbwGISplot+labs(x="Percentage of High Vegetation (2-3 m.)",y="Average Song Bandwidth (Hz)")+theme_classic()+theme(text=element_text(family="Times New Roman", size=12)) +theme(panel.border= element_rect(colour="black",fill=NA,size=1),panel.grid.major= element_blank(),panel.grid.minor= element_blank(),axis.line= element_line(colour="black"),axis.text.x= element_text(color="black",size=12),axis.text.y= element_text(color="black",size=12),axis.title.x= element_text(color="black",face="bold", size=14),axis.title.y= element_text(color="black", face="bold", size=14))+geom_hline(yintercept=0,linetype="dashed",color="gray",size=.6) + labs(subtitle="(a)", face="italic") + theme(plot.subtitle= element_text(face="italic",size=14))
songbwGISplot2

songbwGISplot3<-songbwGISplot+geom_point(data=GIS_Song,aes(x=high,y=avg_songbw),color="black",size=3.1,pch=19)+labs(x="Percentage of High Vegetation (2-3 m)",y="Average Song Bandwidth (Hz)")+theme_classic() +theme(text=element_text(family="Times New Roman", size=12)) +theme(panel.border= element_rect(colour="black",fill=NA,size=1),panel.grid.major= element_blank(),panel.grid.minor= element_blank(),axis.line= element_line(colour="black"),axis.text.x= element_text(color="black",size=12),axis.text.y= element_text(color="black",size=12),axis.title.x= element_text(color="black",face="bold", size=14),axis.title.y= element_text(color="black", face="bold", size=14))+geom_hline(yintercept=0,linetype="dashed",color="gray",size=.6) +labs(subtitle="(a)", face="italic")+  theme(plot.subtitle= element_text(face="italic",size=14))
songbwGISplot3

#_______________

#average note bandwidth / percentage of high veg (2-3m) 

options(na.action = "na.fail")
all.parms<-lm(avg_note_bw ~ scale(terr_size) + scale(max_height)  + scale(low) + scale(high), GIS_Song)
all.parms 
results<-dredge(all.parms)
results

#3 models, high veg does not cross zero in top model 

notebwGIS1  <- lm(avg_note_bw ~ scale(high), GIS_Song)
confint(notebwGIS1,level = 0.95) 

check_model(notebwGIS1, residual_type = "normal")
summary(notebwGIS1)

#relevant info:
#conf interval (95): 27.233, 175.219
#beta: 101.23
#std error: 36.33
#t value: 2.787
#r squared: 0.195(multiple), 0.170(adjusted)

#graph:
coneffect <-predictorEffect("high", notebwGIS1)
coneffectDF<-data.frame(coneffect)
head(coneffectDF)

notebwGISplot<-ggplot(data=coneffectDF,aes(x=high,y=fit))+geom_line(color="black",lwd=1.5)+geom_ribbon(aes(ymin=fit-se,ymax=fit+se),fill="black",alpha=.2,lwd=.1) +ylim(1000, 2000)+ theme(text=element_text(family="Times New Roman", face="bold", size=12))
notebwGISplot

notebwGISplot2<-notebwGISplot+labs(x="Percentage of High Vegetation (2-3 m.)",y="Average Note Bandwidth (Hz)")+theme_classic()+theme(text=element_text(family="Times New Roman", size=12)) +theme(panel.border= element_rect(colour="black",fill=NA,size=1),panel.grid.major= element_blank(),panel.grid.minor= element_blank(),axis.line= element_line(colour="black"),axis.text.x= element_text(color="black",size=12),axis.text.y= element_text(color="black",size=12),axis.title.x= element_text(color="black",face="bold", size=14),axis.title.y= element_text(color="black", face="bold", size=14))+geom_hline(yintercept=0,linetype="dashed",color="gray",size=.6) + labs(subtitle="(a)", face="italic") + theme(plot.subtitle= element_text(face="italic",size=14))
notebwGISplot2

notebwGISplot3<-notebwGISplot+geom_point(data=GIS_Song,aes(x=high,y=avg_note_bw),color="black",size=3.1,pch=19)+labs(x="Percentage of High Vegetation (2-3 m)",y="Average Note Bandwidth (Hz)")+theme_classic() +theme(text=element_text(family="Times New Roman", size=12)) +theme(panel.border= element_rect(colour="black",fill=NA,size=1),panel.grid.major= element_blank(),panel.grid.minor= element_blank(),axis.line= element_line(colour="black"),axis.text.x= element_text(color="black",size=12),axis.text.y= element_text(color="black",size=12),axis.title.x= element_text(color="black",face="bold", size=14),axis.title.y= element_text(color="black", face="bold", size=14))+geom_hline(yintercept=0,linetype="dashed",color="gray",size=.6) +labs(subtitle="(b)", face="italic")+  theme(plot.subtitle= element_text(face="italic",size=14))
notebwGISplot3

#_________________

#avg pfc min freq / max veg height 

options(na.action = "na.fail")
all.parms<-lm(avg_min ~ scale(terr_size) + scale(max_height)  + scale(low) + scale(high), GIS_Song)
all.parms 
results<-dredge(all.parms)
results

#one model
pfcminGIS1  <- lm(avg_min ~ scale(max_height) + scale(terr_size), GIS_Song)
confint(pfcminGIS1,level = 0.95) 

check_model(pfcminGIS1, residual_type = "normal")
summary(pfcminGIS1)

coneffect <-predictorEffect("terr_size", pfcminGIS1)
coneffectDF<-data.frame(coneffect)
head(coneffectDF)

pfcminGISplot<-ggplot(data=coneffectDF,aes(x=terr_size,y=fit))+geom_line(color="black",lwd=1.5)+geom_ribbon(aes(ymin=fit-se,ymax=fit+se),fill="black",alpha=.2,lwd=.1)+ theme(text=element_text(family="Times New Roman", face="bold", size=12))
pfcminGISplot

pfcminGISplot2<-pfcminGISplot+labs(x="terr size",y="min freq")+theme_classic()+theme(text=element_text(family="Times New Roman", size=12)) +ylim(2300, 3000) + theme(panel.border= element_rect(colour="black",fill=NA,size=1),panel.grid.major= element_blank(),panel.grid.minor= element_blank(),axis.line= element_line(colour="black"),axis.text.x= element_text(color="black",size=12),axis.text.y= element_text(color="black",size=12),axis.title.x= element_text(color="black",face="bold", size=14),axis.title.y= element_text(color="black", face="bold", size=14))+geom_hline(yintercept=0,linetype="dashed",color="gray",size=.6) + labs(subtitle="(a)", face="italic") + theme(plot.subtitle= element_text(face="italic",size=14))
pfcminGISplot2

pfcminGISplot3<-pfcminGISplot+geom_point(data=GIS_Song,aes(x=terr_size,y=avg_min, label = "avg_min"),color="black",size=3.1,pch=19)+ labs(x="terr size",y="min freq")+theme_classic() +ylim(2300, 3000)+theme(text=element_text(family="Times New Roman", size=12)) +theme(panel.border= element_rect(colour="black",fill=NA,size=1),panel.grid.major= element_blank(),panel.grid.minor= element_blank(),axis.line= element_line(colour="black"),axis.text.x= element_text(color="black",size=12),axis.text.y= element_text(color="black",size=12),axis.title.x= element_text(color="black",face="bold", size=14),axis.title.y= element_text(color="black", face="bold", size=14))+geom_hline(yintercept=0,linetype="dashed",color="gray",size=.6) +labs(subtitle="(b)", face="italic")+  theme(plot.subtitle= element_text(face="italic",size=14))
pfcminGISplot3

#clearly an outlier here (GWOS) - take it out

GIS_Song2<-subset(GIS_Song, terr_size < 13000)

options(na.action = "na.fail")
all.parms<-lm(avg_min ~ scale(terr_size) + scale(max_height)  + scale(low) + scale(high), GIS_Song2)
all.parms 
results<-dredge(all.parms)
results

#three models but only max height + high veg has relevant variables 

pfcminGIS3  <- lm(avg_min ~ scale(max_height) + scale(high), GIS_Song2)
confint(pfcminGIS3,level = 0.95) 

summary(pfcminGIS3)
check_model(pfcminGIS3, residual_type = "normal")

#relevant info:
#conf interval (95): -98.328, -5.509
#beta: -51.92
#std error: 22.72
#t value: -2.285
#r squared: 0.210(multiple), 0.158(adjusted)

coneffect <-predictorEffect("max_height", pfcminGIS1)
coneffectDF<-data.frame(coneffect)
head(coneffectDF)

pfcminGISplot<-ggplot(data=coneffectDF,aes(x=max_height,y=fit))+geom_line(color="black",lwd=1.5)+geom_ribbon(aes(ymin=fit-se,ymax=fit+se),fill="black",alpha=.2,lwd=.1)+ theme(text=element_text(family="Times New Roman", face="bold", size=12))
pfcminGISplot

pfcminGISplot2<-pfcminGISplot+labs(x="Maximum Vegetation Height (m)",y="PFC Minimum Frequency")+theme_classic()+theme(text=element_text(family="Times New Roman", size=12)) +ylim(2000, 3000) + theme(panel.border= element_rect(colour="black",fill=NA,size=1),panel.grid.major= element_blank(),panel.grid.minor= element_blank(),axis.line= element_line(colour="black"),axis.text.x= element_text(color="black",size=12),axis.text.y= element_text(color="black",size=12),axis.title.x= element_text(color="black",face="bold", size=14),axis.title.y= element_text(color="black", face="bold", size=14))+geom_hline(yintercept=0,linetype="dashed",color="gray",size=.6) + labs(subtitle="(a)", face="italic") + theme(plot.subtitle= element_text(face="italic",size=14))
pfcminGISplot2

pfcminGISplot3<-pfcminGISplot+geom_point(data=GIS_Song2,aes(x=max_height,y=avg_min),color="black",size=3.1,pch=19)+ labs(x="Maximum Vegetation Height (m)",y="Avgerage PFC Minimum Frequency")+theme_classic() +ylim(2000, 3000) + theme(text=element_text(family="Times New Roman", size=12)) +theme(panel.border= element_rect(colour="black",fill=NA,size=1),panel.grid.major= element_blank(),panel.grid.minor= element_blank(),axis.line= element_line(colour="black"),axis.text.x= element_text(color="black",size=12),axis.text.y= element_text(color="black",size=12),axis.title.x= element_text(color="black",face="bold", size=14),axis.title.y= element_text(color="black", face="bold", size=14))+geom_hline(yintercept=0,linetype="dashed",color="gray",size=.6) +  theme(plot.subtitle= element_text(face="italic",size=14))
pfcminGISplot3

#all other song variables had no relevant relationships with GIS territory variables 

#_______________________________________________________

#REPEATABILITY ANALYSIS

install.packages("rptR")
library(rptR)
citation("rptR")

#ex code
rep1 <- rpt(BodyL ~ (1 | Population), grname = "Population", data = BeetlesBody,
            datatype = "Gaussian", nboot = 1000, npermut = 0)

#_______

#number of note types
numnotetyperep <- rpt(num_notetype ~ (1 | male_ID ), grname = "male_ID", data = Repeatability,
                      datatype = "Gaussian", nboot = 1000, npermut = 0)
summary(numnotetyperep)

#R = 0.137

#male_ID (87 groups)

#Repeatability estimation overview: 
#  R     SE   2.5%  97.5% P_permut  LRT_P
#0.137 0.0315   0.08  0.206       NA      0

#Bootstrapping and Permutation test: 
#  N   Mean Median   2.5%  97.5%
#  boot     1000  0.137  0.135   0.08  0.206
#permut      1     NA     NA     NA     NA

#Likelihood ratio test: 
#  logLik full model = -3462.101
#logLik red. model = -3559.802
#D  = 195, df = 1, P = 1.05e-44

#______________________________

#number of notes per song 
numnoterep <- rpt(num_notes ~ (1 | male_ID ), grname = "male_ID", data = Repeatability,
                  datatype = "Gaussian", nboot = 1000, npermut = 0)
summary(numnoterep)

#R= 0.083 

#male_ID (87 groups)

#Repeatability estimation overview: 
#  R     SE   2.5%  97.5% P_permut  LRT_P
#0.0823 0.0224 0.0419  0.128       NA      0

#Bootstrapping and Permutation test: 
#  N   Mean Median   2.5%  97.5%
#  boot     1000  0.081 0.0789 0.0419  0.128
#permut      1     NA     NA     NA     NA

#Likelihood ratio test: 
#  logLik full model = -4764.728
#logLik red. model = -4817.382
#D  = 105, df = 1, P = 5.22e-25

#____________________________________

#avg song length 
songlengthrep <- rpt(song_length ~ (1 | male_ID ), grname = "male_ID", data = Repeatability,
                     datatype = "Gaussian", nboot = 1000, npermut = 0)
summary(songlengthrep)

#R= 0.132 

#male_ID (87 groups)

#Repeatability estimation overview: 
#  R     SE   2.5%  97.5% P_permut  LRT_P
#0.132 0.0309 0.0756  0.194       NA      0

#Bootstrapping and Permutation test: 
#  N   Mean Median   2.5%  97.5%
#  boot     1000  0.131  0.129 0.0756  0.194
#permut      1     NA     NA     NA     NA

#Likelihood ratio test: 
#  logLik full model = -958.1452
#logLik red. model = -1059.521
#D  = 203, df = 1, P = 2.62e-46

#__________________________________

#avg song bw 
songbwrep <- rpt(bandwidth ~ (1 | male_ID ), grname = "male_ID", data = Repeatability,
                 datatype = "Gaussian", nboot = 1000, npermut = 0)
summary(songbwrep)

#R = 0.108


#male_ID (87 groups)

#Repeatability estimation overview: 
#  R     SE    2.5%  97.5% P_permut  LRT_P
# 0.108 0.0266 0.06  0.165       NA      0

#Bootstrapping and Permutation test: 
#  N   Mean Median   2.5%  97.5%
#  boot     1000   0.11   0.11   0.06  0.165
#permut      1     NA     NA     NA     NA

#Likelihood ratio test: 
#  logLik full model = -15164.93
#logLik red. model = -15239.46
#D  = 149, df = 1, P = 1.39e-34


#_____________

#pfc max 

pfcmaxrep <- rpt(pfcmax ~ (1 | male_ID), grname = "male_ID", data = Repeatability,
                 datatype = "Gaussian", nboot = 1000, npermut = 0)
summary(pfcmaxrep)

#R = 0.124

#Repeatability estimation overview: 
#  R     SE   2.5%  97.5% P_permut  LRT_P
#0.124  0.029 0.0703  0.182       NA      0

#Bootstrapping and Permutation test: 
#  N   Mean Median   2.5%  97.5%
#  boot     1000  0.122  0.121 0.0703  0.182
#permut      1     NA     NA     NA     NA

#Likelihood ratio test: 
#  logLik full model = -14878.91
#logLik red. model = -14970.15
#D  = 182, df = 1, P = 6.98e-42

#_____________

#pfc min

pfcminrep <- rpt(pfcmin ~ (1 | male_ID), grname = "male_ID", data = Repeatability,
                 datatype = "Gaussian", nboot = 1000, npermut = 0)
summary(pfcminrep)

#R = 0.0427

#Repeatability estimation overview: 
#  R     SE   2.5%  97.5% P_permut  LRT_P
#0.0427 0.0154 0.0157 0.0761       NA      0

#Bootstrapping and Permutation test: 
#  N   Mean Median   2.5%  97.5%
#  boot     1000  0.043 0.0424 0.0157 0.0761
#permut      1     NA     NA     NA     NA

#Likelihood ratio test: 
#  logLik full model = -13796.61
#logLik red. model = -13815.61
#D  = 38, df = 1, P = 3.52e-10

#____________________________________________________________________________

#POSTHOC TEST 

#beak length ~ scaled mass index 

beakscaledmass <-lm(beak_l ~ scale(scaledmass), Morphometrics_Song)
summary(beakscaledmass)
confint(beakscaledmass,level = 0.95) 

#relevant info:
#conf interval (95): 0.063, 0.515
#beta: 0.289
#std error: 0.11
#t value: 0.014
#r squared: 0.211(multiple), 0.014(adjusted)




