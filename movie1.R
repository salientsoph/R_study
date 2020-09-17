site<- "https://movie.daum.net/moviedb/grade?movieId=131576"
text <- NULL
movie.review <- NULL

url <- paste(site, i, sep="")
text <- read_html(url)

nodes <- html_nodes(text, "div.raking_grade > span")
point <- html_text(nodes)

nodes <- html_nodes(text, "div.movie_review")
review <- html_text(nodes, trim=TRUE)

page <- data.frame(point, review)
View(page)

write.csv(page, "daummovie1.csv")