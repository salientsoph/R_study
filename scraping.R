url<- "http://unico2013.dothome.co.kr/crawling/exercise_bs.html"
text <- read_html(url)

node1 <- html_nodes(text, "h1")
html_text(node1)

node2 <- html_nodes(text, xpath="/html/body/a")
html_attr(node2, "href")

node3 <- html_nodes(text, xpath="/html/body/a[5]/img")
html_attr(node3, "src")

node4 <- html_nodes(text, "body > h2:nth-child(9)")
html_text(node4)

node5 <- html_nodes(text, xpath="//*[@style='color:green']")
html_text(node5)

node6 <- html_nodes(text, "body > h2:nth-child(11)")
html_text(node6)

node7 <- html_nodes(text, xpath="/html/body/ol/*")
html_text(node7)


node8 <- html_nodes(text, xpath="/html/body/table//*")
html_text(node8)


node9 <- html_nodes(text, xpath="//*[@class='name']")
html_text(node9)


node10 <- html_nodes(text, xpath="//*[@id='target']")
html_text(node10)