
# 함수
# 함수 정의와 활용

func1 <- function() {
  xx <- 10   # xx, yy: 지역변수(함수 func1에서만 사용 가능)
  yy <- 20
  return(xx*yy)
}
func1()
print(func1())

result <- func1()
result

xx  # 오류발생  ->  지역변수라서 사용 불가!
yy  # 오류발생  ->  지역변수라서 사용 불가!



func2 <- function(x,y) {
  xx <- x
  yy <- y
  return(sum(xx, yy))
}
func2() # 오류 발생, 파라미터를 안줘서
func2(5,6) # 식 : 연산식, 호출식, 변수, 리터럴



func3 <- function(x,y) {
  #x3 <- x+1
  #y3 <- y+1
  x4 <- func2(x+1, y+1)  # 값(식) : 변수, 리터럴, 연산식, 호출식
  return(x4)
}
func3(9, 19)  # 30



func4 <- function(x=100, y=200, z) {
  return(x+y+z)
}
func4()
func4(10,20,30)
func4(x=1,y=2,z=3)
func4(y=11,z=22,x=33)   # 순서를 다르게 줄 때: 반드시 파라미터 변수도 쓴다
func4(100)  # 에러남
func4(z=1000)
# func4(,,300) -> 오류는 안나지만 쓰지말기



# 예시
# return이 생략됐을 때
f1 <- function() print("TEST")  # f1: 수행문장 1개라서 {} 생략 가능 
f1() 
r <- f1()
r

# return값이 없을 때
f1 <- function(){print("TEST"); return()}
f1() 
r <- f1()
r  # return값이 없어서 NULL


f2 <- function(num) {print("TEST"); print(num) } 
f2(100)
f2()


f3<- function (p="R") print(p)  
f3()
f3(p="PYTHON")
f3("java")


f4<- function (p1="시작!",p2) for(i in 1:p2) print(p1)
f4(p1="abc", p2=3)
f4("abc", 3) 
f4(5)  # 오류남 p2 누락
f4(p2=5)


# 가변형 인자 함수
f5<- function(...) { print("TEST"); data <- c(...); print(length(data))}
# 파라미터에 ...을 준다
# ...를 가지고 c(벡터)로 만듦
f5(10, 20, 30)
f5("abc", T, 10, 20)
f5()
f5(100)



f6<- function(...) {
  print("수행시작")
  data <- c(...)
  for(item in data) {
    print(item)
  }
  return(length(data))
}
f6()
f6(10)
f6(10,20)
f6(10,20,30)
f6(10,'abc', T, F)



f7<- function(...) {
  data <- c(...)
  sum <- 0;
  for(item in data) {
    if(is.numeric(item))
      sum <- sum + item
    else
      print(item)
  }
  return(sum)
}
f7(10,20,30)
f7(10,20,'test', 30,40)  
# 벡터는 모든 element 타입이 동일해야함
# 2번째 경우는 모든 element가 문자열이 된다



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

f8(10,20,30)
f8(10,20,"test", 30,40)
# 리스트에선 7처럼 되지 않고 각각의 타입마다 계산


f9 <- function(p1, ..., p2="ㅎ") {
  cat("p1=", p1, "\n")
  cat("가변형 = ", ..., "\n")
  cat("p2=", p2, "\n")
}

# 가변형 인자에는 아규먼트를 적용하지 않아도 됨
# 여기선 p1은 꼭 아규먼트가 필요함
f9()
f9(10) # p1
f9(10,20) #(p1,가변형)
f9(10,20,30) #(p1,가변형,가변형)
f9(10,20,30,40) #(p1, 나머지는 가변형)
f9(10,20,30,40,p2=50)
f9(10,20,30,40,p1=50, p2=60)






#전역변수/지역변수

x <- 70  # global 변수
func5 <- function() {
  x <- 10  # 지역변수가 전역변수보다 우선
  y <- 20  
  x <<- 40  # 외부 변수 x 를 수정
  return (x+y)
}
func5()  # 이때 x는 지역변수(지역변수를 먼저 찾고 -> 그 다음에 전역변수)
x
y  ###이게 어떻게 50이 나오지******************************************************



a <-3; b <-7; c <-11 
ft <-function(a){
  b <-a+10   # 지역변수
  c <<-a+10   # 전역대입연산 
  d <-a    # 지역변수
  print(a);print(b);print(c);print(d)
  # 여기서 print(c)는 지역변수가 없어서 전역변수를 씀
  return()  # NULL
}
print(ft(100))
print(a);print(b);print(c);print(d) 
# 여기서 d는 전역변수가 없어서 값이 없음




#invisible()함수; 
# 함수를 변수에 담거나 출력 함수와 같이 사용시 출력
# 그냥 호출만 하면 출력 안 함

ft.1 <- function(x) return()
ft.2 <- function(x) return(x+10)
ft.3 <- function(x) invisible(x+10)

ft.1(100)
ft.2(100)
ft.3(100)
print(ft.3(100))

r1 <- ft.1(1000);r1
r2 <- ft.2(1000);r2
r3 <- ft.3(1000);r3



# is.type() 
testParamType <- function(x){
  if(is.vector(x)) print("벡터를 전달했군요!")
  if(is.data.frame(x)) print("데이터프레임을 전달했군요!")
  if(is.list(x)) print("리스트를 전달했군요!")
  if(is.matrix(x)) print("매트릭스를 전달했군요!")
  if(is.array(x)) print("배열을 전달했군요!")
  if(is.function(x)) print("함수를 전달했군요!")
}
#dataframe이 list에, list는 vector에 포함 됨 
#list는 원소 1개 짜리 1차원 배열과 같다.
testParamType(100)
testParamType(LETTERS)
testParamType(data.frame())
testParamType(matrix())
testParamType(list())
testParamType(array())
testParamType(mean)


#testParamType
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

#dataframe이 list에, list는 vector에 포함 됨 
#list는 원소 1개 짜리 1차원 배열과 같다.....?

testParamType1(100)
testParamType1(LETTERS)
testParamType1(data.frame())
testParamType1(matrix())
testParamType1(list())
testParamType1(array())
testParamType1(function(){})



#stop() 함수: 에러를 발생시키는 함수(함수 수행을 중단함)
testError1 <- function(x){
  if(x<=0)
    stop("양의 값만 전달 하숑!! 더 이상 수행 안할거임..")
  return(rep("테스트",x))
}

testError1(5)
testError1(0)



#warning() 함수: 경고 메세지를 발생시키는 함수(함수 수행을 중단하진 않음. 수행됨)
testWarn <- function(x){
  if(x<=0)
    stop("양의 값만 전달 하숑!! 더 이상 수행 안할거임..")
  if(x>5){
    x<-5
    warning("5보다 크면 안됨!! 하여 5로 처리했삼...!!")
  }
  return(rep("테스트",x))
}
testWarn(3)
testWarn(10)



test1 <-function(p){
  cat("난 수행함\n")
  testError1(-1)
  cat("나 수행할 까요? \n")
}
test1()



#try() 함수: 에러가 나더라도 무시하고, 그 뒤의 구문은 수행시키는 함수
test2 <- function(p){
  cat("난 수행함\n")
  try(testError(-1))
  cat("나 수행할까요? \n")
}
test2()



# tryCatch
# 에러가 발생할수도 있는 부분에 블락처리해서 
# warning이 발생하면 warning 함수 수행
# error가 발생하면 error 함수 수행
# 무조건 마무리는 finally 함수 수행

testAll <-function(p){
  tryCatch({  
    if(p=="오류테스트"){
      testError1(-1)
    }else if (p =="경고테스트"){
      testWarn(6)
    }else{
      cat("정상 수행..\n")
      print(testError1(2))
      print(testWarn(3))
    }
  },warning = function(w){
    print(w)
    cat("-.-;;\n")
  },error = function(e){
    print(e)
    cat("ㅠㅠ \n")
  },finally ={
    cat("오류, 경고 발생 여부에 관계없이 반드시 수행되는 부분입니다요..\n")
  })
}

testAll("오류테스트")
testAll("경고테스트")
testAll("아무거나")




# is.na

f.case1 <- function(x) {
  if(is.na(x)) 
    return("NA가 있슈")
  else
    return("NA가 없슈")
}
f.case1(100)
f.case1(NA)

# is.na은 한 개만 처리하므로, 가장 첫번째 원소만 처리한다.(아래는 모두 warning 뜸)
f.case1(1:6)
f.case1(c(10,20,30))
f.case1(c(NA, 20))
f.case1(c(10, NA, 20))



# any
f.case2 <- function(x) {
  if(any(is.na(x))) 
    return("NA가 있슈")
  else
    return("NA가 없슈")
}
f.case2(100)
f.case2(NA)
f.case2(1:6)
f.case2(c(10,20,30))
f.case2(c(NA, 20))
f.case2(c(10, NA, 20))



# all
f.case3 <- function(x) {
  if(all(is.na(x))) 
    return("모두 NA임")
  else
    return("모두 NA인 것은 아님")
}
f.case3(100)
f.case3(LETTERS)
f.case3(NA)
f.case3(c(NA, NA, NA))
f.case3(c(NA, NA, 10))



#Sys.sleep(초시간) 함수
testSleep <- function(x) {
  for(data in 6:10) {       
    cat(data,"\n")
    if(x)
      Sys.sleep(1)
  }
  return()
}
testSleep(FALSE)
testSleep(TRUE)




# 가변형 인자 테스트
funcArgs <- function(...) {
  p <- c(...)
  data <- 1:10
  #opts <- ifelse(length(p)>0, p, "")
  if(length(p) > 0)
    opts <- p
  else
    opts <- ""
  print(p)
  print(opts)
  
  if(opts[1] == "")
    print(data)
  else 
    for(opt in opts) {
      switch(EXPR=opt,
             SUM=, Sum=, sum= print(sum(data)),
             MEAN=, Mean=, mean= print(mean(data)),
             DIFF=, Diff=, diff= print(max(data) - min(data)),
             MAX=, Max=, max= print(max(data)),
             MIN=, Min=, min= print(min(data)),
             SORT=, Sort=, sort= print(sort(data))
      )
    }
}
funcArgs()
funcArgs("SUM", "mean", "Min")


