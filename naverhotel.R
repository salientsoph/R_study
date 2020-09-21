library(RSelenium)
remDr <- remoteDriver(remoteServerAddr = "localhost" , port = 4445, browserName = "chrome")
remDr$open()

url<-'https://hotel.naver.com/hotels/item?hotelId=hotel:Shilla_Stay_Yeoksam&destination_kor=%EC%8B%A0%EB%9D%BC%EC%8A%A4%ED%85%8C%EC%9D%B4%20%EC%97%AD%EC%82%BC&rooms=2'
remDr$navigate(url)
Sys.sleep(3)

pageLink <- NULL
reple <- NULL

  
# 리뷰을 한 페이지 단위로 출력 
repeat{
  doms <- remDr$findElements(using = "css selector", "div.review_desc > p")
  reple_v <- sapply(doms, function (x) {x$getElementText()})
  reple <- append(reple, unlist(reple_v))
  Sys.sleep(1)
  
  
# click 이벤트 발생
  pageLink <- remDr$findElements(using='css',"div.review_ta.ng-scope > div.paginate > a.direction.next")

  nextpage <- remDr$findElements(using='css selector',"div.review_ta.ng-scope > div.paginate > a.direction.next.disabled")
  
# '다음'버튼이 disabled이면 list에 해당 element값을 하나 리턴하므로 length가 1이됨.
  if(length(nextpage) == 0){
    pageLink$clickElement()
    Sys.sleep(2)
  }else{
    break;
  }
}
  
  
write(reple, "naverhotel.txt")
  
