# 문제1
grade <- sample(1:6, 1)
if(grade == 1 | grade == 2 | grade ==3){
  cat(grade, "학년은 저학년 입니다")
}else{
  cat(grade, "학년은 고학년 입니다")
}

# grade <- sample(1:6, 1)
# if(grade >= 1 & grade <= 3){
# if(grade >= 1 && grade <= 3)  위와 동일
#  cat(grade, "학년은 저학년 입니다")
#}else{
#  cat(grade, "학년은 고학년 입니다")
#}

  
# 문제2
choice <- sample(1:5, 1)
x = 300
y = 50
if(choice == 1){
  result = x + y
}else if(choice == 2){
  result = x - y
}else if(choice == 3){
  result = x * y
}else if(choice == 4){
  result = x / y
}else{
  result = x %% y
}
print(paste("결과값:", result))
cat("결과값:", result, "\n")

# result <- switch(EXPR=choice, 300+50, 300-50, 300*50, 300/50, 300%%50)
# result <- switch(EXPR=as.character(choice), 
#               "1"=300+50, "2"=300-50, "3"=300*50, "4"=300/50, "5"=300%%50)


# 문제3
# r에선 문자열 연산 불가
count <- sample(3:10,1); count
deco <- sample(1:3,1); deco

if(deco==1){
  deco <- "*"
}else if(deco==2){
  deco <- "$"
}else{
  deco <- "#"
}
for(data in (1:count))
  cat(deco)


# for(num in 1:count){
#if(deco==1){
#  cat("*", sep="")
#}else if(deco==2){
#  cat("$", sep="")
#}else{
#  cat("#", sep="")
#}}





# 문제4
score <- sample(0:100, 1)

if(score>=90){
  level <- 1
}else if(score>=80){  # 이미 위에서 90이상이 아니라서 내려온거라서, 90이하인거 안써도 됨
  level <- 2
}else if(score>=70){
  level <- 3
}else if(score>=60){
  level <- 4
}else{
  level <- 5
}
cat(score, "점은", 
    switch(EXPR = level,"A","B","C","D","f"), "등급입니다", "\n")





# 문제5 
for(i in (1:26)){
alpha <- c(LETTERS[i], letters[i], sep="")
cat('"', alpha, '" ', sep="")}




