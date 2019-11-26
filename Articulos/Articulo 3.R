# articulo 3

Modelos autorregresivos espaciales para la inferencia estadistica de datos ecologicos

CAR: modelos autoregresivos condicionales 
SAR: Modelos autorregresivos simultáneos.

Modelar datos autocorrelacionados basados en relaciones de vecindad,

1) Selección del modelo 
2) regresión espacial
3) estimación de autocorrelación
4) Estimación de otro parametro de conectividad
5) Predicción espacial
6) Suavizado espacial

Comparemos modelos con las correlaciones parciales

Elegir entre (CAR) y (IAR) Modelo autorregresivo intrinsico
(SAR) Dependen de las matrices de peso, estandarización de filas.

Ambos se ajustan utilizando máxima verosimilitud y métodos bayesianos.

Modelar los efectos de la matriz de varianza y covarianza.

**Introducción**

Los ecologistas han reconocido por mucho tiempo que los datos exhiben patrones de prueba (Watt 1947). Estos patrones fueron a menudoexpresado como autocorrelación espacial (Sokal y Oden1978), que es la tendencia de sitios cercanos con valores más similares que los sitios que son más lejos el uno del otro. Cuando autocorrelación espacial existe en los datos, los ecologistas a menudo usan modelos estadísticos espaciales porque la suposición de errores independientes no se cumplen.

Los datos de área son un tipo de datos ecológicos espaciales que implican polígonos o datos de área de referencia con medidas en los poligonos (ejemplo recuentos de animales del juego áreas de manejo).

A menudo, los datos ecológicos recopilados en los polígonos cercanos son más similares que los que están más lejos aparte debido a condiciones de hábitat similares, procesos como la migración o dispersión.

Por ejemplo, conteos de animales más altos u ocupación a menudo forman espacio grupos en el paisaje (Thogmartin et al. 2004,Broms y col. 2014, Poley et al. 2014), medida de la plantaLos elementos de un conjunto de parcelas pueden estar modelados espacialmente(Agarwal et al. 2005, Bullock y Burkhart 2005,Huang y col. 2013), o la diversidad global de especies puede exhibirpatrones geográficos de bits cuando se representa como un gruesocuadrícula de escala (Tognelli y Kelt 2004, Pedersen et al. 2014).Para estos tipos de datos espaciales, la información espacial puede ser codificado utilizando barrios, lo que conduce a espacialmodelos autorregresivos (Lichstein et al. 2002). Los modelos autoregresivos espaciales más comunes son los autorregresivo opcional (CAR) y autorregresivo simultáneomodelos gressive (SAR) (Haining 1990, Cressie 1993).

Los modelos autorregresivos y SAR condicionales forman ungran clase de modelos estadísticos espaciales. Datos ecológicos a menudo exhiben un patrón espacial, y mientras CAR y SAR los modelos se han usado en ecología, deberían usarse más a menudo. Nuestro objetivo es revisar CAR y SARmodelos de manera práctica, para que su potencial pueda sermás plenamente realizado y utilizado por los ecologistas, y comenzamos con una visión general de sus múltiples usos

**Inferencia**

<7>    Cuando la autocorrelación espacial es explicada por I Moran


Primero, debe existir autocorrelación espacial para utilizar los modelos CAR y SAR.
    
1) Selección del modelo 

Revela importantes relaciones entre la variable respuesta y las dependientes.
 **Criterios**
    +  AIC
    +  DIC Deviance.

2) Regresión espacial
Relaciones permanentes entre $Y = x_i$

    Teniendo bases teoricas sobre las relaciones entre las variables dependientes e independientes
    Comprender la fuerza de la correlación espacial

3) Estimación de autocorrelación

CAR bayesiano para la autocorrelación
SAR se utiliza máxima verosimilitud.

Los parámetros de autocorrelación positiva o negativa.


4) Estimación de otro parámetro de conectividad

Entender los efectos directos de variables en la autocorrelación.

Obtener la conectividad entre puntos por medio de lineas y nodos.


5) Predicción espacial

Encontramos tres tipos casos: 
    1) Parcelas entrevistadas con variable objetivo 
    2) Parcelas entrevistadas sin variable objetivo
    3) Parcelas no censadas.

6) Suavizado espacial

Los modelos autorregresivos se pueden utilizar para construir tasas ajustas a los valores cercanos del vecindario.

# Modelos autorregresivos y geoestadística

Utilizado modelo de regresión y GML.

Supuestos o propiedades:
    
Variable respuesta es independiente de las demás.

Cuando la variable respuesta se recopila en el espacio es muy común autocorrelación espacial.

En lugar de esparar independencia la autocorrelación espacial se modela a traves de la matriz de covarianza


Diferencia modelar puntos entre áreas. En puntos podemos determinar la correlación de las observaciones, en el caso de áreas tenemos datos agregados y necesitamos relacionar determinar un punto, por eso es que se utiliza la estrucura (red de conexiones entre unidades) entonces formamos una dependencia.

Modelos estadísticos están definidos por la distancia real (Matriz de varianza y covarianza), mientras que los modelos SAR y CAR definidos por vecinos y llamamos como matriz de precisión  (debido a la naturaleza no lineal de una matriz inversa).

Nuestros objetivos son como sigue: 
    (1) para explicar cómo se obtienen estos modelos, 
    (2)proporcionar información e intuición sobre cómo funcionan, 
    (3) paracomparar los modelos CAR y SAR, 
    (4) proporcionar prácticaspautas para su uso. Usando foca de puerto (Phoca vit-ulina) tendencias, proporcionamos un ejemplo para más Ilustración de los objetivos dados en la Tabla 1. 

Luego discutir temas importantes que han recibido poca atenciónción hasta ahora. 

Por ejemplo, hay poca orientación en la literatura el manejo de sitios aislados (no conectados), o cómopara elegir entre un modelo CAR y un caso especial deEl modelo CAR, el modelo intrínseco autorregresivo (IAR) Brindamos dicha orientación y terminamos con cincomensajes para llevar a casa que merecen más atención

Matriz.

Las relaciones espaciales para los modelos CAR y SAR son basado en un modelo gráfico, o una red, donde, usando terminología de modelos gráficos (p. ej., Lauritzen1996, Whittaker 2009), los sitios se denominan nodos (círculos enFig. 1) y las conexiones se llaman bordes (líneas en la Fig. 1).Los bordes se pueden definir de muchas maneras, pero es común enfoque es crear una ventaja entre las unidades contiguas en el espacio geográfico o cualquier espacio de red. Modificación estadística Los elementos basados en la estructura espacial gráfica a veces son conocidos como campos aleatorios de Gaussian Markov (por ejemplo, Ruey Held 2005). Para la notación, sea Y i una variable aleatoriacapaz de modelar observaciones en el i-ésimo nodo, dondei = 1, 2, ..., N, y todo Y i está contenido en el vector y.Luego considere el marco de regresión espacial


donde el objetivo es modelar una estructura media de primer ordenque incluye covariables (es decir, variables predictoras, X, mea-asegurado en los nodos) con coeficientes de regresión b, tambiéncomo un error espacial aleatorio latente z, donde z $ Nð0, RÞ,y error independiente e, donde e $ Nð0, r2e IÞ. Tenga en cuenta que z no se mide directamente, y en su lugar debe inferirse utilizando un modelo estadístico. El marco de regresión espacialel trabajo se convierte en un modelo espacial autorregresivo cuando elLa matriz de covarianza, Σ, para z, toma una de dos formas principales:
    
    (1) el modelo SAR
    (2) el modelo CAR

W es unpondera matriz y q controla la fuerza de la dependencia

Para ayudar a comprender los modelos autorregresivos, considerecorrelación parcial (p. ej., Snedecor y Cochran1980: 361), que es la idea de correlación entre dosvariables después de "controlar" o mantener fijos los valorespara todas las demás variables. Si RÀ1 ¼ X ¼ fx i, j g, entonces el par-La correlación de prueba entre las variables aleatorias Z i y Z j esÀx ij /ffiffiffiffiffiffiffiffiffiffiffix ii x jjpags(Lauritzen 1996: 120), que, por lo generaldatos distribuidos, es equivalente a dependencia condicional.Para el ejemplo de la Fig. 1 y la ecuación. 2, RÀ1 ¼ ðI À 0.2WÞy entonces la correlación parcial entre los sitios 1 y 2 es 0.2.


Por lo tanto, podemos ver que el modelo CAR, en particular,permite al modelador especificar directamente correlaciones parciales(o covarianzas), en lugar de la correlación (automática) directamente.Es decir, tenemos el control de especificar la diagonalvalores matriciales de W en RÀ1 ¼ r 2Z M À1 ðI À qWÞ, yPor lo tanto, estamos especificando las correlaciones parciales. losEl caso del modelo SAR es similar, aunque en lugar de directamenteespecificando correlaciones parciales, como se hace con ðI À CÞ enel modelo CAR, la especificación SAR involucra el modelo-ing una raíz cuadrada, ðI À BÞ, de la matriz de precisión. Estafa-en contraste con la geoestadística, donde tenemos el control deespecificando Σ, y por lo tanto especificamos directamente el (auto) -correlaciones En ambos casos, generalmente utilizamos un funcionalparametrización, en lugar de especificar cada entrada de matrizindividualmente. Para los modelos CAR y SAR, la especificacióna menudo se basa en vecinos (por ejemplo, correlación parcialexiste entre vecinos que comparten un límite, condicionestional en todos los otros sitios), y para geoestadística, la especificidadcatión se basa en la distancia (por ejemplo, la correlación depende deuna decadencia exponencial con la distancia). Para modelos CAR, sic ij = 0, entonces los sitios iyj no están correlacionados parcialmente; otro-sabio hay dependencia parcial. Tenga en cuenta que diagonal ele-mentos b ii y c ii son siempre cero. Para z (un SAR o CARvariable aleatoria) para tener una distribución estadística adecuada,q debe estar en un rango de valores que permita que ðI À BÞ tengaun inverso y ðI À CÞ para tener valores propios positivos; esees decir, q no se puede elegir arbitrariamente, y su rango dependesobre los pesos en W (más adelante, discutimos elementos de Wque no sean 0 y 1).

Las similitudes estadísticas entre el SAR y el CARlos modelos son obvios; ambos confían en un Gauss latenteespecificación, una matriz de pesos y un parámetro de correlacióneter. En ese sentido, los modelos SAR y CAR puedenser implementado de manera similar. Sin embargo, hay diferencias claveentre los modelos SAR y CAR que son fundamentalesmentalmente importante porque impactan la inferenciaobtenido de estos modelos. Como tal, describimos cadamodele con más detalle y brinde consejos prácticos

# Modelos SAR

# Modelos CAR

# CAR and SAR modelos jerarquicos


La estructura del vecindario de un modelo CAR o SARdepende de los nodos conectados en la red; estascasi siempre se definen como las unidades de área en las queuno tiene observaciones. Esta elección puede haber sido involuntariaconsecuencias, ya que implica que el proceso en estudio solo existe en las unidades de área especificadas. Esto sería apropiado, por ejemplo, cuando uno está modelando  una especie con una extensión geográfica conocida, y cuando la recopilación de datos ha abarcado todo gama de la especie. Como se señaló anteriormente, autorregresivo los modelos que usan estandarización de filas tienden a tener mayor varianza marginal en el perímetro de la red: esto corresponde con la suposición de que a menudo somos menos cierto sobre el estado de un sistema en sus límites que estamos en ubicaciones espaciales más centrales

Esta suposición tiene poco sentido cuando el sistema se está estudiando que se extiende más allá del rango espacial de estudio. En este caso, no hay una razón obvia para supongamos que se produciría una mayor varianza en el perímetro de la región de estudio. En cambio, sería más apropiado para extender el rango del efecto aleatorio espacial por creat-ing una región de amortiguación de unidades de área en el límite de la región de estudio (p. ej., Lindgren et al. 2011). Mientras estos unidades de área no tendrían observaciones asociadas con ellos, estabilizarían la varianza marginal del efecto aleatorio espacial, y sería apropiado siempre que se sepa que el proceso en estudio se extien demás allá del dominio espacial de los datos.

# Más ponderación: contabilidad para funcional y conectividad estructural

Ecología hay un interes de estudiar la conectividad espacial o demanera equivalente la autocorrelación espacial.

La idea de W es separar o aclarar componentes de la conectividad estructural y funcionales (funcional es por proximidad fisica)


# Comparación de CAR con SAR con pautas prácticas

-- Un modelo SAR se puede escribir como modelo CAR y viceversa.viceversa

Matriz de precisión. Por lo tanto, los modelos SAR tiene reputación como ser menos "local" (promediando más vecinos, causando más suavizado) que los modelos car.


**La correlación (en Σ, no correlación parcial) aumenta más rápidamente con modelos SAR que modelos CAR, que también es evidente cuando comparando la ecuación 3 a la ecuación 8)

SAR no requiere que sea simetrico en comparación con CAR.


# CAR y SAR en modelos jerárquicos

# Métodos de ajuste para modelos autorregresivos

Estimación de máxima verosimilitud es el método más utilizado pero es computacionalmente costoso. Para CAR Y SAR son adecuados los métodos de máxima verosimilitud.

Los modelos geoespaciales la dificultad son la inversión de la matriz de covarianza.
Método de matriz dispersa. 

Para modelos bayesianos se pueden utilizar técnicas de Monte Carlo MC, con CAR son directos por la especificación condicional.

Los modelos POISSON con los datos de una distribución de conteo, luego de utilizar el parámetro log tiene un modelo CAR / SAR para permitir una variación extra de Poisson que sea espacialmente. 
Tenga en cuenta que esto proporciona una probabilidad completa, a diferencia de la cuasi-probabilidad que menudo se utiliza para la sobredispersión de datos de conteo 


