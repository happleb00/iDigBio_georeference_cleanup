
setwd("C:/Users/HLA/Desktop/R/iDigBio_georeference_cleanup")


### The iDigBio portal flag "dwc_country_replaced" finds localities where lat/lon is not in the given country.
### This code pulls out data of a specified country, or countries, organizes it, and saves to a text file.


# Calls data from the .csv file downloaded from the iDigBio portal and creates a dataframe of only columns relevant to locality.
country_replaced_dat <- read.csv("input/dwc_country_replaced_raw.csv", header = TRUE, stringsAsFactors = FALSE)
country_replaced <- country_replaced_dat[c("dwc.locality","dwc.decimalLatitude","dwc.decimalLongitude","dwc.country","dwc.stateProvince","dwc.county")]
colnames(country_replaced) <- c("Locality", "Latitude", "Longitude", "Country", "State_Province", "County")

# Creates a dataframe of entried from dwc_country_replaced by desired country
country_replaced_subset <- subset(country_replaced, (Country %in% c("Country"))) #Replace "Country" with a country from the data set

# Creates a dataframe of unique localitiesin specified countries
country_replaced_unique <- unique(country_replaced_subset)

# Makes a unique list of countries for for loop
country_replaced_country_dat <- unique(country_replaced_unique$Country)
country_replaced_country <- sort(country_replaced_country_dat, decreasing = FALSE)

# Writes a text file of locality data, of which the countries should be replaced, sorted by specified country, or countries
country_replaced_df <- data.frame()
for (i in country_replaced_country){
  country_replaced_df <- rbind(country_replaced_df, country_replaced_unique[which(country_replaced_unique$Country==i),])
}
write.table(country_replaced_df, file="output/country_replaced.txt", sep="\t", append=FALSE, quote=FALSE)

