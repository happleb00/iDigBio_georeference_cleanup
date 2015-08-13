
setwd("C:/Users/HLA/Desktop/R/iDigBio_georeference_cleanup")


### The iDigBio portal flag "dwc_country_replaced" finds localities where lat/lon is not in the given state or province.
### This code pulls out data of a specified country, or countries, organizes it, and saves to a text file.


# Calls data from the .csv file downloaded from the iDigBio portal and creates a dataframe of only columns relevant to locality.
SP_replaced_dat <- read.csv("input/dwc_stateprovince_replaced_raw.csv", header = TRUE, stringsAsFactors = FALSE)
SP_replaced <- SP_replaced_dat[c("dwc.locality","dwc.decimalLatitude","dwc.decimalLongitude","dwc.country","dwc.stateProvince","dwc.county")]
colnames(SP_replaced) <- c("Locality", "Latitude", "Longitude", "Country", "State_Province", "County")

# Creates a dataframe of entried from dwc_stateprovince_replaced by desired country
SP_replaced_subset <- subset(SP_replaced, (Country %in% c("United States","MEXICO","CANADA"))) #Replace "Country" with a country from the data set

# Creates a dataframe of unique localities in specified countries
SP_replaced_unique <- unique(SP_replaced_subset)

# Makes a unique list of states for for loop
SP_replaced_state_dat <- unique(SP_replaced_unique$State_Province)
SP_replaced_state <- sort(SP_replaced_state_dat, decreasing = FALSE)

# Writes a text file of locality data, of which the countries should be replaced, sorted by specified country, or countries
SP_replaced_df <- data.frame()
for (i in SP_replaced_state){
  SP_replaced_df <- rbind(SP_replaced_df, SP_replaced_unique[which(SP_replaced_unique$State==i),])
}
write.table(SP_replaced_df, file="output/SP_replaced.txt", sep="\t", append=FALSE, quote=FALSE)

