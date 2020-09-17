
# 한겨레 페이지(XML 패키지 사용)
library(XML)
library(rvest)  # read_html 때문에
imsi <- read_html("http://www.hani.co.kr/")
t <- htmlParse(imsi)
content<- xpathSApply(t,'//*[@id="main-top01-scroll-in"]/div/div/h4/a', xmlValue); 
# //*[@id="main-top01-scroll-in"]/div[2]/div/h4/a  
# -> 여기서 [2]만 뺐는데 데이터 끌어옴  -> "이 사이트는 정적 데이터 사용함"
content
content <- gsub("[[:punct:]]", "", content)  # -> 특수문자 빠짐
content


# httr 패키지 사용 - GET 방식 요청
library(httr)
http.standard <- GET('http://www.w3.org/Protocols/rfc2616/rfc2616.html')
title2 = html_nodes(read_html(http.standard), 'div.toc h2')
title2 = html_text(title2)
title2

# body > div > h2


# httr 패키지 사용 - GET 방식 굳이 안 써도 됨
title2 = html_nodes(read_html("http://www.w3.org/Protocols/rfc2616/rfc2616.html"), 'div.toc h2')
title2 = html_text(title2)
title2



# httr 패키지 사용 - POST 방식 요청 (rvest, xml 등으로는 불가. 꼭 httr 사용)
library(httr)
otp_url= 'http://marketdata.krx.co.kr/contents/COM/GenerateOTP.jspx'
parameter = list(
  name = 'fileDown',
  filetype = 'csv',
  url = 'MKD/03/0303/03030103/mkd03030103',
  tp_cd = 'ALL',
  date = '20190607',
  lang = 'ko',
  pagePath = '/contents/MKD/03/0303/03030103/MKD03030103.jsp')

my_otp = POST(otp_url, query = parameter)  
# opt 받고 10초 안에 끌어와야함

download_url = 'http://file.krx.co.kr/download.jspx'  
# -> url 인터넷창에 치는 건 get방식
data = POST(download_url, query = list(code = my_otp),
            add_headers(referer = otp_url)) 

library(readr)
data =  read_html(data) 
data = html_text(data)
data = read_csv(data)
as.data.frame(data)




# 뉴스, 게시판 등 글 목록에서 글의 URL만 뽑아내기 
res = GET('https://news.naver.com/main/list.nhn?mode=LSD&mid=sec&sid1=001')
htxt = read_html(res)
link = html_nodes(htxt, 'div.list_body a'); length(link)
# main_content > div.list_body.newsflash_body > ul.type06 > li:nth-child(6) > dl > dt:nth-child(2) > a
# main_content > div.list_body.newsflash_body > ul.type06 > li:nth-child(8) > dl > dt:nth-child(2) > a
article.href = unique(html_attr(link, 'href'))
article.href


# 이미지, 첨부파일 다운 받기 
# pdf 다운 
res = GET('http://cran.r-project.org/web/packages/httr/httr.pdf')
writeBin(content(res, 'raw'), 'c:/Temp/httr.pdf')
# writeBin & raw 형식 그대로 파일에 저장


# jpg
h = read_html('http://unico2013.dothome.co.kr/productlog.html')
imgs = html_nodes(h, 'img')
img.src = html_attr(imgs, 'src')  # 속성 찾기
for(i in 1:length(img.src)){
  res = GET(paste('http://unico2013.dothome.co.kr/',img.src[i], sep=""))
  writeBin(content(res, 'raw'), paste('c:/Temp/', img.src[i], sep=""))
} 



# SNS의 Open API 활용
library(httr)
library(rvest)
library(XML)

# rm(list=ls()) -> 지금까지 만들어놓은 객체들 삭제
searchUrl<- "https://openapi.naver.com/v1/search/blog.xml"
# 네이버에 개발자로 등록시, 네이버에서 제공하는 api로 정보를 저장하고 활용 가능함
Client_ID <- "izGsqP2exeThwwEUVU3x"
Client_Secret <- "WrwbQ1l6ZI"

# "봄"이라는 단어로 검색
# 한글을 %가 들어간 16진수 코드값으로 변경
query <- URLencode(iconv("봄","euc-kr","UTF-8"))  # query라는 검색어로 전달
url <- paste0(searchUrl, "?query=", query, "&display=100")
doc <- GET(url, add_headers("Content_Type" = "application/xml",
                            "X-Naver-client-Id" = Client_ID, "X-naver-Client-Secret" = Client_Secret))
# 요청 헤더를 지정. add_headers 함수로!



# 블로그 내용에 대한 리스트 만들기		
doc2 <- htmlParse(doc, encoding="UTF-8")
text<- xpathSApply(doc2, "//item/description", xmlValue)  # 조상이 누구던 item 아래 description 태그
text
# 검색어는 <b> (bold) 가 된 채로 출력됨
text <- gsub("</?b>", "", text)  
# <b> 없앰. 
# </?b> : <b> 또는 </b> 
# ?는 메타기호. 바로 앞에 있는 /가 1번 나올 수도, 안 나올 수도 있음 
text <- gsub("&.+t;", "", text)
# &.+t; : .과 +는 meta
# &과 t; 사이에 .+(어떤 문자열이 와도 상관 없음)\
# &at;, &abct;, &1t;, &111t; 등... & 와 t; 사이에 임의의 문자 1개 이상 
# 여기선 &quot; 를 없앰
text


# 네이버 뉴스 연동  
searchUrl<- "https://openapi.naver.com/v1/search/news.xml"
Client_ID <- "izGsqP2exeThwwEUVU3x"
Client_Secret <- "WrwbQ1l6ZI"
query <- URLencode(iconv("코로나","euc-kr","UTF-8"))
url <- paste0(searchUrl, "?query=", query, "&display=100")
doc <- GET(url, add_headers("Content_Type" = "application/xml",
                            "X-Naver-client-Id" = Client_ID, "X-naver-Client-Secret" = Client_Secret))

# 네이버 뉴스 내용에 대한 리스트 만들기		
doc2 <- htmlParse(doc, encoding="UTF-8")
text<- xpathSApply(doc2, "//item/description", xmlValue); 
text
text <- gsub("</?b>", "", text)
text <- gsub("&.+t;", "", text)
text


# 트위터 글 읽어오기
# install.packages("rtweet")
library(rtweet) 
appname <- "edu_data_collection"
api_key <- "RvnZeIl8ra88reu8fm23m0bST"
api_secret <- "wTRylK94GK2KmhZUnqXonDaIszwAsS6VPvpSsIo6EX5GQLtzQo"
access_token <- "959614462004117506-dkWyZaO8Bz3ZXh73rspWfc1sQz0EnDU"
access_token_secret <- "rxDWfg7uz1yXMTDwijz0x90yWhDAnmOM15R6IgC8kmtTe"
twitter_token <- create_token(
  app = appname,
  consumer_key = api_key,
  consumer_secret = api_secret,
  access_token = access_token,
  access_secret = access_token_secret)

key <- "취업"
key <- enc2utf8(key)
result <- search_tweets(key, n=100, token = twitter_token)
str(result)
result$retweet_text
content <- result$retweet_text
content <- gsub("[[:lower:][:upper:][:digit:][:punct:][:cntrl:]]", "", content)   
content



# 서울시 버스 정보
library(XML)
API_key  <- "%2BjzsSyNtwmcqxUsGnflvs3rW2oceFvhHR8AFkM3ao%2Fw50hwHXgGyPVutXw04uAXvrkoWgkoScvvhlH7jgD4%2FRQ%3D%3D"
bus_No <- "402"
url <- paste("http://ws.bus.go.kr/api/rest/busRouteInfo/getBusRouteList?ServiceKey=", API_key, "&strSrch=", bus_No, sep="")
doc <- xmlParse(url, encoding="UTF-8")
top <- xmlRoot(doc)
top
df <- xmlToDataFrame(getNodeSet(doc, "//itemList"))
df
str(df)
View(df)

busRouteId <- df$busRouteId
busRouteId


url <- paste("http://ws.bus.go.kr/api/rest/buspos/getBusPosByRtid?ServiceKey=", API_key, "&busRouteId=", busRouteId, sep="")
doc <- xmlParse(url, encoding="UTF-8")
top <- xmlRoot(doc)
top
df <- xmlToDataFrame(getNodeSet(doc, "//itemList"))
df
View(df)



# 서울시 빅데이터- XML 응답 처리
# http://openapi.seoul.go.kr:8088/796143536a756e69313134667752417a/xml/LampScpgmtb/1/100/

library(XML)
key = '796143536a756e69313134667752417a'
contentType = 'xml'
startIndex = '1'
endIndex = '200'
url = paste0('http://openapi.seoul.go.kr:8088/',key,'/',contentType,'/LampScpgmtb/',startIndex,'/',endIndex,'/')

con <- url(url, "rb") 
imsi <- read_html(con)
t <- htmlParse(imsi, encoding="UTF-8")
upNm<- xpathSApply(t,"//row/up_nm", xmlValue) 
pgmNm<- xpathSApply(t,"//row/pgm_nm", xmlValue)
targetNm<- xpathSApply(t,"//row/target_nm", xmlValue)
price<- xpathSApply(t,"//row/u_price", xmlValue)

df <- data.frame(upNm, pgmNm, targetNm, price)
View(df)
write.csv(df, "edu.csv")



# 한국은행 결제 통계시스템 Open API - JSON 응답 처리
install.packages("jsonlite")
library(jsonlite)
key = '/4WQ7X833TXC370SUTDX4/'
contentType = 'json/'
startIndex = '1'
endIndex = '/100/'

url <- paste0('http://ecos.bok.or.kr/api/KeyStatisticList',key,contentType,'kr/',startIndex,endIndex)
response <- GET(url)
json_data <- content(response, type = 'text', encoding = "UTF-8")
json_obj <- fromJSON(json_data)
df <- data.frame(json_obj)
df <- df[-1]  # 전처리(이름 너무 길어서 조금 줄임)
names(df) <- c("className", "unitName", "cycle", "keystatName", "dataValue")
View(df)


# 정규표현식 사용
word <- "JAVA javascript Aa 가나다 AAaAaA123 %^&*"
gsub(" ", "@", word); sub(" ", "@", word)
gsub("A", "", word) 
gsub("a", "", word) 
gsub("Aa", "", word) 
gsub("(Aa)", "", word) 
gsub("(Aa){2}", "", word);gsub("Aa{2}", "", word) 
# "JAVA javascript Aa 가나다 AAaAaA123 %^&*"
gsub("[Aa]", "", word) 
gsub("[가-힣]", "", word) 
gsub("[^가-힣]", "", word) 
gsub("[&^%*]", "", word) 
gsub("[[:punct:]]", "", word) 
gsub("[[:alnum:]]", "", word) 
gsub("[1234567890]", "", word) 
gsub("[0-9]", "", word) 
gsub("\\d", "", word); gsub("\\D", "", word)
gsub("[[:digit:]]", "", word) 
gsub("[^[:alnum:]]", "", word) 
gsub("[[:space:]]", "", word) 
gsub("[[:punct:][:digit:]]", "", word) 
gsub("[[:punct:][:digit:][:space:]]", "", word) 


