# 문제1
# iris 라는 데이터셋이 몇 개의 관측치를 가지고 있는지
# 어떠한 변수들을 가지고 있는지 

str(iris)
View(iris)


# 문제2
df1 <- data.frame(
  x=c(1:5), 
  y=c(2,4,6,8,10))

# y = seq(2,10,2)


# 문제3
df2 <- data.frame(
  col1=c(1:5), 
  col2=c('a','b','c','d','e'),
  col3=c(6:10))

#col2=letters[1:5]


# 문제4
제품명 = c('사과', '딸기', '수박')
가격 = c(1800, 1500, 3000)
판매량 = c(24, 38, 13)
df3 <- data.frame(제품명, 가격, 판매량)
str(df3)


# 문제5
# 데이터 프레임을 이용해서 과일 가격 평균, 판매량 평균
mean(df3$가격)
mean(df3$판매량)


# 문제6
name <- c("Potter", "Elsa", "Gates", "Wendy", "Ben")
gender <- factor(c("M", "F", "M", "F", "M"))
math <- c(85, 76, 99, 88, 40)

df4 <- data.frame(name, gender, math)
df4

# (a) stat 변수를 추가하시오. 
df4$stat <- c(76, 73, 95, 82, 35)
df4
# (b) math 변수와 stat 변수의 합을 구하여 score 변수에 저장 
df4$score <- df4$math + df4$stat
df4$score
# (c) score가 150 이상이면 A, 
#100 이상 150 미만이면 B, 
#70 이상 100 미만이면 C,
#70 미만이면 D 등급을 부여하고 grade 변수에 저장
df4$grade <- ifelse(df4$score >= 150,"A",
                    ifelse(df4$score>=100,"B", 
                           ifelse(df4$score>=70,"C","D")))
df4




# 문제7 
# emp변수에 할당된 데이터프레임 객체의 구조
emp <- read.csv("data/emp.csv")
str(emp)


# 문제8
# emp 에서 3행, 4행 , 5행만 
emp[c(3,4,5),]
emp[3:5,]
emp[seq(3,5),]


# 문제9
# emp 에서 4번열을 제외
emp[,-4]

# 문제10
# emp 에서 ename컬럼
emp[,"ename"]

# 문제11
# emp 에서 ename 과 sal컬럼
emp[,c("ename", "sal")]

# 문제12
# 업무가 SALESMAN 인 사원의 이름, 월급, 직업을 출력한다.
subset(emp,emp$job=="SALESMAN", c("ename","sal", "job"))

# 문제13
# 월급이 1000 이상이고 3000이하인 사원들의 이름, 월급, 부서번호
subset(emp, select=c("ename","sal", "deptno"), subset=(sal>=1000 & sal<=3000))

# 문제14
# emp 에서 직업이 ANALYST 가 아닌 사원들의 이름, 직업, 월급
subset(emp,emp$job!="ANALYST", c("ename", "job", "sal"))

# 문제15 
# emp 에서 업무가 SALESMAN 이거나 ANALYST 인 사원들의 이름, 직업
subset(emp,emp$job==c("ANALYST", "SALESMAN"), c("ename", "job"))


# 문제16
# emp 에서 커미션이 정해지지 않은 직원의 이름과 월급 정보
subset(emp,is.na(emp$comm), c("ename", "sal"))
#emp[is.na(emp$comm), c("ename", "sal")]


# 문제17 
# 월급이 적은 순으로 모든 직원 정보(order)
emp[order(emp$sal, decreasing=F), c(1:8)]
emp[order(emp$sal),]
a <- emp[order(emp$sal),]
tail(emp[order(emp$sal),],1)
emp[which.max(emp$sal),]

# 문제18 
# emp의 행과 열의 갯수를 점검한다.
nrow(emp)
ncol(emp)
dim(emp)