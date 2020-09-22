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

# 둘이 동일한 값으로 나옴 
sapply(flower, function(d) if(nchar(d) > 5) return(d))  # 5보다 큰 것만 리턴(여기선 리스트로 리턴)
sapply(flower, function(d) if(nchar(d) > 5) d)


sapply(flower, function(d) if(nchar(d) > 5) return(d) else return(NA))
sapply(flower, function(d) paste("-",d,"-", sep=""))

sapply(flower, function(d, n=5) if(nchar(d) > n) return(d))

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
sapply(df, myf)
rr2 <- sapply(df, myf)
str(rr2)
rr2[1,1]
rr2[1,"w"]




# 데이터 전처리(2) - 날짜와 시간 관련 기능을 지원하는 함수들

(today <- Sys.Date())
format(today, "%Y년 %m월 %d일%")
format(today, "%d일 %B %Y년")
format(today, "%y")
format(today, "%Y")
format(today, "%B")
format(today, "%a")
format(today, "%A")
weekdays(today) 
months(today) 
quarters(today)
unclass(today)  # 1970-01-01을 기준으로 얼마나 날짜가 지났지는 지의 값을 가지고 있다.
Sys.Date()
Sys.time()
Sys.timezone()

as.Date('1/15/2018',format='%m/%d/%Y') # format 은 생략 가능
as.Date('4월 26, 2018',format='%B %d, %Y')
as.Date('110228',format='%d%b%y') 

x1 <- "2019-01-10 13:30:41"
# 문자열을 날짜형으로
as.Date(x1, "%Y-%m-%d %H:%M:%S") 
# 문자열을 날짜+시간형으로
strptime(x1, "%Y-%m-%d %H:%M:%S")
strptime('2019-08-21 14:10:30', "%Y-%m-%d %H:%M:%S")

x2 <- "20200601"
as.Date(x2, "%Y%m%d")
datetime<-strptime(x2, "%Y%m%d")
str(datetime)

as.Date("2020/01/01 08:00:00") - as.Date("2020/01/01 05:00:00")
as.POSIXct("2020/01/01 08:00:00") - as.POSIXct("2020/01/01 05:00:00")
as.POSIXlt("2020/01/01 08:00:00") - as.POSIXlt("2020/01/01 05:00:00")

t<-Sys.time()
ct<-as.POSIXct(t)
lt<-as.POSIXlt(t)
str(ct) 
str(lt) 
unclass(ct) 
unclass(lt) 
lt$mon+1
lt$hour
lt$year+1900
as.POSIXct(1449894438,origin="1970-01-01")
as.POSIXlt(1449894438,origin="1970-01-01")

as.POSIXlt("2020/12/25")$wday
as.POSIXlt("2020/12/25")$wday
as.POSIXlt("2020/12/25")$wday
as.POSIXlt("2020/12/25")$wday
as.POSIXlt("2020/12/25")$wday


#올해의 크리스마스 요일 2가지방법(요일명,숫자)
christmas2<-as.POSIXlt("2020-12-25")
weekdays(christmas2)
christmas2$wday
#2020년 1월 1일 어떤 요일
tmp<-as.POSIXct("2020-01-01")
weekdays(tmp)
#오늘은 xxxx년x월xx일x요일입니다 형식으로 출력
tmp<-Sys.Date()
year<-format(tmp,'%Y')
month<-format(tmp,'%m')
day<-format(tmp,'%d')
weekday<-format(tmp,'%A')
paste("오늘은 ",year,"년 ",month,"월 ",day,"일 ",weekday," 입니다.",sep="")

format(tmp,'오늘은 %Y년 %B %d일 %A입니다')

# 데이터 전처리(3) - 문자열 처리 관련 주요 함수들 

x <- "We have a dream"
nchar(x)
length(x)

y <- c("We", "have", "a", "dream")
length(y)
nchar(y)

letters
sort(letters, decreasing=TRUE)

fox.says <- "It is only with the HEART that one can See Rightly"
tolower(fox.says)
toupper(fox.says)

substr("Data Analytics", start=1, stop=4)
substr("Data Analytics", 6, 14)
substring("Data Analytics", 6)

classname <- c("Data Analytics", "Data Mining", 
               "Data Visualization")
substr(classname, 1, 4)

countries <- c("Korea, KR", "United States, US", 
               "China, CN")
substr(countries, nchar(countries)-1, nchar(countries))

head(islands)
landmesses <- names(islands)
landmesses
grep(pattern="New", x=landmesses)

index <- grep("New", landmesses)
landmesses[index]
# 동일
grep("New", landmesses, value=T)


txt <- "Data Analytics is useful. Data Analytics is also interesting."
sub(pattern="Data", replacement="Business", x=txt)
gsub(pattern="Data", replacement="Business", x=txt)

x <- c("test1.csv", "test2.csv", "test3.csv", "test4.csv")
gsub(".csv", "", x)

words <- c("ct", "at", "bat", "chick", "chae", "cat", 
           "cheanomeles", "chase", "chasse", "mychasse", 
           "cheap", "check", "cheese", "hat", "mycat")

grep("che", words, value=T)
grep("at", words, value=T)
grep("[ch]", words, value=T)
grep("[at]", words, value=T)
grep("ch|at", words, value=T)
grep("ch(e|i)ck", words, value=T)
grep("chase", words, value=T)
grep("chas?e", words, value=T)
grep("chas*e", words, value=T)
grep("chas+e", words, value=T)
grep("ch(a*|e*)se", words, value=T)
grep("^c", words, value=T)
grep("t$", words, value=T)
grep("^c.*t$", words, value=T)

words2 <- c("12 Dec", "OK", "http//", 
            "<TITLE>Time?</TITLE>", 
            "12345", "Hi there")

grep("[[:alnum:]]", words2, value=TRUE)
grep("[[:alpha:]]", words2, value=TRUE)
grep("[[:digit:]]", words2, value=TRUE)
grep("[[:punct:]]", words2, value=TRUE)
grep("[[:space:]]", words2, value=TRUE)
grep("\\w", words2, value=TRUE)
grep("\\d", words2, value=TRUE)
grep("\\s", words2, value=TRUE)



fox.said <- "What is essential is invisible to the eye"
fox.said
strsplit(x= fox.said, split= " ")
strsplit(x= fox.said, split="")

fox.said.words <- unlist(strsplit(fox.said, " "))
fox.said.words
fox.said.words <- strsplit(fox.said, " ")[[1]]
fox.said.words
fox.said.words[3]
p1 <- "You come at four in the afternoon, than at there I shall begin to the  happy"
p2 <- "One runs the risk of weeping a little, if one lets himself be tamed"
p3 <- "What makes the desert beautiful is that somewhere it hides a well"
littleprince <- c(p1, p2, p3)
strsplit(littleprince, " ")
strsplit(littleprince, " ")[[3]] 
strsplit(littleprince, " ")[[3]][5]



