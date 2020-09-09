getwd()


# factor 실습

score <- c(1,3,2,4,2,1,3,5,1,3,3,3)
class(score)
summary(score)

f_score <- factor(score)
class(f_score)# levels: 범주형 데이터
f_score 
summary(f_score) # 각 데이터마다 갯수를 세어준다
levels(f_score)

plot(score) # 삼전도(그래프)를 그려주는 함수, 막대그래프도 그려줌 (시각화api)
plot(f_score)


data1 <- c("월","수","토","월",
           "목","화")
data1
class(data1) # data들이 어떤 class인지
summary(data1) # character에서 summary: 벡터 갯수, 클래스, 모드(타입)을 알려줌
day1 <- factor(data1)
day1
class(day1)
summary(day1) # 갯수를 세어줌
levels(day1)

week.korabbname <- c("일", "월", "화",
                     "수", "목", "금", "토")
day2 <- factor(data1, 
               levels=week.korabbname)
day2
summary(day2)
levels(day2)



btype <- factor(
  c("A", "O", "AB", "B", "O", "A"), 
  levels=c("A", "B", "O"))
btype # levels에 없는 AB는 NA값으로 출력됨
summary(btype)
levels(btype)

gender <- factor(c(1,2,1,1,1,2,1,2), 
                 levels=c(1,2), 
                 labels=c("남성", "여성")) 
# label: 벡터의 값을 label에 지정된 명칭에 따라 바꿈
gender
summary(gender)
levels(gender)




# 내장 데이터셋
data()
iris; head(iris);tail(iris) 
View(iris) # 표로 나타내서 보여줌
str(iris)  # 150 obs(observertion)(관측치): 150개 행, 모아놓은 데이터 갯수




#Dataframe 실습
no <- c(1,2,3,4)
name <- c('Apple','Banana','Peach','Berry')
qty <- c(5,2,7,9)
price <- c(500,200,200,500)
fruit <- data.frame(no, name, qty, price)
str(fruit)  # 4개의 observation을 갖는다
View(fruit)

fruit[1,]  # 1행만
fruit[-1,]  # 1행만 빼고
fruit[,2]  # 2열만
fruit[,3] # 3열만. 벡터로 추출(drop=T)
fruit[,3, drop=F]  # 3열만. df로 추출. drop=F: df 유지하면서 추출
fruit[, c(3,4)]
fruit[3,2]
fruit[3,1]

fruit[,3]
fruit$qty   # $: 연산자
fruit[[3]]
fruit[3]  # 열만 추출. 이때는 데이터프레임 형식 유지함

str(fruit$qty)  # 벡터
str(fruit[3])


# dataframe exam1
english <- c(90, 80, 60, 70)
math <- c(50, 60, 100, 20)
classnum <- c(1,1,2,2)
df_midterm <- data.frame(english, math, classnum)
df_midterm
str(df_midterm)
colnames(df_midterm)
rownames(df_midterm)  # 이름 준 적이 없어서 자동으로 1~4
names(df_midterm)  # names: col이 우선이기 때문에 col 이름이 나옴
mean(df_midterm$english)
mean(df_midterm$math)

df_midterm2 <- data.frame(
  c(90, 80, 60, 70), 
  c(50, 60, 100, 20), 
  c(1,1,2,2))
colnames(df_midterm2)
rownames(df_midterm2)
names(df_midterm2)
df_midterm2
df_midterm2 <- data.frame(
  영어=c(90, 80, 60, 70), 
  수학=c(50, 60, 100, 20), 
  클래스=c(1,1,2,2))
df_midterm2
df_midterm2$영어


#df <- data.frame(var1=c(4,3,8), 
#                 var2=c(2,6)) # 오류
df <- data.frame(var1=c(4,3,8), 
                 var2=c(2,6,1))
 
df$var_sum <- df$var1 + df$var2  # 두 벡터 각각의 원소값끼리 더함
df$var_sum
df$var_mean <- df$var_sum/2
df$var_mean
df$result <- ifelse(df$var1>df$var2, 
                    "var1이 크다", "var1이 작다")
df$result


getwd() # 현재 working directory 확인
# setwd('xxx') working directory 설정


#csv파일열기
score <- read.csv("data/score.csv") # csv 파일을 팩터로 받음
# 앞에 /를 붙이면 안됨(상위 디렉토리)

score
str(score)  # 데이터프레임 구조 확인
score$sum <- score$math+score$english+score$science
score$result <- ifelse(score$sum >= 200, "pass", "fail")
score
view(score)

summary(score$result)
table(score$result)  # 집계표를 만듦(팩트형이 아니어도 갯수를 셈)
summary(factor(score$result))
score$result = factor(score$result) 
str(score)
summary(score)
score$id = as.character(score$id) # 숫자 데이터를 문자열로 바꿀 때
score$class = factor(score$class)

score$grade<-ifelse(score$sum >= 230,"A",
                    ifelse(score$sum >= 215,"B", 
                           ifelse(score$sum >=200,"C","D")))
score
score$grade = factor(score$grade)



# order() 와 sort()
v <- c(10,3,7,4,8)
sort(v)  # accendent
order(v)  # index로 나타남(accendent)

emp <- read.csv(file.choose())
                # stringsAsFactors = F) = default
emp
str(emp)



# emp에서 직원 이름
emp$ename  # 이렇게 쓸 땐 drop 설정 불가
emp[,2]
emp[,"ename"] 
emp[,2, drop=FALSE] 
emp[,"ename",drop=F] 
emp[2]
emp["ename"] 


# emp에서 직원이름, 잡, 샐러리
emp[,c(2,3,6)]
emp[,c("ename","job","sal")]
subset(emp,select = c(ename, job, sal))
?subset

# emp에서 1,2,3 행들만
emp[1:3,]
emp[c(1,2,3),]
?head
head(emp)
head(emp, n=1)

# ename이 "KING"인 직원의 모든 정보
emp[9,] 
emp$ename=="KING"
emp[c(F,F,F,F,F,F,F,F,T,F,F,F,
      F,F,F,F,F,F,F,F),]
emp[emp$ename=="KING",]
subset(emp,subset=emp$ename=="KING")
subset(emp,emp$ename=="KING") # 위와 동일. 즉 subset 생략 가능



# 커미션을 받는 직원들의 모든 정보 출력
emp[!is.na(emp$comm),]  # !=not
# is.na(emp$comm) == na로 나오는 직원이 TRUE
# !is.na(emp$comm) == na로 안 나오는 직원이 TRUE

subset(emp,!is.na(emp$comm)) 
View(emp)

# select ename,sal from emp where sal>=2000
subset(emp, select=c("ename","sal"), 
       subset= emp$sal>= 2000)

# c("ename","sal") = ename, sal만 추출. 연봉이 2000보다 큰.
subset(emp, emp$sal>= 2000, c("ename","sal"))
emp[emp$sal>=2000,c("ename","sal")]

# select ename,sal from emp where sal between 2000 and 3000
subset(emp, select=c("ename","sal"), subset=(sal>=2000 & sal<=3000))
emp[emp$sal>=2000 & emp$sal <=3000, c("ename","sal")]





# 연산자

y <- c(0,25,50,75,100)
z <- c(50,50,50,50,50)
y == z
y != z
y > z
y < z
y >= z
y <= z
y == 50 # c(50, 50, 50, 50, 50)
y > 50

num1 <- 11 # c(11)
num2 <- 3  # c(3)
num1 / num2
num1 %% num2 # 나머지 -> day3
num1 %/% num2  # 몫 -> day3




# 데이터 출력 함수

print(100)
print(pi)
data <- "가나다"
print(data)
print(data, quote=FALSE)
v1 <- c("사과", "바나나", "포도")
print(v1)
print(v1, print.gap=10)
cat(100)
cat(100,200)  #하나의 문자열로 만들어서 출력
cat(100,200,"\n")  # paste와 비슷
cat("aaa", "bbb", "ccc", "ddd", "\n")
cat(v1, "\n")
cat(v1, sep="-", "\n")

print(paste("R", "은 통계분석", "전용 언어입니다."))
cat("R", "은 통계분석", "전용 언어입니다.", "\n")

ls()
length(ls())
save(list=ls(),file="all.rda") 
# varience will save in "all.rda" of rexam(working directory)
rm(list=ls())
ls()
load("all.rda")
ls()





# read file data

# scan: word단위로 읽음. 숫자를 읽어옴(숫자에 특화됨)
nums <- scan("data/sample_num.txt")
# 문서가 숫자 이외의 문자도 있다면 -> what="" 꼭 써야함
word_ansi <- scan("data/sample_ansi.txt",what="")
# word_ansi <- scan("data/sample_ansi.txt") -> 에러남

# defult=native code. UTF-8 -> encoding="UTF-8" 꼭 써야함(반드시 대문자)
words_utf8 <- scan("data/sample_utf8.txt", what="",encoding="UTF-8")
words_utf8_new <- scan("data/sample_utf8.txt", what="")


# readlines: 행 단위로 읽음
lines_ansi <- readLines("data/sample_ansi.txt")
lines_utf8 <- readLines("data/sample_utf8.txt",encoding="UTF-8")

# read: 
# read.csv: csv를 읽어오는데 특화됨.
# url을 써도 읽어옴. 첫번째 행은 무조건 title로 인식.
# title이 없는 csv인 경우, title이 없다는 걸 써줘야함.
df1 <- read.csv("CSV파일 또는 CSV를 응답하는 URL")

# read.table: 첫번째 행부터 data로 인식(title로 인식 안함(read와 다름))
# 열 이름은 따로 없이 v1 v2 v3... 로 붙임
df2 <- read.table("일정한 단위(공백 또는 탭등)로 구성되어 있는 텍스트 파일 또는 URL")
# 필요에 따라서 stringsAsFactors 속성 사용
df2 <- read.table("data/product_click.log", stringsAsFactors = T)

# write.csv(파일명), write.table(파일명)


str(df2)
head(df2)
summary(df2$V2)




