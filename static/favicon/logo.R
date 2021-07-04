NUMSIDES=6

ANGLES = pi/6+2*pi*((1:NUMSIDES) -1)/NUMSIDES #always start at 3 oclock
cosAngles = cos(ANGLES)
sinAngles = sin(ANGLES)
relativeCoordinates = cbind(cosAngles,sinAngles)

plot(trigAngles,pch=as.character(1:6))

ucolours = c(
  black ="#000000",
  gold="#E4B429",
  white ="#FFFFFF",
  pink ="#C60078"
)
gcolours = c(red = "#C20430",
  black = "#000000",
  gold = "#FFC72A",
  blue = "#69A3B9"
)
pcolours = c(
  maroon = "#7A003C",
  gold = "#FDBF57",
  grey = "#5E6A71"
)
fcolours = c(
  blue = "#003e51",
  teal = "#00b0b9",
  yellow = "#ffcd00",
  sage = "#bad1ba"
#  grey = "#9ab7c1",
)

colours = list(ucolours,gcolours,pcolours,fcolours)

#colours[[3]]=c(colours[[3]],colours[[4]][length(colours[[4]])])
#colours[[4]]=colours[[4]][1:(length(colours[[4]])-1)]

colours = rev(lapply(colours,rev))

makeRowList = function(i){
  numShapes = length(colours[[i]])
  centres = cbind(2*cosAngles[1]*(1:numShapes -1),(i-1)*3*sinAngles[1])
  if (i%%2){
  centres[,1]=centres[,1]+cosAngles[1]#+c(cosAngles[1],-sinAngles[1])
  }
  if(i==2) centres[,1]=centres[,1]+2*cosAngles[1]
#  if(i==1) centres[,1]=centres[,1]-2*cosAngles[1]
  
  centres=centres*1.05
  
  
  
  rowVertices = lapply(1:numShapes,function(j){
    sweep(x = relativeCoordinates,MARGIN=2,STATS = centres[j,],FUN = "+")
  }) |> do.call(what=rbind)
  rowVertices
}

makeHexagons = lapply(1:length(colours),makeRowList) |> do.call(what = rbind)

allColours = unlist(colours)

idColour = data.frame(idNumber=as.vector(sapply(1:length(allColours),function(i)rep(i,NUMSIDES))),
                      colour = as.vector(sapply(1:length(allColours),function(i)rep(allColours[i],NUMSIDES)))
                      )

df = data.frame(idColour,(makeHexagons))
library(ggplot2)
p=ggplot(df,aes(x=cosAngles,y=sinAngles),show.legend=F)+
  theme(legend.position="none")+
  geom_polygon(data=df,colour="black",aes(fill=colour,group=idNumber))+
  scale_fill_identity()+theme_void()+theme(legend.position="none")
  theme(panel.background=element_rect(fill="transparent",colour=NA))
print(p)

(roofheight = 1-sinAngles[1] )
(househeight= 2*sinAngles[1])
(housewidth = 2*cosAngles[1])

height =4*househeight + 2*roofheight
width  = 3.46*housewidth




scalesize=250

png(filename='customlogo_resize.png',width=scalesize*width/height,height=scalesize,units="px",bg="transparent")
print(p)
dev.off()

