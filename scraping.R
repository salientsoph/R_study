url<- "http://unico2013.dothome.co.kr/crawling/exercise_bs.html"
text <- read_html(url)

#01. <h1> 태그의 컨텐츠 
node1 <- html_nodes(text, "h1")
html_text(node1)

#02. <a> 태그의 컨텐츠와 href 속성값
node2 <- html_nodes(text, xpath="/html/body/a")
html_attr(node2, "href")

#03. <img> 태그의 src 속성값
node3 <- html_nodes(text, xpath="/html/body/a[5]/img")
html_attr(node3, "src")

#04. 첫 번째 <h2> 태그의 컨텐츠
node4 <- html_nodes(text, "body > h2:nth-child(9)")
html_text(node4)

#05. <ul> 태그의 자식 태그들 중 style 속성의 값이 green으로 끝나는 태그의 컨텐츠
node5 <- html_nodes(text, xpath="//*[@style='color:green']")
html_text(node5)

#06. 두 번째 <h2> 태그의 컨텐츠
node6 <- html_nodes(text, "body > h2:nth-child(11)")
html_text(node6)

#07. <ol> 태그의 모든 자식 태그들의 컨텐츠 
node7 <- html_nodes(text, xpath="/html/body/ol/*")
html_text(node7)

#08. <table> 태그의 모든 자손 태그들의 컨텐츠 
node8 <- html_nodes(text, xpath="/html/body/table//*")
html_text(node8)

#09. name이라는 클래스 속성을 갖는 <tr> 태그의 컨텐츠
node9 <- html_nodes(text, xpath="//*[@class='name']")
html_text(node9)

#10. target이라는 아이디 속성을 갖는 <td> 태그의 컨텐츠
node10 <- html_nodes(text, xpath="//*[@id='target']")
html_text(node10)




# 다른 풀이 1

url <- "http://unico2013.dothome.co.kr/crawling/exercise_bs.html"
text <- read_html(url)
text
#<h1> 태그의 컨텐츠
html_text(html_nodes(text, "h1"))

# <a> 태그의 컨텐츠
html_text(html_nodes(text, "a"))

# <a> 태그의 href 속성값
html_attr(html_nodes(text, "a"), "href")

# <img> 태그의 src 속성값
html_attr(html_nodes(text, "img"), "src")

# 첫 번째 <h2> 태그의 컨텐츠
html_text(html_nodes(text, "h2:nth-of-type(1)"))

# <ul> 태그의 자식 태그들 중 style 속성의 값이 green으로 끝나는 태그의 컨텐츠
html_text(html_nodes(text, "ul > [style$=green]"))

#두 번째 <h2> 태그의 컨텐츠
html_text(html_nodes(text, "h2:nth-of-type(2)"))

#<ol> 태그의 모든 자식 태그들의 컨텐츠 
html_text(html_nodes(text, "ol > *"))

#<table> 태그의 모든 자손 태그들의 컨텐츠
html_text(html_nodes(text, "table *"))

#name이라는 클래스 속성을 갖는 <tr> 태그의 컨텐츠
html_text(html_nodes(text, "tr[class=name]"))

#target이라는 아이디 속성을 갖는 <td> 태그의 컨텐츠
html_text(html_nodes(text, "td#target"))

nodes <- html_nodes(text, "body > table > tr > td")
nodes
name <- html_text(nodes)
name



# 다른 풀이 2
library(rvest)
url <- "http://unico2013.dothome.co.kr/crawling/exercise_bs.html"
text <- read_html(url)

#1
node_h1 <- html_nodes(text, "h1")
content_h1 <- html_text(node_h1); content_h1

#2
node_a <- html_nodes(text, "a")
content_a <- html_text(node_a, trim = T)
attr_a <- html_attr(node_a, "href"); attr_a

#3
node_img <- html_nodes(text, "img")
attr_img <- html_attr(node_img, "src"); attr_img

#4
node_first_h2 <- html_nodes(text, "h2:nth-of-type(1)")
content_first_h2 <- html_text(node_first_h2); content_first_h2

#5
node_ul <- html_nodes(text, "ul>*[style='color:green']")
content_h2 <- html_text(node_ul); content_h2

#6
node_second_h2 <- html_nodes(text, "h2:nth-of-type(2)")
content_second_h2 <- html_text(node_second_h2); content_second_h2

#7 <ol> 태그의 모든 자식 태그들의 컨텐츠 
node_ol <- html_nodes(text, "ol>*")
content_ol <- html_text(node_ol); content_ol

#8 <table> 태그의 모든 자손 태그들의 컨텐츠
node_table <- html_nodes(text, "table *")
content_table <- html_text(node_table); content_table

#9 name이라는 클래스 속성을 갖는 <tr> 태그의 컨텐츠
node_tr <- html_nodes(text, "tr.name")
content_tr <- html_text(node_tr); content_tr

#10 target이라는 아이디 속성을 갖는 <td> 태그의 컨텐츠
node_td <- html_nodes(text, "td#target")
content_td <- html_text(node_td); content_td