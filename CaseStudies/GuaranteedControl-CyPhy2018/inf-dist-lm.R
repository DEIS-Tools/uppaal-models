tab<-read.csv("inf-dist.csv")
vel<-tab[,1]
dist<-tab[,2]
plot(dist~vel)
d1=dist[1:12]
v1=vel[1:12]
v2=v1*v1 # second degree
v3=v2*v1 # third degree
v4=v3*v1 # fourth degree
v5=v4*v1 # fifth degree
v6=v5*v1 # sixth degree
lm.D=lm(d1~v1+v2+v3+v4+v5+v6) # create linear model
lm.S=summary(lm.D) # extract the summary
lm.S # show summary, seems only c0 and c2 are significant
lm.D1=lm(d1~v2) # create linear model with significant coefficients
lm.S1=summary(lm.D1) # extract the summary
c0=lm.S1$coefficients[1,1]
c2=lm.S1$coefficients[2,1]
plot(dist~vel)
lines(v1, c0+c2*v2)

res1=c0+c2*v2
result = data.frame(v1,res1)
write.table(result,"inf-dist-lm1.csv",sep=",",row.names=F,col.names=F)

tab<-read.csv("inf-dist.csv")
vel<-tab[,1]
dist<-tab[,2]
d2=dist[12:27]
v1=vel[12:27]
v2=v1*v1 # second degree
v3=v2*v1 # third degree
v4=v3*v1 # fourth degree
v5=v4*v1 # fifth degree
v6=v5*v1 # sixth degree
lm.D=lm(d2~v1+v2+v3) # create linear model
lm.S=summary(lm.D) # extract the summary
lm.S # show summary, seems only c0, c1, c2 and c3 are significant
lm.D2=lm(d2~v1+v2+v3) # create linear model with significant coefficients
lm.S2=summary(lm.D2) # extract the summary
c0=lm.S2$coefficients[1,1]
c1=lm.S2$coefficients[2,1]
c2=lm.S2$coefficients[3,1]
c3=lm.S2$coefficients[4,1]

res2=c0+c1*v1+c2*v2+c3*v3

plot(dist~vel)
lines(v1, res2)

result = data.frame(v1, res2)

write.table(result,"inf-dist-lm2.csv",sep=",",row.names=F,col.names=F)
