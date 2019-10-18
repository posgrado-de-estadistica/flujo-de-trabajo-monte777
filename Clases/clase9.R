# Pquetes
library(gstat)
library(sp)
library(lattice)
library(RColorBrewer)

data(meuse)

coordinates(meuse) <- c("x", "y")
print(xyplot(log(zinc)~sqrt(dist), as.data.frame(meuse), asp = .8), split = 
        c(1, 1,2,1), more = TRUE)
zn.lm <- lm(log(zinc)~sqrt(dist), meuse)
meuse$fitted.s <- predict(zn.lm, meuse) - mean(predict(zn.lm, meuse))
meuse$residuals <- residuals(zn.lm)
print(spplot(meuse, c("fitted.s", "residuals"), col.regions = 
               pal(), cuts = 8, colorkey=TRUE), split = c(2,1,2,1))


# Geoestadistica

Que podemos modelar la matriz de varianza y covarianza. 
La dependencia a través del tiempo en series, en espacio en geoestadística y hablamos de distancias.

ANtes se tinen un futuro ahora tengo un área delimitada que es la estimación sobre los puntos en la grilla

h= distancia en dos dimensiones, el modelo simple es una distancia lineal.

# Modelo lineal solo con el intercepto.
Estacionariedad que la media es constante
Se peude asumir que cambia la variación pero que la media constante, a través del espacio.

El otro, no hay sesgo en el espacio.

- Medición



semivariograma
x distancia 
y semivariancia

linea empirica (estimamos) y observada

entre más se alejan dos observaciones la correlación entre las obseravaciones es menor. Es inverso a la varianza
Rango y el umbral es para semivarianza

formula del semivariograma

h es un radio.

para cada punto se necesita al menos 30 observaciones


Para insesgar la varianza se puede decir que 1/2N N es el número de pares.

la relación es la misma no importa para cual dirección. an-isotropia o isotropia


# EJERCICIO

pal = function(n = 9) brewer.pal(n, "Reds")

coordinates(meuse) <- c("x", "y")
print(xyplot(log(zinc)~sqrt(dist), as.data.frame(meuse), asp = .8), split = 
        c(1, 1,2,1), more = TRUE)
zn.lm <- lm(log(zinc)~sqrt(dist), meuse)
meuse$fitted.s <- predict(zn.lm, meuse) - mean(predict(zn.lm, meuse))
meuse$residuals <- residuals(zn.lm)
print(spplot(meuse, c("fitted.s", "residuals"), col.regions = 
               pal(), cuts = 8, colorkey=TRUE), split = c(2,1,2,1))

data(meuse.grid)
coordinates(meuse.grid) <- c("x", "y")
meuse.grid <- as(meuse.grid, "SpatialPixelsDataFrame")


names(meuse)
#se puede variar idp
idw.out <- gstat::idw(zinc~1, meuse, meuse.grid, idp = 2.5)
as.data.frame(idw.out)[1:5,]


zn.lm <- lm(log(zinc)~sqrt(dist), meuse)
meuse.grid$pred <- predict(zn.lm, meuse.grid)
meuse.grid$se.fit <- predict(zn.lm, meuse.grid, se.fit=TRUE)$se.fit


meuse.lm <- krige(log(zinc)~sqrt(dist), meuse, meuse.grid)
summary(meuse.lm)

# Trend surface analysis:
meuse.tr2 <- krige(log(zinc)~1, meuse, meuse.grid, degree = 2)

lm(log(zinc)~I(x^2)+I(y^2)+I(x*y) + x + y, meuse)

lm(log(zinc) ~ poly(x, y, degree = 2), meuse)

# Estimación del semivariograma

hscat(log(zinc)~1,data=meuse,breaks=(0:9)*100, pch=1, cex=.3, col = 'gray')

Se puede definir los lag para estimar.


gstat

library(gstat)
cld <- variogram(log(zinc) ~ 1, meuse, cloud = TRUE)
svgm <- variogram(log(zinc) ~ 1, meuse)
## ~1 quiere decir media constante
d <- data.frame(gamma = c(cld$gamma, svgm$gamma),
                dist = c(cld$dist, svgm$dist),
                id = c(rep("cloud", nrow(cld)), rep("sample variogram", nrow(svgm)))
)
xyplot(gamma ~ dist | id, d,
       scales = list(y = list(relation = "free", 
                              #ylim = list(NULL, c(-.005,0.7)))),
                              limits = list(NULL, c(-.005,0.7)))),
       layout = c(1, 2), as.table = TRUE,
       panel = function(x,y, ...) {
         if (panel.number() == 2)
           ltext(x+10, y, svgm$np, adj = c(0,0.5)) #$
         panel.xyplot(x,y,...)
       },
       xlim = c(0, 1590),
       cex = .5, pch = 3
)

#

sel <-
  structure(list(x = c(145.291968730077, 266.107479142605, 320.156523274526,
                       339.232656497557, 323.335878811698, 212.058435010685, 135.753902118561,
                       46.7319470777507, 78.5255024494688, 142.112613192905), y = c(574649.690841889,
                                                                                    581256.265954825, 627502.29174538, 822396.257577002, 1053626.38652977,
                                                                                    1278249.94036961, 1255126.92747433, 792666.669568789, 634108.866858316,
                                                                                    577952.978398357)), .Names = c("x", "y"))
v <- variogram(zinc ~ 1, meuse, cloud = TRUE)
v$gamma <- v$gamma/1e6
sel$y <- sel$y/1e6
p1 <- xyplot(gamma~dist, v,
             panel = function(x, y, ...) {
               panel.xyplot(x, y, ...)
               llines(sel$x, sel$y, col = 'red')
             },
             pch=3, cex = .5, asp = 1, ylab = "gamma (x 1e6)")
x <-
  structure(list(head = c(40, 40, 40, 54, 55, 54, 47, 80, 55, 55,
                          54, 53, 54, 55, 59, 59), tail = c(41, 42, 43, 57, 57, 58, 59,
                                                            99, 121, 122, 123, 125, 125, 125, 125, 132)), .Names = c("head",
                                                                                                                     "tail"), row.names = as.integer(c(NA, 16)), class = c("pointPairs",
                                                                                                                                                                           "data.frame"))
p2 = plot(x, meuse, scales=list(draw=F), col.line = 'red')
print(p1, split = c(1,1,2,1), more = TRUE)
print(p2, split = c(2,1,2,1))

#como caracterizo la variación

v <- variogram(log(zinc) ~ 1, meuse)
print(xyplot(gamma ~ dist, v, pch = 3, type = 'b', lwd = 2, col = 'darkblue',
             panel = function(x, y, ...) {
               for (i in 1:100) {
                 meuse$random = sample(meuse$zinc)
                 v = variogram(log(random) ~ 1, meuse)
                 llines(v$dist, v$gamma, col = 'grey')
               }
               panel.xyplot(x, y, ...)
             },
             ylim = c(0, 0.75), xlab = 'distance', ylab = 'semivariance'
))

La azul no debe caer en la gris que son las simuladas


plot(variogram(log(zinc) ~ 1, meuse))

# EL variaorama es el mismo para todas las direcciones

plot(variogram(log(zinc) ~ 1, meuse, alpha = c(0, 45, 90, 135)))

para esa dirección no existe tanto patron espacial que para el otros grafico de residuos y fitt, ver con los variogramas

Hacer el ejercicio de aleatorización. Pueden tener diferente dirección no hay isotropia

plot(variogram(log(zinc) ~ 1, meuse, cutoff = 1000, width = 50))

plot(variogram(log(zinc) ~ 1, meuse, boundaries = c(0,50,100,seq(250,1500,250))))

show.vgms()

show.vgms(model = "Mat", kappa.range = c(.1, .2, .5, 1, 2, 5, 10), max = 10)

vgm(1, "Sph", 300)
vgm(1, "Sph", 300, 0.5)

v1 <- vgm(1, "Sph", 300, 0.5)
v2 <- vgm(0.8, "Sph", 800, add.to = v1)
v2

vgm(0.5, "Nug", 0)

vgm()

Si tengo la forma de la estimación de la varianza entonces puedo relacionar la pregunta de investigación por ejemplo entre mayor distancia mayor indicador o var objetivo


v <- variogram(log(zinc) ~ 1, meuse)
plot(v)


fit.variogram(v, vgm(1, "Sph", 800, 1))

plot(variogramLine(vgm(0.59, "Sph", 896, 0.05), 1500), type = 'l')

fit.variogram(v, vgm(1, "Sph", 10, 1))

v <- variogram(log(zinc) ~ 1, meuse)
v.fit <- fit.variogram(v, vgm(1, "Sph", 800, 1))
ccol = 'darkblue' #grey(.5)
plot(v, v.fit, pch = 3, panel = function(x,y,subscripts,...) {
  larrows(0,v.fit$psill[1], v.fit$range[2], v.fit$psill[1], 
          col=ccol, ends = 'both', length=.1, angle=15)
  larrows(v.fit$range[2],0, v.fit$range[2], v.fit$psill[1], 
          col=ccol, ends = 'both', length=.1, angle=15)
  larrows(v.fit$range[2],v.fit$psill[1], v.fit$range[2], 
          sum(v.fit$psill), 
          col=ccol, ends = 'both', length=.1, angle=15)
  ltext(v.fit$rang[2]/2, 1.2*v.fit$psill[1], "range", col=ccol,
        adj = c(.5, 0), cex=.9)
  ltext(1.02 * v.fit$rang[2], 0.5 *v.fit$psill[1], "nugget", col=ccol,
        adj = c(0, 0.5), cex=.9)
  ltext(1.02 * v.fit$rang[2], v.fit$psill[1] + 0.5 * v.fit$psill[2], 
        "partial sill", col=ccol, adj = c(0, 0.5), cex=.9)
  vgm.panel.xyplot(x,y,subscripts,...)
}
)

