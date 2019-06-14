library(tidyverse)

pre1 <- read_csv("072918pre.csv")
pre2 <- read_csv("080518_pre.csv")
pre3 <- read_csv("081218_pre.csv")
pre4 <- read_csv("082018_pre.csv")

pre <- rbind(pre1, pre2, pre3, pre4)
write.csv(pre, "pre_final.csv")

pre_top_users <- pre %>% group_by(screenName) %>% 
  summarise(no. = n()) %>% arrange(desc(no.)) %>%
  .[1:10,] 

write_csv(pre_top_users, "pre_top_users.csv")

names(pre_top_users) <- c("User", "Tweets")

with(pre_top_users )barplot(pre_top_users, names = User, horiz = T, las = 1,
        main = "Top 10: Prebiotics tweets per user", col = 1)

pre <- pre %>% mutate(Type = "Prebiotics")

pro1 <- read_csv("072918pro.csv")
pro2 <- read_csv("080518_pro.csv")
pro3 <- read_csv("081218_pro.csv")
pro4 <- read_csv("082018_pro.csv")

range(pre$created)
pro <- rbind(pro1, pro2, pro3, pro4)
write.csv(pro, "pro_final.csv")
pro <- pro %>% mutate(Type = "Probiotics")

pro_top_users <- pro %>% group_by(screenName) %>% 
  summarise(no. = n()) %>% arrange(desc(no.)) %>%
  .[1:10,] 

dim(pro)
dim(pre)

write_csv(pro_top_users, "pro_top_users.csv")

total <- rbind(pre, pro)

ggplot(data = total, aes(x = created)) +
  geom_histogram() + facet_wrap(~ Type) +
  scale_x_datetime("Date") + scale_y_continuous("Frequency") +
  ggtitle("#Prebiotics vs #Probiotics mention on Twitter Jul19 - Aug20, 2018") +
  theme(plot.title = element_text(hjust = 0.5))

  
