library(rvest)

site<- "http://media.daum.net/ranking/popular/"
newstitle <- NULL; newspapername <- NULL

text <- read_html(site)

node1 <- html_nodes(text,"div.cont_thumb > strong > a")
newstitle <- html_text(node1)

node2 <- html_nodes(text, "div.cont_thumb > strong > span")
newspapername <- html_text(node2)

newspage <- data.frame(newstitle, newspapername)
View(newspage)

write.csv(newspage, "daumnews.csv")