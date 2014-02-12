library (dismo)
## Not run:
library(rgdal)
# get a map using names
g = gmap('Brazil')
plot(g, inter=TRUE)
# or from an Extent object
e = extent( -50, -45 , -20, -15 )
# you can also get an Extent object by clicking on the map twice after using:
# drawExtent()
r = gmap(e)
plot(r, interpolate=TRUE)





model_glm<- glm (occ ~., data=variables, family = "binomial")
model_glm
summary (model_glm)
