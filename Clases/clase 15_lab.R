## ---- echo=FALSE, include=FALSE------------------------------------------
library(knitr)
#opts_chunk$set(fig.width = 5, fig.height = 5, fig.cap='',  collapse = TRUE)
library(raster)
library(rgeos)
library(spdep)


## ----getData-------------------------------------------------------------

if (!require("rspatial")) devtools::install_github('rspatial/rspatial')

library(rspatial)
h <- sp_data('houses2000')


## ------------------------------------------------------------------------
library(raster)
dim(h)
names(h)


## ------------------------------------------------------------------------
hh <- aggregate(h, "County")


## ------------------------------------------------------------------------
d1 <- data.frame(h)[, c("nhousingUn", "recHouses", "nMobileHom", "nBadPlumbi", 
                        "nBadKitche", "Population", "Males", "Females", "Under5", "White", 
                        "Black", "AmericanIn", "Asian", "Hispanic", "PopInHouse", "nHousehold", "Families")]

d1a <- aggregate(d1, list(County=h$County), sum, na.rm=TRUE)


## ------------------------------------------------------------------------
d2 <- data.frame(h)[, c("houseValue", "yearBuilt", "nRooms", "nBedrooms", 
                        "medHHinc", "MedianAge", "householdS",  "familySize")]
d2 <- cbind(d2 * h$nHousehold, hh=h$nHousehold)

d2a <- aggregate(d2, list(County=h$County), sum, na.rm=TRUE)
d2a[, 2:ncol(d2a)] <- d2a[, 2:ncol(d2a)] / d2a$hh


## ------------------------------------------------------------------------
d12 <- merge(d1a, d2a, by='County')


## ------------------------------------------------------------------------
hh <- merge(hh, d12, by='County')


## ---- spreg2-------------------------------------------------------------
library(latticeExtra)

grps <- 10
brks <- quantile(h$houseValue, 0:(grps-1)/(grps-1), na.rm=TRUE)

p <- spplot(h, "houseValue", at=brks, col.regions=rev(brewer.pal(grps, "RdBu")), col="transparent" )
p + layer(sp.polygons(hh))


## ---- spreg4-------------------------------------------------------------
brks <- quantile(h$medHHinc, 0:(grps-1)/(grps-1), na.rm=TRUE)

p <- spplot(h, "medHHinc", at=brks, col.regions=rev(brewer.pal(grps, "RdBu")), col="transparent")
p + layer(sp.polygons(hh))

##### ASEGURARME DE QUE LOS RESIDUALES CUMPLEN CON LAS CARACTERISTICAS.


## ------------------------------------------------------------------------
hh$fBadP <- pmax(hh$nBadPlumbi, hh$nBadKitche) / hh$nhousingUn
hh$fWhite <- hh$White / hh$Population
hh$age <- 2000 - hh$yearBuilt

f1 <- houseValue ~ age +  nBedrooms 
m1 <- lm(f1, data=hh)
summary(m1)


## ------------------------------------------------------------------------
y <- matrix(hh$houseValue)
X <- cbind(1, hh$age, hh$nBedrooms)


## ------------------------------------------------------------------------
ols <- solve(t(X) %*% X) %*% t(X) %*% y
rownames(ols) <- c('intercept', 'age', 'nBedroom')
ols


## ---- spreg6-------------------------------------------------------------
hh$residuals <- residuals(m1)

brks <- quantile(hh$residuals, 0:(grps-1)/(grps-1), na.rm=TRUE)

spplot(hh, "residuals", at=brks, #col.regions=rev(brewer.pal(grps, "RdBu")), 
       col="black")


## ---- spreg8-------------------------------------------------------------

library(spdep)
nb <- poly2nb(hh) #Primero extraigo los poligonos que es hh, sino define bien todos los vecinos entonces se puede asignar  más vecinos

nb[[21]] <- sort(as.integer(c(nb[[21]], 38)))
nb[[38]] <- sort(as.integer(c(21, nb[[38]]))) # el problema es que no me esta considerando los vecinos a la bahia 
nb

par(mai=c(0,0,0,0))
plot(hh)
plot(nb, coordinates(hh), col='red', lwd=2, add=TRUE)


## ---- spreg10------------------------------------------------------------
resnb <- sapply(nb, function(x) mean(hh$residuals[x]))
cor(hh$residuals, resnb)
plot(hh$residuals, resnb, xlab='Residuals', ylab='Mean adjacent residuals')
lw <- nb2listw(nb)

#autocorrelación espacial positiva


## ------------------------------------------------------------------------
moran.mc(hh$residuals, lw, 999)

#evidencia de una autocorrelación espacial.


## ----spregplot1----------------------------------------------------------
m1s = lagsarlm(f1, data=hh, lw, tol.solve=1.0e-30)

summary(m1s)
#lambda es rho, hay evidencia que no es igual a cero. es importante

hh$residuals <- residuals(m1s)
moran.mc(hh$residuals, lw, 999)

brks <- quantile(hh$residuals, 0:(grps-1)/(grps-1), na.rm=TRUE)
p <- spplot(hh, "residuals", at=brks, col.regions=rev(brewer.pal(grps, "RdBu")), col="transparent")
print( p + layer(sp.polygons(hh)) )

# El RHO se encarga de la autocorrelación espacial


## ----spregplotx----------------------------------------------------------
m1e = errorsarlm(f1, data=hh, lw, tol.solve=1.0e-30)
summary(m1e)

hh$residuals <- residuals(m1e)
moran.mc(hh$residuals, lw, 999)

brks <- quantile(hh$residuals, 0:(grps-1)/(grps-1), na.rm=TRUE)
p <- spplot(hh, "residuals", at=brks, col.regions=rev(brewer.pal(grps, "RdBu")),
            col="transparent")
print( p + layer(sp.polygons(hh)) )

#una función x~y lat y longitud para explicar lo otro
# espatula son exactamente lo mismo

## ----spregplot3----------------------------------------------------------
brks <- quantile(hh$residuals, 0:(grps-1)/(grps-1), na.rm=TRUE)

p <- spplot(hh, "residuals", at=brks, col.regions=rev(brewer.pal(grps, "RdBu")),
            col="transparent")

print( p + layer(sp.polygons(hh)) )
