# 문제1

countEvenOdd <- function(...){
  list <- list(...)
  odd <- list()
  even <- list()
  if(is.vector(list)){
    for(data in list){
      if(data%%2 == 1){
        odd <- odd + 1
        return(odd)
      }else{
        even <- even + 1
        return(even)
      } 
    }
  }
  else{
    return
  }
}

countEvenOdd(4,2,3,1,2)
  

testParamType1 <- function(x){
  result <- NULL
  if(is.vector(x)  && !is.list(x)) result <-"벡터를 전달했군요!"
  else if(is.data.frame(x)) result <- "데이터프레임을 전달했군요!"
  else if(is.list(x)) result <- "리스트를 전달했군요!"
  else if(is.matrix(x)) result <- "매트릭스를 전달했군요!"
  else if(is.array(x)) result <- "배열을 전달했군요!"
  else if(is.function(x)) result <- "함수를 전달했군요!"
  return(result)
}

f8<- function(...) {
  data <- list(...)
  sum <- 0;
  for(item in data) {
    if(is.numeric(item))
      sum <- sum + item
    else
      print(item)
  }
  return(sum)
}


# 문제2

vmSum <- function(){
  
  
  
  
  
}



# 문제3

vmSum2 <- function(){
  
  
  
}


# 문제4

mySum <- function(){
  
  
  
  
}


# 문제5
myExpr <- function(){
  
  
  
}

# 문제6
createVector <- function(){
  
  
  
}


# 문제7
createVector2 <- function(){
  
  
}



# 문제8
