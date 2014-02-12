library (raster)
library (dismo)
library (rJava)
library (sp)
library (rgdal)


run_models<- function (species, variables)
{
  i<-0
  res<- list ()
  for (x in species)
  {
    i<-i+1
    print(length(species)-i)
    occ<- 
    
        #run models
        #bioclim, threshold=percentil 5
        model_bioclim<- bioclim (variables, occ)
        map_bioclim<- predict (model_bioclim, variables)
        map_bioclim_reclass<- reclassify (map_bioclim, c(-Inf, 0.05, 0, 0.05, 1, 1))
    
        tss_bio<- validate (map_bioclim_reclass, validation_occ, validation_abs)
        
        bioclim_model<- list (tss_bio= tss_bio, bioclim= model_bioclim)
        
        # run mahalanobis, threshold percentil 5
        model_maha<- mahal (variables, occ)
        map_maha<- predict (model_maha, variables)
        t<- quantile (extract (map_maha, occ), na.rm=T, 0.05)
        map_maha_reclass<- reclassify (map_maha, c(-Inf, t, 0, t, 1, 1))
        tss_maha<- validate(map_maha_reclass, validation_occ, validation_abs)
        maha_model<- list (tss_maha= tss_maha, maha= model_maha)
        
        model_maxent<- maxent (variables, occ)
        map_maxent<- predict (model_maxent, variables)
        t<- model_maxent@results [which (rownames (model_maxent@results)== "Maximum.training.sensitivity.plus.specificity.logistic.threshold")]
        map_maxent_reclass<- reclassify (map_maxent, c(-Inf, t, 0, t, 1, 1))
        tss_maxent<- validate(map_maxent_reclass, validation_occ, validation_abs)
        
        maxent_model<- list (tss_maxent= tss_maxent, maxent= model_maxent)
        
        res[[i]] <- list (bioclim=bioclim_model, mahalanobis= maha_model, maxent=maxent_model)
        names (res[[i]])<- c(species_name,
                             species_name,
                             species_name)
        
        if (length (res)==10){
          save (res, file = paste ("models_WC_", i, "res.RData", sep=""))
          exp<- exp+1
          res<- list()
        }
        
      }
    }
  }
}







