# 연산자

num1 %% num2 # 나머지
num1 %/% num2  # 몫



# LIST
v<-c(1,2,3)
l<-list(1,2,3) 

v
l

v[1] 
l[1]   # [[1]]: "리스트 구조를 유지하면서 꺼냈다"
l[[1]] 

l[1] + 100  # 오류남(벡터가 가진 값이 아니고, 리스트이기 때문에)
l[[1]] + 100


lds <- list(1,2,3) 
lds
lds+100  # 오류남

unlist(lds)  # 리스트를 벡터로 풀어줌
unlist(lds)+100

lds[1]
lds[1]+10
lds[[1]]+10


names(lds) <- LETTERS[1:3]  # lds의 데이터셋마다 이름 부여
lds
lds[[2]]
lds[["B"]]
lds$B


a<-list(
  a = 1:3,
  b = "a string",
  c = pi,
  d = list(-1,-5)
)


a[1]
a[[1]] # a[["a"]]
a$a

a[[1]][1]
a$a[1]

a[1]+1  # 에러남
a[[1]]+1

a[[1]][2] <- 100
a[[1]]

new_a <- unlist(a[1])
a[1]
new_a   #####이거 값 왜이러지

names(a) <- NULL
names(new_a) <- NULL

a
new_a




# 제어문
# if문
# 1~10 사이의 난수
randomNum <-sample(1:10,1)
if(randomNum>5){
  cat(randomNum,":5보다 크군요","\n")
}else{
  cat(randomNum,":5보다 작거나 같군요","\n")
}


# 2로 나눈 나머지가 1일 때(=홀수)
if(randomNum%%2 == 1){
  cat(randomNum,";홀수\n")
}else{
  cat(randomNum,";짝수","\n")
}

# "\n" 을 또 다른 아규먼트로 줘도 됨
if(randomNum%%2 == 1){
  cat(randomNum,";홀수","\n")
}else{
  cat(randomNum,";짝수","\n")
}




score <- sample(0:100, 1)  # 0~100 숫자 한 개를 무작위로 뽑아서
if (score >=90){
  cat(score,"는 A등급입니다","\n")
}else if (score >=80){
  cat(score,"는 B등급입니다","\n")
}else if (score >=70){
  cat(score,"는 C등급입니다","\n")
}else if (score >=60){
  cat(score,"는 D등급입니다","\n")
}else {
  cat(score,"는 F등급입니다","\n")
}






# 반복문
# for

for(data in month.name) 
  print(data)

for(data in month.name) 
  cat(data)


# i가 10이상이면 끝(i를 10으로 나눈 나머지가 0, 즉 10일 때 break)
sum <- 0
for(i in 5:15){
  if(i%%10==0){    
    break
  }
  sum <- sum + i
  print(paste(i,":",sum))
}


sum <- 0
for(i in 5:15){
  if(i%%10==0){
    break
  }
  sum <- sum + i
  cat(i,":",sum,"\n")
}


# 10 건너뛰고
sum <-0
for(i in 5:15){
  if(i%%10==0){
    next;  #continue
  }
  sum <- sum + i
  print(paste(i,":",sum))
}



for(data in month.name) 
  print(data)
for(data in month.name)print(data);print("끝!")
for(data in month.name){print(data);print("끝!")}


for(n in 1:5)
  cat("hello?","\n")



# 중첩된 for문

for(i in 1:5){
  for(j in 1:5){
    cat("i=",i,"j=",j,"\n")
  }
}


# 구구단
# \n : 개행문자, \t : 탭문자
for(dan in 1:9){
  for(num in 1:9){
    cat(dan,"x",num,"=",dan*num,"\t") # 이 cat은 81번 수행
  }
  cat("\n")  # 이 cat은 9번 수행
}



# 곱한 결과가 30이 넘어가면 단마다 break
for(i in 1:9){
  for(j in 1:9){
    if(i*j>30){
      break  # 가장 가까운 반복문 1개만 stop함
    } 
    cat(i,"*",j,"=",i*j,"\t")
  }
  cat("\n")
}


# 곱한 결과가 30이 넘어가면 완전히 break
bb <- F
for(i in 1:9){
  for(j in 1:9){
    if(i*j>30){
      bb<-T
      break
    } 
    cat(i,"*",j,"=",i*j,"\t")
  }
  cat("\n")
  if(bb) #bb가 TRUE이면
    break
}



#while문

# while
# sumNumber가 20 이하일 때만
sumNumber <- 0
while(sumNumber <= 20) { 
  i <- sample(1:5, 1)    # 1~5중 하나의 난수 추출 
  sumNumber <-sumNumber+i
  cat(sumNumber,"\n")
} 


# repeat: 무한루프
# [while True] 와 동일
repeat {
  cat("ㅋㅋㅋ\n")
}
# console 창에서 stop 시켜야함



sumNumber <- 0
repeat { 
  i <- sample(1:5, 1) 
  sumNumber <-sumNumber+i; 
  cat(sumNumber,"\n")
  if(sumNumber > 20)
    break;
}


i<-1
while(i <= 10){
  cat(i,"\n")
  i <- i+1
}
cat("종료 후 :",i,"\n")


i<-1
while (i<=10) {
  cat(i,"\n")
}


i<-1
while (i<=10) {
  cat(i,"\n")
  i<-i+2
}


i<-1
while (i<=10) {
  cat(i,"\n")
  i<-i+1
}



#switch 문을 대신하는 함수
month <- sample(1:12,1)
month <- paste(month,"월",sep="") # "3월"  "3 월"
result <- switch(EXPR=month,
                 "12월"=,"1월"=,"2월"="겨울",
                 "3월"=,"4월"=,"5월"="봄",
                 "6월"=,"7월"=,"8월"="여름",
                 "가을")
cat(month,"은 ",result,"입니다\n",sep="")



num <- sample(1:10,1)
num
switch(EXPR = num,"A","B","C","D")
# 1일때 A, 2일때 B, 3일때 C, 4일때 D, 그 외는 표현 안 함


for(num in 1:10){
  cat(num,":",switch(EXPR = num,"A","B","C","D"),"\n")
}
# 1일때 A, 2일때 B, 3일때 C, 4일때 D, 그 외는 표현 안 함


for(num in 1:10){
  num <- as.character(num) 
  cat(num,":",switch(EXPR = num,
                     "7"="A","8"="B","9"="C","10"="D","ㅋ"),"\n")
}
# 7,8,9,10은 값을 주고, 나머지 default는 ㅋ 출력






