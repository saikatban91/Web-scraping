library(rvest)
library(tidyverse)
# scraping qwerty for commercial kitchen info
webpage <- "http://www.qwerty.com/maps.php"
url <- read_html(webpage)
url_parent <- url %>% html_nodes("table")
url_nodes <- url_parent %>% html_nodes("br+ a")
names <- url_parent %>% html_nodes("br+ a") %>% html_text()
links <- url_parent %>% html_nodes("br+ a") %>% html_attr("href")
# found the parent node for kitcheninfos and extrcted the necessary info
parent_node <- url %>% html_nodes("div#kitcheninfos")
  names <-  sapply(parent_node, function(x){x %>% html_nodes("h1") %>% html_text(trim = T)})
  address <- sapply(parent_node, function(x){x %>% html_nodes("span.b") %>% html_text(trim = T)})
  email <- sapply(parent_node, function(x){x %>% html_nodes("span.e") %>% html_text(trim = T)})
  website <- sapply(parent_node, function(x){x %>% html_nodes("span.f") %>% html_text(trim = T)})
  kitchen_des <- sapply(parent_node, function(x){x %>% html_nodes("div.g") %>% html_text(trim = T)})
# Combine the data into a data structure and then export it
  commercial_kitchen_df <- cbind(names, address, email, website, kitchen_des)
  write.csv(commercial_kitchen_df, "US Commercial Kitchen master list with emails.csv")
# Export the non-duplicated records in a separate data structure
  no_dup_commercial_kitchen_df <- commercial_kitchen_df[(!duplicated(email)),]
dim(no_dup_commercial_kitchen_df)
# Export the dataframe as a csv file for the team to use
write.csv(commercial_kitchen_df, "No duplicates US Commercial Kitchen master list with emails.csv")
