
setwd("C:/Users/HLA/Desktop/R/iDigBio_data_cleaning")


### The iDigBio portal flag "rev_geocode_mismatch" finds localities where the lat/lon is incorrect.
### This code pulls out data of a specified country, or countries, organizes it, and saves to a text file.


# Calls data from the .csv file downloaded from the iDigBio portal and creates a dataframe of only columns relevant to locality.
mismatch_dat <- read.csv("input/rev_geocode_mismatch_raw.csv", header = TRUE, stringsAsFactors = FALSE)
mismatch <- mismatch_dat[c("dwc.locality","dwc.decimalLatitude","dwc.decimalLongitude","dwc.country","dwc.stateProvince","dwc.county")] ##organize by location data/georeference columns
colnames(mismatch) <- c("Locality", "Latitude", "Longitude", "Country", "State_Province", "County")

# Subsets dataframe by desired country
mismatch_subset <- subset(mismatch, (Country %in% c("Country"))) #Replace "Country" with a country from the data set

# Creates a dataframe of unique localities
mismatch_unique <- unique(mismatch_subset)

# Makes a unique list of states for for loop
NA_mismatch_dat <- unique(mismatch_unique$State_Province)
NA_mismatch <- sort(NA_mismatch_dat, decreasing = FALSE)

# Writes a text file of locality data of which lat/lon should be changed, sorted by state/province
mismatch_df <- data.frame()
for (i in NA_mismatch){
  mismatch_df <- rbind(mismatch_df, mismatch_unique[which(mismatch_unique$State_Province==i),])
}
write.table(mismatch_df, file="output/mismatch.txt", sep="\t", append=FALSE, quote=FALSE)

