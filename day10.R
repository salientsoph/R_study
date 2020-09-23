install.packages("rJava")
install.packages("RJDBC")
install.packages("DBI")  # 여러가지 SQL 명령을 수행
library(rJava)
library(RJDBC)
library(DBI)


setwd("c:/Rexam")

# R에서 MariaDB 데이터 조작

# 드라이버 로딩(메모리에 올림)
drv <- JDBC(driverClass = 'org.mariadb.jdbc.Driver', 'mariadb-java-client-2.6.2.jar')
conn <- dbConnect(drv, 'jdbc:mariadb://127.0.0.1:3306/work', 'scott', 'tiger')

# MariaDB 데이터베이스 연결
# 모든 레코드 조회
query <- "select * from goods"
goodsAll <- dbGetQuery(conn, query)
goodsAll
dbReadTable(conn, 'goods')

# 조건 검색-수량(su)이 3 이상인 데이터
query <- "select * from goods where su >= 3"
dbGetQuery(conn, query)

# 단가(dan)를 내림차순으로 정렬
query <- "select * from goods order by dan desc"
dbGetQuery(conn, query)

# 데이터프레임 자료를 테이블에 저장
insert.df <- data.frame(code=5, name="식기 세척기", su=1, dan=250000)
dbWriteTable(conn, "goods", insert.db)  #에러남(이미 존재하는 테이블에 넣는다고 해서)
dbWriteTable(conn, "goods1", insert.db)

# 테이블 조회
query <- "select * from goods1"
goodsAll <- dbGetQuery(conn, query)
goodsAll
dbReadTable(conn, 'goods1')

# 파일 자료를 테이블에 저장하기
recode <- read.csv("C:/Rexam/data/recode.csv")
dbWriteTable(conn, "goods2", recode)  # 테이블에 기록

# 테이블 조회
query = "select * from goods2"
goodsAll <- dbGetQuery(conn, query)
goodsAll


# 테이블에 레코드 추가
query = "insert into goods2 values(6, 'test', 1, 1000)"
dbSendUpdate(conn, query)
# 테이블 조회
query = "select * from goods2"
goodsAll <- dbGetQuery(conn, query)
goodsAll


# 테이블의 레코드 수정
query = "update goods2 set name = '테스트' where code = 6"
dbSendUpdate(conn, query)
# 테이블 조회
query = "select * from goods2"
goodsAll <- dbGetQuery(conn, query)
goodsAll


# 테이블의 레코드 삭제
delquery = "delete from goods2 where code = 6"
dbSendUpdate(conn, delquery)
# 테이블 조회
query = "select * from goods2"
goodsAll <- dbGetQuery(conn, query)
goodsAll 





# bookname, price 로 book 테이블을 만듦
dbWriteTable(conn,"book",data.frame(bookname=c("파이썬 정복","하둡 완벽 입문","R 프로그래밍"),
                                    price=c(25000,25000,28000)))
dbGetQuery(conn, "SELECT * FROM book")


# mtcars: R이 내장하고 있는 데이터셋
head(mtcars)
str(mtcars)
dbSendUpdate(conn, "drop table mtcars")
dbWriteTable(conn, "mtcars", mtcars[1:5, ])
dbReadTable(conn, "mtcars")

# append: 이미 존재하는 table에 갖다 붙임. default = false임
dbWriteTable(conn, "mtcars", mtcars[6:10, ], append = TRUE)
dbReadTable(conn, "mtcars")

# overwrite: 새로 대체. default = false임
dbWriteTable(conn, "mtcars", mtcars[1:2, ], overwrite = TRUE)
dbReadTable(conn, "mtcars")

# cars: R에 존재하는 데이터셋
head(cars)
str(cars)
dbSendUpdate(conn, "drop table cars")
dbWriteTable(conn,"cars",head(cars,3))
dbGetQuery(conn, "SELECT * FROM cars")



# 데이터 수정
dbSendUpdate(conn,"INSERT INTO cars(speed, dist) VALUES(1,1)")
dbSendUpdate(conn,"INSERT INTO cars(speed, dist) VALUES(2,2)")
dbReadTable(conn,"cars")

# speed=1인 것의 dist를 100배해서 다시 대입
# where절 이후를 안주면 모든 값에 100배 하게됨
dbSendUpdate(conn,"UPDATE CARS SET DIST=DIST*100 WHERE SPEED =1")
dbReadTable(conn,"cars")

dbSendUpdate(conn,"UPDATE CARS SET DIST=DIST*3 WHERE SPEED =1")
dbReadTable(conn,"cars")



# 테이블 삭제
dbRemoveTable(conn,"cars")












# 데이터 전처리(1) - apply 계열의 함수를 알아보자
weight <- c(65.4, 55, 380, 72.2, 51, NA)
height <- c(170, 155, NA, 173, 161, 166)
gender <- c("M","F","M","M","F","F")

df <- data.frame(w=weight, h=height)
df

# 연산하는 값 중 하나라도 NA면 -> 연산 결과도 NA가 됨
# apply(x, margin, function  [, function에게 전달하는 아규먼트])
apply(df, 1, sum, na.rm=TRUE)  # 행 단위. na.rm=TRUE -> sum에게 전달(NA값은 무시)
apply(df, 2, sum, na.rm=TRUE)  # 열 단위.
lapply(df, sum, na.rm=TRUE)  # list
sapply(df, sum, na.rm=TRUE)  # named vector
tapply(1:6, gender, sum, na.rm=TRUE)  # 인덱스 위치의 값을 sum해서 내보냄
tapply(df$w, gender, mean, na.rm=TRUE)
mapply(paste, 1:5, LETTERS[1:5], month.abb[1:5])


v<-c("abc", "DEF", "TwT")
sapply(v, function(d) paste("-",d,"-", sep=""))

l<-list("abc", "DEF", "TwT")
sapply(l, function(d) paste("-",d,"-", sep=""))
lapply(l, function(d) paste("-",d,"-", sep=""))



flower <- c("rose", "iris", "sunflower", "anemone", "tulip")
length(flower)
nchar(flower)  # 주어진 문자열 data의 길이 (number of character)

# 2개 다 동일한 값으로 나옴 
sapply(flower, function(d) if(nchar(d) > 5) return(d))  # 5보다 큰 것만 리턴(여기선 리스트로 리턴)
sapply(flower, function(d) if(nchar(d) > 5) d)


sapply(flower, function(d) if(nchar(d) > 5) return(d) else return(NA))
sapply(flower, function(d) paste("-",d,"-", sep=""))


# default는 n=5 
sapply(flower, function(d, n=5) if(nchar(d) > n) return(d))

# 여기서 3은 function에게 전달되는 아규먼트로 작용함
sapply(flower, function(d, n=5) if(nchar(d) > n) return(d), 3)
sapply(flower, function(d, n=5) if(nchar(d) > n) return(d), n=3)



count <- 1
myf <- function(x, wt=T){
  print(paste(x,"(",count,")"))
  Sys.sleep(3)
  if(wt) 
    r <- paste("*", x, "*")
  else
    r <- paste("#", x, "#")
  count <<- count + 1;
  return(r)
}
result <- sapply(df$w, myf)
length(result)
result
sapply(df$w, myf, F)
sapply(df$w, myf, wt=F)
rr1 <- sapply(df$w, myf, wt=F)
str(rr1)

count <- 1
sapply(df, myf)  # function이 두번 호출됨. 한번은 열대로. 
rr2 <- sapply(df, myf)
str(rr2)
rr2[1,1]
rr2[1,"w"]

