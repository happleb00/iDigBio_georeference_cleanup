
setwd("C:/Users/HLA/Desktop/R/iDigBio_georeference_cleanup")


### The iDigBio portal flag "rev_geocode_eez" finds localities where the centrad point is in an ocean or along the coast.
### This code pulls out data of a specified country, or countries, organizes it, and saves to a text file.


# Calls data from the .csv file downloaded from the iDigBio portal and creates a dataframe of only columns relevant to locality.
eez_dat <- read.csv("input/rev_geocode_eez_raw.csv", header = TRUE, stringsAsFactors = FALSE)
eez <- eez_dat[c("dwc.locality","dwc.decimalLatitude","dwc.decimalLongitude","dwc.country","dwc.stateProvince","dwc.county")] ##organize by location data/georeference columns
colnames(eez) <- c("Locality", "Latitude", "Longitude", "Country", "State_Province", "County")

# Subsets dataframe by desired country
eez_subset <- subset(eez, (Country %in% c("Country"))) #Replace "Country" with a country from the data set

# Creates a dataframe of unique localities
eez_unique <- unique(eez_subset)

# Makes a unique list of states for for loop
eez_state_dat <- unique(eez_unique$State_Province)
eez_state <- sort(eez_state_dat, decreasing = FALSE)

# Writes a text file of locality data of which the centrad should be moved inland.
eez_states <- data.frame()
for (i in eez_state){
  eez_states <- rbind(eez_states, eez_unique[which(eez_unique$State_Province==i),])
}
write.table(eez_states, file="output/eezes.txt", sep="\t", append=FALSE, quote=FALSE)

