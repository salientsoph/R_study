library(RSelenium)
remDr <- remoteDriver(remoteServerAddr = "localhost" , port = 4445, browserName = "chrome")
remDr$open()

site <- 'http://gs25.gsretail.com/gscvs/ko/products/event-goods'
remDr$navigate(site)

goodsnamelist <- NULL
goodspricelist <- NULL 
df <- NULL
checkpagegoods <- ""

twotoone <- remDr$findElement(using='css','#TWO_TO_ONE')
twotoone$clickElement()
Sys.sleep(3)


repeat{
  # 상품명
  goodsnodes <-remDr$findElements(using ="css","#contents > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(5) > ul > li > div > p.tit")
  goodsname <- sapply(goodsnodes, function(x) {x$getElementText()})
  goodsname <- unlist(goodsname)
  
  # 상품가격 
  goodsnodes <- remDr$findElements(using='css', '#contents > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(5) > ul > li > div > p.price > span')
  goodsprice <- sapply(goodsnodes, function(x) {x$getElementText()})
  goodsprice <- gsub("[^[:digit:]]", "", goodsprice)
  
  
  if(checkpagegoods != goodsname[1]){
    pagegoods <- goodsname[1]
    
    goodsnamelist <- append(goodsnamelist, goodsname)
    goodspricelist <- append(goodspricelist, goodsprice)
    
    nextnode <-remDr$findElement(using ="css selector","#contents > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(5) > div > a.next")
    nextnode$clickElement()
    
    Sys.sleep(2)
  }else{
    break 
  }
}

df <- data.frame(goodsname=goodsnamelist, goodsprice=goodspricelist)
View(df)
write.csv(df, "gs25_twotoone.csv")



