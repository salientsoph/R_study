# 문제1

countEvenOdd <- function(num_list){
  even <- 0
  odd <- 0
  if (all(!is.numeric(num_list))){
    return()
  }else (for(num in num_list){
    if (num %% 2 == 1){
      odd <- odd + 1
    }else{
      even <- even + 1
      }
    }
  )
  return(odd)
  return(even)
}
countEvenOdd(4,2,3,1,2)
countEvenOdd("d",2,3,1,2)



# 문제2

vmSum <- function(...){
  unknown <- (...)
  if(!is.vector(unknown)){
    return("벡터만 전달하숑!")
  }else{if(is.numeric(unknown)){  
    # if(all(is.numeric(unknown))) all을 굳이 쓰지 않아도됨.. 차피 벡터는 1개가 문자면 다 문자열이라서
    return(sum(unknown))
        }else{
            return("숫자 벡터를 전달하숑!")
        }
  }
}
vmSum(3,1,5,3,4,5)
vmSum("p", "f")


# 문제3

vmSum2 <- function(){
  unknown2 <- (...)
  if(!is.vector(unknown2)){
    stop("벡터만 전달하숑!")
  }else{if(is.numeric(unknown2)){
    return(sum(unknown2))
      }else{
        warning("숫자 벡터를 전달하숑!")
        return("0")
    }
  }  
}
vmSum(3,1,5,3,4,5)
vmSum("p", "f")




# 문제4

mySum <- function(mylist){
  if(!is.vector(mylist)){
    stop("벡터만 처리 가능!!")
  }else{
    if(any(is.null(mylist))){
     warning("NA를 최저값으로 변경하여 처리함!!") 
     NA <- 0
    }
    oddlist <- mylist(seq(2,100,2))
    evenlist <- mylist(seq(1,100,2))
    oddsum <- 0
    evensum <- 0
    for(odd in oddlist){
      oddsum <- oddsum + odd
    }
    for(even in evenlist){
      evensum <- evensum + even
    }
  }
}
mySum(2,4,6,3,1,34)

# return 시, list로 만들어서 return (여러개 return은 불가해서)


# 문제5

myExpr <- function(func){
  if(!is.function(func)){
    stop("수행 안할거임!!")
  }else{
    myExpr(c(sample(1:45,6)))
  }
}
myExpr(print)



# 문제6
createVector <- function(...){
  func2 <- (...)
  if(is.null(func2)){     # 아규먼트가 없음을 나타내는 방법?
    return()
  }else if(any(is.na(func2))){
    return("NA")
  }else{
    return(c(func2))
  }
}
createVector(print)



# 문제7
createVector2 <- function(...){
  func3 <- (...)
  vec_list <- list()
  if(is.null(func3)){
    return()
  }else{
    for(element in func3){
      vec_list <- c(element)  #리스트에 값 추가하는 방법?
    }
    return(vec_list)
  }
}
createVector2()
createVector2(1)
createVector2(createVector())





# 문제8

test1 <- read.csv(data/iotest1.txt)
cat(
  "오름차순:", ,"\n"
  "내림차순:", ,"\n"
  "합:", ,"\n"
  "평균:", ,"\n"
)