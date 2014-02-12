library (adehabitatHS)

##### necesitamos un dataframe con los datos del clima, tab
####  y un vector de 0/1 con la presencia, pr

## We then perform the PCA before the ENFA
pc <- dudi.pca(tab, scannf = FALSE)

## The object 'pc' contains the transformed table (i.e.
## centered so that all columns have a mean of 0
## and scaled so that all columns have a variance of 1
## 'pc' also contains the weights of the habitat variables,
## and the weights of the pixels in the analysis

(enfa1 <- enfa(pc, pr,
               scannf = FALSE))
hist(enfa1)
hist(enfa1, scores = FALSE, type = "l")


## scatterplot
scatter(enfa1)

## randomization test
## Not run: 
(renfa <- randtest(enfa1))
plot(renfa)

#### ahora, para predecir, 
### necesito que las variables estén en SpatialPixelDataFrame, map
data(meuse.grid)
head (meuse.grid)
map<-  SpatialPixelsDataFrame(points = meuse.grid[c("x", "y")], 
                            data = meuse.grid)



predict.enfa (enfa1, map)

pred <- predict(enfa1, map)
image(pred)

points(locs, pch = 16, cex=0.2)

??SpatialPixelDataFrame

?madifa

