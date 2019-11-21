##  Clase 13 Estadísticas de áreas

Importante:
  
  Definición de la unidad estadística. Eje. Segmentos y cuales son las distancias y los puntos de riesgo.

Para validar que son vecinos que es lo que buscamos en áreas.
Cantidad de segmentos con vecinos.
+ 1 -> 1 vecicno
+ 2 -> 2 vecinos y luego incrementa. En promedio tienen 5.8 vecinos los segmentos.

H0 no hay autocorrelación.

## ---- echo=FALSE, include=FALSE------------------------------------------
library(knitr)
#opts_chunk$set(fig.width = 5, fig.height = 5, fig.cap='',  collapse = TRUE)
library(rgeos)
library(raster)
library(spdep)
library(deldir)
library(rgdal)


## ------------------------------------------------------------------------
set.seed(0)
d <- sample(100, 10)
d


## ---- autocor1-----------------------------------------------------------
#para gráficar t y t-1

a <- d[-length(d)]
b <- d[-1]
plot(a, b, xlab='t', ylab='t-1')
cor(a, b)


## ---- autocor2-----------------------------------------------------------
d <- sort(d)
d
a <- d[-length(d)]
b <- d[-1]
plot(a, b, xlab='t', ylab='t-1')
cor(a, b)


## ---- acfplot------------------------------------------------------------
acf(d)


## ---- message=FALSE------------------------------------------------------
library(raster)

p <- shapefile(system.file("external/lux.shp", package="raster"))
p <- p[p$NAME_1=="Diekirch", ]
p$value <- c(10, 6, 4, 11, 6) 
data.frame(p)

plot(p)

## ---- autocor3-----------------------------------------------------------
par(mai=c(0,0,0,0))
plot(p, col=2:7)
xy <- coordinates(p)
points(xy, cex=6, pch=20, col='white')
text(p, 'ID_2', cex=1.5)


## ---- message=FALSE------------------------------------------------------
library(spdep)
w <- poly2nb(p, row.names=p$Id)
class(w)
summary(w)


## ------------------------------------------------------------------------
str(w)


## ---- autocor4-----------------------------------------------------------
plot(p, col='gray', border='blue', lwd=2)
plot(w, xy, col='red', lwd=2, add=TRUE)


## ------------------------------------------------------------------------
wm <- nb2mat(w, style='B')
wm


## ------------------------------------------------------------------------
n <- length(p)


## ------------------------------------------------------------------------
y <- p$value
ybar <- mean(y)


## ------------------------------------------------------------------------
dy <- y - ybar
g <- expand.grid(dy, dy)
yiyj <- g[,1] * g[,2]


## ------------------------------------------------------------------------
yi <- rep(dy, each=n)
yj <- rep(dy)
yiyj <- yi * yj


## ------------------------------------------------------------------------
pm <- matrix(yiyj, ncol=n)


## ------------------------------------------------------------------------
pmw <- pm * wm
pmw


## ------------------------------------------------------------------------
spmw <- sum(pmw) 
spmw


## ------------------------------------------------------------------------
smw <- sum(wm)
sw  <- spmw / smw


## ------------------------------------------------------------------------
vr <- n / sum(dy^2)


## ------------------------------------------------------------------------
MI <- vr * sw
MI


## ------------------------------------------------------------------------
EI <- -1/(n-1)
EI


## ------------------------------------------------------------------------
ww <-  nb2listw(w, style='B')
ww


## ------------------------------------------------------------------------
moran(p$value, ww, n=length(ww$neighbours), S0=Szero(ww))

#Note that
Szero(ww)
# is the same as 
pmw
sum(pmw==0)


## ------------------------------------------------------------------------
moran.test(p$value, ww, randomisation=FALSE)


## ------------------------------------------------------------------------
moran.mc(p$value, ww, nsim=99)


## ------------------------------------------------------------------------
n <- length(p)
ms <- cbind(id=rep(1:n, each=n), y=rep(y, each=n), value=as.vector(wm * y))


## ------------------------------------------------------------------------
ms <- ms[ms[,3] > 0, ]


## ------------------------------------------------------------------------
ams <- aggregate(ms[,2:3], list(ms[,1]), FUN=mean)
ams <- ams[,-1]
colnames(ams) <- c('y', 'spatially lagged y')
head(ams)


## ---- auto5--------------------------------------------------------------
plot(ams)
reg <- lm(ams[,2] ~ ams[,1])
abline(reg, lwd=2)
abline(h=mean(ams[,2]), lt=2)
abline(v=ybar, lt=2)


## ---- ngb2---------------------------------------------------------------
coefficients(reg)[2]


## ------------------------------------------------------------------------
rwm <- mat2listw(wm, style='W')
# Checking if rows add up to 1
mat <- listw2mat(rwm)
apply(mat, 1, sum)[1:15]


## ---- auto10-------------------------------------------------------------
moran.plot(y, rwm)

Primera etapa si hay autocorrelación estadística.




