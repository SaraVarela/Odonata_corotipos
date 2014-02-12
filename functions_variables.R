cut_variables<- function (dir, raster_pattern, xmin, xmax, ymin, ymax)
  {
  setwd (dir)
  variables<- list.files (dir, 
                          pattern=raster_pattern)
  
  var_stack<- raster (variables [1])
  for (x in variables [-1]){
    var<- raster (x)
    var_stack<- stack(var_stack, var) 
  }
  e <- extent(xmin, xmax, ymin, ymax)
  variables_crop <- crop(var_stack, e)
  variables_crop
  }


save_rasters<- function (dir_save, number_of_variables, format_out)
{
for (i in 1:number_of_variables){
  writeRaster(miroc_am [[i]], 
              paste (dir_save, "/bio" ,i,".asc", sep=""), 
              format = format_out)
}
