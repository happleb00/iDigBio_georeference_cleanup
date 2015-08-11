
setwd("C:/Users/HLA/Desktop/R/iDigBio_data_cleaning")


### The iDigBio portal flag "rev_geocode_flip_lon_sign" finds localities where the longitude sign is incorrect.
### This code pulls out data of a specified country, or countries, organizes it, and saves to a text file.


# Calls data from the .csv file downloaded from the iDigBio portal and creates a dataframe of only columns relevant to locality.
lonrev_dat <- read.csv("input/rev_geocode_flip_lon_sign_raw2.csv", header = TRUE, stringsAsFactors = FALSE)
lonrev <- lonrev_dat[c("dwc.locality","dwc.decimalLatitude","dwc.decimalLongitude","dwc.country","dwc.stateProvince","dwc.county")] ##organize by location data/georeference columns
colnames(lonrev) <- c("Locality", "Latitude", "Longitude", "Country", "State_Province", "County")

# Subsets dataframe by desired country
lonrev_subset <- subset(lonrev, (Country %in% c("Country"))) #Replace "Country" with a country from the data set

# Creates a dataframe of unique localities
lonrev_unique <- unique(lonrev_subset)

# Makes a unique list of states for for loop
lonrev_state_dat <- unique(lonrev_unique$State_Province)
lonrev_state <- sort(lonrev_state_dat, decreasing = FALSE)

# Writes a text file of locality data of which longitude signs should be reversed, sorted by state/province
lonrev_df <- data.frame()
for (i in lonrev_state){
  lonrev_df <- rbind(lonrev_df, lonrev_unique[which(lonrev_unique$State_Province==i),])
}
write.table(lonrev_df, file="output/lonrev.txt", sep="\t", append=FALSE, quote=FALSE)

