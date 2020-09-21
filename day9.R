install.packages("RSelenium")
library(RSelenium)
remDr <- remoteDriver(remoteServerAddr = "localhost" , port = 4445, browserName = "chrome")
remDr$open()

# 이해를 돕기 위해 간단한 웹페이지를 크롤링하고 스크래핑 함
url <- "http://unico2013.dothome.co.kr/crawling/tagstyle.html"
remDr$navigate(url)

#단수형으로 노드 추출 using=css 나 using=css selector 나 동일함
one<-remDr$findElement(using='css','div') # 노드 한 개 리턴(webElement 객체) -> div태그 중 첫번째 div만 
one$getElementTagName()
one$getElementText()

# 단수형으로 없는 노드 추출
one<-NULL
one<-remDr$findElement(using='css','p') # 찾는 대상이 없으면 오류 발생(여기서 p 태그 없음)


# 만일 오류 발생을 무시하고 싶어서 사용하지만 소용없음, 외부 라이브러리 사용 때문이라 추정(^^)
# 없을 수도 있으면 복수형(findElements()) 사용할것
one<-NULL
try(one<-remDr$findElement(using='css','p')) 


#복수형으로 노드 추출
more<-remDr$findElements(using='css','div')
sapply(more, function(x) x$getElementTagName())
sapply(more, function(x) x$getElementText())


#복수형으로 없는 추출
more<-remDr$findElements(using='css','p') # 없으면 오류가 발생하지 않음 비어있는 리스트 리턴
print(more)  
if(length(more) == 0) 
  cat("<p> 태그는 없슈\n")
sapply(more, function(x) x$getElementTagName())
sapply(more, function(x) x$getElementText())


install.packages("base64enc")
install.packages("magick")
library(base64enc)  # 문자열로 변환된 이미지를 읽어서 이미지로 활용
library(magick)   # 하드디스크에 있는 이미지 파일을 읽어서 처리


remDr <- remoteDriver(remoteServerAddr = "localhost", port=4445, browserName="chrome")
remDr$open()
remDr$navigate("https://google.com")


# this returns a list of base64 characters
screenshot <- remDr$screenshot(display = FALSE)
# converts the base64 characters into a vector
screenshot <- base64decode(toString(screenshot), output = NULL)  # 문자열로 tostring해서 변환
# reads the vector as stores it as a PNG
screenshot <- image_read(screenshot)
image_browse(screenshot)


remDr$screenshot(display = FALSE, file="c:/Temp/google.png")
pngdata <- image_read("c:/Temp/google.png")
image_browse(pngdata)  # 이미지의 확장자 변환 




# 네이버 북 페이지 이번주 베스트 북정보 크롤링

site <- "https://book.naver.com/"
remDr$navigate(site)

#bestseller_tab

booksitenodes <- remDr$findElements(using='css', '#bestseller_tab > ul.tab_cp_spt > li > a')
booksites <- sapply(booksitenodes, function(x) {x$getElementAttribute("class")})  # 백터로 가져옴
booksites <- unlist(booksites); 
booksites <- unlist(strsplit(booksites, ' '))  #strsplit는 리스트라 다시 unlist
size <- length(booksites)  # 총 갯수가 몇개인지(16개(2배로 나왔음))
booksites <- booksites[seq(1, size, 2)]  #홀수번째만 뽑아냄


for (booksite in booksites) {
  booksitenode <- remDr$findElement(using='css', paste0('#tab_cp_spt_',booksite))
  booksitenode$clickElement()
  Sys.sleep(2)

  # 책에 대한 썸네일 이미지 url -> img 태그 읽어서 src속성 읽음
  bookthumbenodes <- remDr$findElements(using='css', '#bestseller_list dl>dt:nth-child(1) img')
  bookthumburl <- sapply(bookthumbenodes, function(x) {x$getElementAttribute("src")})
  bookthumburl <- unlist(bookthumburl)
  
  # 책 이름 -> content 읽음(두 줄이라면 한 줄로)
  booktitlenodes <- remDr$findElements(using='css', '#bestseller_list dl>dt:nth-child(2)>a')
  booktitle <- sapply(booktitlenodes, function(x) {x$getElementText()})
  booktitle <- gsub("[[:cntrl:]]", "", booktitle)
  
  # book이라는 폴더가 없으면 새로 만듦
  df <- data.frame(bookthumburl, booktitle)
  if (!dir.exists('book'))  
    dir.create('book')
  print(df)
  write.csv(df, file=paste0('book/', booksite, '.csv'))
}
getwd()






# 편의점 

site <- 'http://gs25.gsretail.com/gscvs/ko/products/event-goods'
remDr$navigate(site)

# 상품명
eventgoodsnodes <- remDr$findElements(using='css', '#contents > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(3) > ul > li > div > p.tit')
eventgoodsname <- sapply(eventgoodsnodes, function(x) {x$getElementText()})

# 가격
eventgoodsnodes <- remDr$findElements(using='css', '#contents > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(3) > ul > li > div > p.price > span')
eventgoodsprice <- sapply(eventgoodsnodes, function(x) {x$getElementText()})





# [ YES24의 명견만리 댓글 읽어오기 ]

library(RSelenium)
remDr <- remoteDriver(remoteServerAddr = "localhost", port = 4445, browserName = "chrome")
remDr$open()
remDr$navigate("http://www.yes24.com/24/goods/40936880")


webElem <- remDr$findElement("css", "body")
remDr$executeScript("scrollTo(0, 0)", args = list(webElem))
Sys.sleep(1)
remDr$executeScript("scrollBy(0, 3200)", args = list(webElem))
Sys.sleep(1)
remDr$executeScript("scrollBy(0, 3200)", args = list(webElem))
Sys.sleep(1)
remDr$executeScript("scrollBy(0, 3200)", args = list(webElem))
Sys.sleep(3)
repl_v = NULL
endFlag <- FALSE
page <- 3

repeat {
  for(index in 3:7) {
    fullContentLinkCSS <- paste("#infoset_reviewContentList > div:nth-child(",index,") > div.reviewInfoBot.crop > a", sep='')
    fullContentLink<-remDr$findElements(using='css selector',  fullContentLinkCSS)
    if (length(fullContentLink) == 0) {
      # 더보기가 없다면 
      cat("종료\n")
      endFlag <- TRUE
      break
    }
    remDr$executeScript("arguments[0].click();",fullContentLink);
    Sys.sleep(1)
    fullContentCSS <- paste("#infoset_reviewContentList > div:nth-child(",index,") > div.reviewInfoBot.origin > div.review_cont > p", sep='')
    fullContent<-remDr$findElements(using='css selector', fullContentCSS)
    repl <-sapply(fullContent,function(x){x$getElementText()})    
    print(repl)
    cat("---------------------\n")
    repl_v <- c(repl_v, unlist(repl))
  }
  if(endFlag)
    break;  
  
  if(page == 10){
    page <- 3
    nextPageCSS <- "#infoset_reviewContentList > div.review_sort.sortTop > div.review_sortLft > div > a.bgYUI.next"
  }
  else{
    page <- page+1;
    nextPageCSS <- paste("#infoset_reviewContentList > div.review_sort.sortBot > div.review_sortLft > div > a:nth-child(",page,")",sep="")
  }
  remDr$executeScript("scrollTo(0, 0)", args = list(webElem))
  nextPageLink<-remDr$findElements(using='css selector',nextPageCSS) 
  remDr$executeScript("arguments[0].click();",nextPageLink);
  #sapply(nextPageLink,function(x){x$clickElement()})  
  Sys.sleep(3)
  print(page)
}
write(repl_v, "yes24.txt")







# 스타벅스

library(RSelenium)

remDr <- remoteDriver(remoteServerAddr = "localhost", port = 4445, browserName = "chrome")
remDr$open()
remDr$navigate("https://www.istarbucks.co.kr/store/store_map.do?disp=locale")

selectSeoul <- "#container > div > form > fieldset > div > section > article.find_store_cont > article > article:nth-child(4) > div.loca_step1 > div.loca_step1_cont > ul > li:nth-child(1) > a"
nextPageLink<-remDr$findElements(using='css selector',selectSeoul)  
sapply(nextPageLink,function(x){x$clickElement()})

selectAll <- paste("#mCSB_2_container > ul > li:nth-child(1) > a")
nextPageLink<-remDr$findElements(using='css selector',selectAll)  
sapply(nextPageLink,function(x){x$clickElement()})

sizeCss <- "#container > div > form > fieldset > div > section > article.find_store_cont > article > article:nth-child(4) > div.loca_step3 > div.result_num_wrap > span"
size <- remDr$findElements(using='css selector',sizeCss)
limit <-sapply(size,function(x){x$getElementText()})    

nameList <- NULL
addressList <- NULL
phoneList <- NULL
latList <- NULL
longList <- NULL

for(i in 1 : as.numeric(limit)){
  nameCss <- paste("#mCSB_3_container > ul > li:nth-child(",i,")  > strong", sep = '')
  nameLink <- remDr$findElements(using='css selector',nameCss)
  a <- sapply(nameLink,function(x){x$getElementText()})
  nameList <- c(nameList, unlist(a))
  
  infoCss <- paste("#mCSB_3_container > ul > li:nth-child(",i,")  > p", sep = '')
  infoLink <- remDr$findElements(using='css selector',infoCss)
  a <- sapply(infoLink,function(x){x$getElementText()})
  words = strsplit(unlist(a), split="\n")
  addressList <- c(addressList, words[[1]][1])
  phoneList <- c(phoneList, words[[1]][2])
  
  pointCss <- paste("#mCSB_3_container > ul > li:nth-child(",i,")", sep = '')
  pointLink <- remDr$findElements(using='css selector',pointCss)
  latList <- c(latList, sapply(pointLink, function(x){x$getElementAttribute('data-lat')}))
  longList <- c(longList, sapply(pointLink, function(x){x$getElementAttribute('data-long')}))
  
  if(i %% 3 == 0 && i != as.numeric(limit)){
    remDr$executeScript("var su = arguments[0]; var dom = document.querySelectorAll('#mCSB_3_container > ul > li')[su]; dom.scrollIntoView();", list(i))
  }
}








# 스타벅스 

library(RSelenium)

remDr <- remoteDriver(remoteServerAddr = "localhost", port=4445, browserName="chrome")
remDr$open()

site <- paste("https://www.istarbucks.co.kr/store/store_map.do?disp=locale")
remDr$navigate(site)

Sys.sleep(3)

#서울 클릭
btn1Css <- "#container > div > form > fieldset > div > section > article.find_store_cont > article > article:nth-child(4) > div.loca_step1 > div.loca_step1_cont > ul > li:nth-child(1) > a"
btn1Page <- remDr$findElements(using='css',btn1Css)
sapply(btn1Page,function(x){x$clickElement()})
Sys.sleep(3)

#전체 클릭
btn2Css <- "#mCSB_2_container > ul > li:nth-child(1) > a"
btn2Page <- remDr$findElements(using='css',btn2Css)
sapply(btn2Page,function(x){x$clickElement()})
Sys.sleep(3)

index <- 0
starbucks <- NULL
total <- sapply(remDr$findElements(using='css',"#container > div > form > fieldset > div > section > article.find_store_cont > article > article:nth-child(4) > div.loca_step3 > div.result_num_wrap > span"),function(x){x$getElementText()})

repeat{
  index <- index + 1
  print(index)
  
  storeCss <- paste0("#mCSB_3_container > ul > li:nth-child(",index,")")
  storePage <- remDr$findElements(using='css',storeCss)
  if(length(storePage) == 0) 
    break
  storeContent <- sapply(storePage,function(x){x$getElementText()})
  
  #스타벅스 정보 추출
  #strsplit(storeContent, split="\n")
  storeList <- strsplit(unlist(storeContent), split="\n")
  shopname <- storeList[[1]][1]
  addr <- storeList[[1]][2]
  addr <- gsub(",", "", addr)
  telephone <- storeList[[1]][3]
  
  #스타벅스 위도 경도 추출
  lat <- sapply(storePage,function(x){x$getElementAttribute("data-lat")})
  lng <- sapply(storePage,function(x){x$getElementAttribute("data-long")})
  
  #병합
  starbucks <- rbind(starbucks ,cbind(shopname, addr, telephone, lat, lng))
  
  #스크롤 다운
  if(index %% 3 == 0 && index != total)
    remDr$executeScript("var dom=document.querySelectorAll('#mCSB_3_container > ul > li')[arguments[0]]; dom.scrollIntoView();", list(index))
}
write.csv(starbucks, "starbucks.csv")


paste0("#mCSB_3_container > ul > li")
storePage <- remDr$findElements(using='css',"#mCSB_3_container > ul > li")
length(storePage)

storeContent <- sapply(storePage,function(x){x$getElementText()})

write(unlist(storeContent), file="result.txt")
head(storeContent, 10)
