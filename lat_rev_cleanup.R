
setwd("C:/Users/HLA/Desktop/R/iDigBio_georeference_cleanup")


### The iDigBio portal flag "rev_geocode_flip_lat_sign" finds localities where the latitude sign is incorrect.
### This code pulls out data of a specified country, or countries, organizes it, and saves to a text file.


# Calls data from the .csv file downloaded from the iDigBio portal and creates a dataframe of only columns relevant to locality.
latrev_dat <- read.csv("input/rev_geocode_flip_lat_sign_raw.csv", header = TRUE, stringsAsFactors = FALSE)
latrev <- latrev_dat[c("dwc.locality","dwc.decimalLatitude","dwc.decimalLongitude","dwc.country","dwc.stateProvince","dwc.county")] ##organize by location data/georeference columns
colnames(latrev) <- c("Locality", "Latitude", "Longitude", "Country", "State_Province", "County")

# Subsets dataframe by desired country
latrev_subset <- subset(latrev, (Country %in% c("Country"))) #Replace "Country" with a country from the data set

# Creates a dataframe of unique localities
latrev_unique <- unique(latrev_subset)

# Makes a unique list of states for for loop
latrev_state_dat <- unique(latrev_unique$State_Province)
latrev_state <- sort(latrev_state_dat, decreasing = FALSE)

# Writes a text file of locality data of which latitude signs should be reversed, sorted by state/province
latrev_df <- data.frame()
for (i in latrev_state){
  latrev_df <- rbind(latrev_df, latrev_unique[which(latrev_unique$State_Province==i),])
}
write.table(latrev_df, file="output/latrev.txt", sep="\t", append=FALSE, quote=FALSE)

