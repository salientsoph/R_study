install.packages("RSelenium")
library(RSelenium)

remDr <- remoteDriver(remoteServerAddr = "localhost" , port = 4445, browserName = "chrome")
remDr$open()
# 크롬창 열기

remDr$navigate("http://www.google.com/")
# 지금 열린 크롬창에 이 url로 랜더링 해놓으라는 명령(요청해서 랜더링)

webElem <- remDr$findElement(using = "css", "[name = 'q']")
# element 찾아라, css 선택자를 사용해서 name 속성이 q인 돔 객체
# 속성명은 [속성명='속성값']
webElem$sendKeysToElement(list("PYTHON", key = "enter"))
# 찾아온 돔 객체에 대해서 python이라는 단어를 입력하고, 엔터를 쳐달라(element에 키를 보내라)
# -> 즉 11줄은, 검색어 입력하는 입력창을 뜻 함 


# remDr
# -> 리스트 객체


remDr$navigate("http://www.naver.com/")
str(remDr)
# r은 class 를 지니지 않음. list를 class 처럼 만든 것 뿐임

webElem <- remDr$findElement(using = "css", "#query")
# id 속성을 나타낼 때 속성 선택자 -> #id명
webElem$sendKeysToElement(list("PYTHON", key = "enter"))
str(webElem)




# [ 네이버 웹툰 댓글 읽기 ]
# 웹 소스에서는 못보고, 개발자보기에선 나타나는 경우(url로 나타나지 않은 경우-> 자바스크립트, 에이작스)
# -> 정적 크롤링 불가. 동적 크롤링해야함.
url<-'http://comic.naver.com/comment/comment.nhn?titleId=570503&no=135'
remDr$navigate(url)

#단수형으로 노드 추출
more<-remDr$findElement(using='css','#cbox_module > div > div.u_cbox_sort > div.u_cbox_sort_option > div > ul > li:nth-child(2) > a')
# cbox_module > div > div.u_cbox_sort > div.u_cbox_sort_option > div > ul > li:nth-child(2) > a > span.u_cbox_sort_label

# 전체 댓글에 대한 tag name을 찾음
more$getElementTagName()
more$getElementText()
more$clickElement()




# 2페이지부터 10페이지까지 링크 클릭하여 페이지 이동하기 
for (i in 4:12) {
  nextCss <- paste0("#cbox_module>div>div.u_cbox_paginate>div> a:nth-child(",i,") > span")
  nextPage<-remDr$findElement(using='css',nextCss)
  nextPage$clickElement()
  Sys.sleep(2)
}

#cbox_module > div > div.u_cbox_paginate > div > a:nth-child(6) > span

#복수형으로 노드 추출 
url<-'http://comic.naver.com/comment/comment.nhn?titleId=570503&no=135'
remDr$navigate(url)

#베스트 댓글 내용 읽어오기
# css 나 css selector 나 똑같음
# bestReviewNodes: 웹 element 객체
bestReviewNodes<-remDr$findElements(using ="css selector","ul.u_cbox_list span.u_cbox_contents")
# sapply: apply와 같은 함수. return된 bestreviewnodes를 가지고 function 수행, 하나씩 호출하여 수행.
# return값을 하나하나 차곡차곡 보관(list, matrix 등 상황마다 다름) -> 그 후 한꺼번에 리턴
# element가 몇 개던 간에 function으로 한번씩 호출 
sapply(bestReviewNodes,function(x){x$getElementText()})




#전체 댓글 링크 클릭후에 첫 페이지 내용 읽어오기
totalReview <- remDr$findElement(using='css','#cbox_module > div > div.u_cbox_sort > div.u_cbox_sort_option > div > ul > li:nth-child(2) > a')
totalReview$clickElement()
totalReviewNodes<-remDr$findElements(using ="css selector","ul.u_cbox_list span.u_cbox_contents")
sapply(totalReviewNodes,function(x){x$getElementText()})



# 링크 클릭으로 AJAX 로 처리되는 네이버 웹툰 댓글 읽어 오기
repl_v = NULL;
remDr <- remoteDriver(remoteServerAddr = "localhost" , port = 4445, browserName = "chrome")
remDr$open()
url<-'http://comic.naver.com/comment/comment.nhn?titleId=570503&no=135'
remDr$navigate(url)


#베스트 댓글 내용 읽어오기
doms1<-remDr$findElements(using ="css","ul.u_cbox_list span.u_cbox_contents")
vest_repl <- sapply(doms1,function(x){x$getElementText()})
repl_v <- c(repl_v, unlist(vest_repl))

toralReview <- remDr$findElement(using='css','span.u_cbox_in_view_comment')
toralReview$clickElement()


#전체 댓글의 첫 페이지 내용 읽어오기
doms2<-remDr$findElements(using ="css selector","ul.u_cbox_list span.u_cbox_contents")
repl <-sapply(doms2,function(x){x$getElementText()})
repl_v <- c(repl_v, unlist(repl))

repeat {
  # 10개 페이지 출력
  for (i in 4:12) {               
    nextCss <- paste("#cbox_module>div>div.u_cbox_paginate>div> a:nth-child(",i,") > span", sep="")                
    try(nextListLink<-remDr$findElement(using='css',nextCss))
    if(length(nextListLink) == 0)   break;
    
    # 클릭해서 다음 페이지로(너무 바로 해버리면 에러남,, sleep 함수 주기)
    nextListLink$clickElement()
    Sys.sleep(1)
    
    #전체 댓글의 해당 페이지 내용 읽어오기
    doms3<-remDr$findElements(using ="css selector","ul.u_cbox_list span.u_cbox_contents")
    repl <-sapply(doms3,function(x){x$getElementText()})
    repl_v <- c(repl_v, unlist(repl))                
  }
  
  # 에러나도 그것만 스킵하고 무시하고 넘어감
  try(nextPage<-remDr$findElement(using='css',
                                  "#cbox_module > div > div.u_cbox_paginate > div > a:nth-child(13) > span.u_cbox_cnt_page"))
  if(length(nextPage) == 0)  break;
  nextPage$clickElement()
  Sys.sleep(1)
  doms2<-remDr$findElements(using ="css selector","ul.u_cbox_list span.u_cbox_contents")
  repl <-sapply(doms2,function(x){x$getElementText()})
  repl_v <- c(repl_v, unlist(repl))        
}
print(repl_v)
write(repl_v, "webtoon2.txt")



# [ 아고다 페이지에 올려진 신라스테이 호텔에 대한 전체 페이지 댓글 읽기 ]
remDr <- remoteDriver(remoteServerAddr = "localhost" , port = 4445, browserName = "chrome")
remDr$open()

url<-'https://www.agoda.com/ko-kr/shilla-stay-yeoksam/hotel/seoul-kr.html?asq=z91SVm7Yvc0eRE%2FTBXmZWCYGcVeTALbG%2FvMXOYFqqcm2JknkW25Du%2BVdjH%2FesXg8ORIaVs1PaEgwePlsVWfwf3sX%2BVNABRcMMOWSvzQ9BxqOPOsvzl8390%2BEhEylPvEiBp0eoREr2xLYHgqmk0Io4J1HYEzEOqyvdox%2BwS6yxHeonB9lh7mJsBIjSBPoMzBLFW01k%2BU8s2bGO6PcSdsu3T30HwabyNzwNYKiv%2BRDxfs%3D&hotel=699258&tick=637215342272&languageId=9&userId=bcb7ecc6-7719-465f-bf29-951e39733c66&sessionId=uouhnqjisace4freagmzbxxc&pageTypeId=7&origin=KR&locale=ko-KR&cid=-1&aid=130243&currencyCode=KRW&htmlLanguage=ko-kr&cultureInfoName=ko-KR&ckuid=bcb7ecc6-7719-465f-bf29-951e39733c66&prid=0&checkIn=2020-05-30&checkOut=2020-05-31&rooms=1&adults=1&childs=0&priceCur=KRW&los=1&textToSearch=%EC%8B%A0%EB%9D%BC%EC%8A%A4%ED%85%8C%EC%9D%B4%20%EC%97%AD%EC%82%BC%20(Shilla%20Stay%20Yeoksam)&productType=-1&travellerType=0&familyMode=off'
remDr$navigate(url)
Sys.sleep(3)

pageLink <- NULL
reple <- NULL
curr_PageOldNum <- 0

# 댓글 20개씩(한 페이지 단위로) 출력 
repeat{
  doms <- remDr$findElements(using = "css selector", ".Review-comment-bodyText")
  Sys.sleep(1)
  reple_v <- sapply(doms, function (x) {x$getElementText()})
  print(reple_v)
  
  # list를 vector로 바꿔서 댓글이 지금까지 몇 개인지
  reple <- append(reple, unlist(reple_v))
  cat(length(reple), "\n")
  
  # 이 조건에 맞는 element를 찾아와서 click 이벤트 발생
  pageLink <- remDr$findElements(using='css',"#reviewSection > div:nth-child(6) > div > span:nth-child(3) > i ")

  # 여기선 자바스크립트 코드로 클릭이벤트를 발생시킴
  # arguments 함수(가변형 인자 함수) 사용
  remDr$executeScript("arguments[0].click();",pageLink)
  Sys.sleep(2)
  
  # 현재 읽어온 페이지, 새로 읽어올 페이지를 비교
  # 같다면 더이상 읽을 페이지가 없다는 뜻 -> 종료
  curr_PageElem <- remDr$findElement(using='css','#reviewSection > div:nth-child(6) > div > span.Review-paginator-numbers > span.Review-paginator-number.Review-paginator-number--current')
  curr_PageNewNum <- as.numeric(curr_PageElem$getElementText())
  cat(paste(curr_PageOldNum, ':', curr_PageNewNum,'\n'))
  if(curr_PageNewNum == curr_PageOldNum)  {
    cat("종료\n")
    break; 
  }
  curr_PageOldNum <- curr_PageNewNum;
}
cat(length(reple), "개의 댓글 추출\n")
write(reple,"hotel.txt")


