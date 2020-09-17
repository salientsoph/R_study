site<- "https://comic.naver.com/genre/bestChallenge.nhn"
comicName<- NULL; comicSummary<- NULL; comicGrade<- NULL;

text <- read_html(site)

# 만화제목
node1 <- html_nodes(text, "div.challengeInfo > h6 > a")
comicName <- html_text(node1)

# 만화 설명
node2 <- html_nodes(text, "div.challengeInfo > div.summary")
comicSummary <- html_text(node2)

# 만화 별점
node3 <- html_nodes(text, "div.challengeInfo > div.rating_type > strong")
comicGrade <- html_text(node3)

# 데이터프레임
comicpage <- data.frame(comicName, comicSummary, comicGrade)
View(comicpage)

write.csv(comicpage, "navercomic.csv")