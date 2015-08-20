
setwd("C:/Users/HLA/Desktop/R/iDigBio_georeference_cleanup")


### The iDigBio portal flag "geopoint_similar_coord" finds localities where the latitude & longitude are similar and one of them is incorrect.
### This code pulls out data of a specified country, or countries, organizes it, and saves to a text file.


# Calls data from the .csv file downloaded from the iDigBio portal and creates a dataframe of only columns relevant to locality.
similarcoord_dat <- read.csv("input/geopoint_similar_coord_raw.csv", header = TRUE, stringsAsFactors = FALSE)
similarcoord <- similarcoord_dat[c("dwc.locality","dwc.decimalLatitude","dwc.decimalLongitude","dwc.country","dwc.stateProvince","dwc.county")] ##organize by location data/georeference columns
colnames(similarcoord) <- c("Locality", "Latitude", "Longitude", "Country", "State_Province", "County")

# Subsets dataframe by desired country
similarcoord_subset <- subset(similarcoord, (Country %in% c("Country"))) #Replace "Country" with a country from the data set

# Creates a dataframe of unique localities
similarcoord_unique <- unique(similarcoord)

# Makes a unique list of states for for loop
similarcoord_state_dat <- unique(similarcoord_unique$State_Province)
similarcoord_state <- sort(similarcoord_state_dat, decreasing = FALSE)

# Writes a text file of locality data of which longitude signs should be reversed, sorted by state/province
similarcoord_df <- data.frame()
for (i in similarcoord_state){
  similarcoord_df <- rbind(similarcoord_df, similarcoord_unique[which(similarcoord_unique$State_Province==i),])
}
write.table(similarcoord_df, file="output/similarcoord.txt", sep="\t", append=FALSE, quote=FALSE)
