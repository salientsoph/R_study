library(RSelenium)
remDr <- remoteDriver(remoteServerAddr = "localhost" , port = 4445, browserName = "chrome")
remDr$open()

url<-'https://hotel.naver.com/hotels/item?hotelId=hotel:Shilla_Stay_Yeoksam&destination_kor=%EC%8B%A0%EB%9D%BC%EC%8A%A4%ED%85%8C%EC%9D%B4%20%EC%97%AD%EC%82%BC&rooms=2'
remDr$navigate(url)
Sys.sleep(3)

pageLink <- NULL
reple <- NULL
curr_PageOldNum <- 0

  
# 리뷰을 한 페이지 단위로 출력 
repeat{
  doms <- remDr$findElements(using = "css selector", "div.review_desc > p")
  Sys.sleep(1)
  reple_v <- sapply(doms, function (x) {x$getElementText()})
  print(reple_v)
  
  # 댓글이 지금까지 몇 개인지
  reple <- append(reple, unlist(reple_v))
  cat(length(reple), "\n")
  
  # click 이벤트 발생
  pageLink <- remDr$findElements(using='css',"div.hotel_used_review.ng-isolate-scope > div.review_ta.ng-scope > div.paginate > a.direction.next")
  remDr$executeScript("arguments[0].click();",pageLink)
  Sys.sleep(2)
  
  # 더이상 읽을 페이지가 없으면 -> 종료 (null 값을 비교,, length를 확인해서 disabled가 추가된 ) 
  curr_PageElem <- remDr$findElement(using='css',"div.hotel_used_review.ng-isolate-scope > div.review_ta.ng-scope > div.paginate strong")
  curr_PageNewNum <- as.numeric(curr_PageElem$getElementText())
  cat(paste(curr_PageOldNum, ':', curr_PageNewNum,'\n'))
  if(curr_PageNewNum == curr_PageOldNum)  {
    cat("종료\n")
    break; 
  }
  curr_PageOldNum <- curr_PageNewNum;
}
  
cat(length(reple), "개의 댓글 추출\n")
write(reple,"naverhotel.txt")
