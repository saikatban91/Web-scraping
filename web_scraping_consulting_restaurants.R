#loading rvest library for scraping 
library(rvest)
library(tidyverse)
# website loading; this is a random website and the identity of the original website 
# used for this purpose cannot be shared publicly at this point
webpage <- "https://www.abcde.com/search?search_terms=xyz&geo_location_terms=pqrst%2C%20AB&s=default"
res_html <- read_html(webpage)
# Selectorgadget coupled with html analysis of the webpage gave us the CSS; the nodes are converted into text 
# Only 30 are chosen because rest of them include sponsored advertisements from the site
res_name <- res_html %>% html_nodes(".business-name") %>% html_text(trim = T) %>% .[1:30]
res_links <- res_html %>% html_nodes(".business-name") %>% html_attr("href") %>% .[1:30]

# A default data frame with the required variables scraped from the webpage
res <- data.frame(res_name, res_links)

# After the first page is scraped, the following pages have urls that can be put into a pattern as shown in the following loop.
# There were 5 pages altogether that needed scraping. 
for(i in 2:5){
 # The required urls are constructed and read in using read_html function from rvest library. 
  web_temp <- paste0(webpage, "&page=", i)
  html_temp <- read_html(web_temp)
 #  Rest of the variables are obtained just like for the first page. The values are stored in a temporary variable for each elements.
  # The 
  res_name <-  html_temp %>% html_nodes(".business-name") %>% html_text(trim = T) %>% .[1:30]
  res_links <-  html_temp %>% html_nodes(".business-name") %>% html_attr("href") %>% .[1:30]

  # A temporary data frame is used to store the sets of variables just like for the first page.
  temp_res <- data.frame(res_name, res_links)
  # In the end, the temporary sets of values are appended to the previous ones until we are done.
  res <- rbind(res, temp_res)
}
# 2nd part of the code where each listing is individually scraped for info
res_links <- res$res_links
res_urls <- paste0("https://www.abcde.com", res_links)
# a test before final scraping exercise
web_test <- "https://www.abcde.com/weretet-AB/xxfg/er456gdbddbdbdb"
web_url <- read_html(web_test)
# Parent nodes for name of the restaurant and their respective email addresses are extracted 
# from different nodes of the webpage. This is done to avoid extacting multiple emails from 
# one listing because it becomes very hard to merge the data in a data frame later
# Work is underway to resolve this issue.
email_node <- web_url %>% html_nodes("div.business-card-footer") 
name_node <- web_url %>% html_nodes("article")
name_node %>% html_nodes("div.sales-info") %>% html_text(trim = T)
email_node %>% html_nodes("a.email-business") %>% html_attr("href")

# for loop for scraping all the listings after test above gives positive results
names <- c()
emails <- c()
for(i in 1:150){
web_url <- read_html(res_urls[i])
name_node <- web_url %>% html_nodes("article")
email_node <- web_url %>% html_nodes("div.business-card-footer")
names[i] <- sapply(name_node, function(x){x %>% html_nodes("div.sales-info") %>% html_text(trim = T)})
emails[i] <- sapply(email_node, function(x){x %>% html_nodes("a.email-business") %>% html_attr("href")})

Sys.sleep(20)

}
