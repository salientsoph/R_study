

# 데이터 전처리(2) - 날짜와 시간 관련 기능을 지원하는 함수들

(today <- Sys.Date())
format(today, "%Y년 %m월 %d일%")
format(today, "%d일 %B %Y년")
format(today, "%y")  # 년도 끝에 2개 숫자
format(today, "%Y")  # 년도 4개 숫자
format(today, "%B")  # "*월"
format(today, "%a")  # "*"요일
format(today, "%A")  # "*요일"
weekdays(today) # "*요일"
months(today)  # "*월"
quarters(today)  # 4분의 몇 분기인지 
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
strptime(x1, "%Y-%m-%d %H:%M:%S")  # 특정 형식의 날짜 문자열 <-> datetime 객체
strptime('2019-08-21 14:10:30', "%Y-%m-%d %H:%M:%S")  # M: 분

x2 <- "20200601"
as.Date(x2, "%Y%m%d")  # m: 월
datetime<-strptime(x2, "%Y%m%d")
str(datetime)


# 시간 간 계산
# POSIXct: UNIX epoch(1970년) 부터 지금까지의 초를 저장하는 방식
# POSIXlt: 시간을 년/월/일/시/분/초 등으로 저장하는 방식
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
# ct,lt: 초시간을 아규먼트로 받을 수 있다. origin=이때를 시점으로 
as.POSIXct(1449894438,origin="1970-01-01")
as.POSIXlt(1449894438,origin="1970-01-01")
as.POSIXlt(1600823980,origin="1970-01-01")

# wday= 일주일 중 무슨 요일인지 숫자로 표현(ex.일요일=0, 수요일=3)
as.POSIXlt("2020/09/23")$wday
as.POSIXlt("2020/09/27")$wday
as.POSIXlt("2020/09/24")$wday
as.POSIXlt("2020/12/25")$wday
as.POSIXlt("2020/01/01")$wday


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
nchar(x)  # blank도 하나의 문자열로 계산
length(x)

y <- c("We", "have", "a", "dream", "###")
length(y)
nchar(y)

letters
sort(letters, decreasing=TRUE)  #역순으로

fox.says <- "It is only with the HEART that one can See Rightly"
tolower(fox.says)  # 모두 소문자로
toupper(fox.says)  # 모두 대문자로

# 문자열 찾기. start 어디서부터, stop 어디까지
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
# grep(찾고자하는 문자열, x라는 매개변수에 지정된(x=는 생략 가능) graph함수를 지정할 것)
# 인덱스가 나온다

index <- grep("New", landmesses)
landmesses[index]

# 동일
grep("New", landmesses, value=T)
# index 대신 value 값 (value=T)


txt <- "Data Analytics is useful. Data Analytics is also interesting."
sub(pattern="Data", replacement="Business", x=txt)
gsub(pattern="Data", replacement="Business", x=txt)

x <- c("test1.csv", "test2.csv", "test3.csv", "test4.csv")
gsub(".csv", "", x)


gsub("[ABC]", "@", "123AunicoBC98ABC")
gsub("ABC", "@", "123AunicoBC98ABC")
gsub("(AB)|C", "@", "123AunicoBC98ABC")
gsub("A|(BC)", "@", "123AunicoBC98ABC")
gsub("A|B|C", "@", "123AunicoBC98ABC")



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
grep("\\D", words2, value=TRUE)  # 숫자가 아닌 것을 꺼냄(대문자:반대의 의미)
grep("\\s", words2, value=TRUE)  # space(공백)을 꺼냄



fox.said <- "What is essential is invisible to the eye"
fox.said
strsplit(x= fox.said, split= " ")  # 공백을 기준으로 분리
strsplit(x= fox.said, split="")

fox.said.words <- unlist(strsplit(fox.said, " "))  #벡터로 변환환
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




search()    # load된 패키지들을 확인



# 데이터 시각화
install.packages("showtext")
library(showtext)
showtext_auto() 
font_add(family = "cat", regular = "c:/Rexam/fonts/HoonWhitecatR.ttf")
font_add(family = "dog", regular = "c:/Rexam/fonts/THEdog.ttf")
font_add(family = "maple", regular = "c:/Rexam/fonts/MaplestoryBold.ttf")
rainbow(10)

국어<- c(4,7,6,8,5,5,9,10,4,10)  
plot(국어)

plot(국어, type="o", col="blue", family="maple")       
title(main="성적그래프", col.main="red", font.main=4, family="maple")

국어 <- c(4,7,6,8,5,5,9,10,4,10)
수학 <- c(7,4,7,3,8,10,4,10,5,7)


plot(국어, type="o", col="blue")
lines(수학, type="o", pch=16, lty=2, col="red")     
title(main="성적그래프", col.main="red", font.main=3)

국어 <- c(4,7,6,8,5,5,9,10,4,10)
par(mar=c(1,1,1,1), mfrow=c(4,2))

plot(국어, type="p", col="blue", main="type = p", xaxt="n", yaxt="n")
plot(국어, type="l", col="blue", main="type = l", xaxt="n", yaxt="n")
plot(국어, type="b", col="blue", main="type = b", xaxt="n", yaxt="n")
plot(국어, type="c", col="blue", main="type = c", xaxt="n", yaxt="n")
plot(국어, type="o", col="blue", main="type = o", xaxt="n", yaxt="n")
plot(국어, type="h", col="blue", main="type = h", xaxt="n", yaxt="n")
plot(국어, type="s", col="blue", main="type = s", xaxt="n", yaxt="n")
plot(국어, type="S", col="blue", main="type = S", xaxt="n", yaxt="n")
par(mar=c(5,5,5,5), mfrow=c(1,1))

#국어 <- c(4,7,6,8,5,5,9,10,4,10); 
#수학 <- c(7,4,7,3,8,10,4,10,5,7)


plot(국어, type="o", col="blue", ylim=c(0,10), axes=FALSE, ann=FALSE)

# x, y 축 추가하기
axis(1, at=1:10, lab=c("01","02","03","04", "05","06","07","08","09","10"), family="maple") # x축 추가
axis(2, at=c(0,2,4,6,8,10), family="maple")  # y축 추가

# 그래프 추가하고, 그래프에 박스 그리기
lines(수학, type="o", pch=16, lty=2, col="red")    
box()   # 박스 그리기

# 그래프 제목, 축의 제목, 범례 나타내기
title(main="성적그래프", col.main="red", font.main=4, family="maple") 
title(xlab="학번", col.lab=rgb(0,1,0), family="maple")  
title(ylab="점수", col.lab=rgb(1,0,0), family="maple")  
legend(8, 3, c("국어","수학"), cex=1.2, col=c("blue","red"), pch=c(21,16), lty=c(1,2))  



(성적 <- read.table("c:/Rexam/data/성적.txt", header=TRUE))

plot(성적$학번, 성적$국어, main="성적그래프", xlab="학번", ylab="점수",  xlim=c(0, 11), ylim=c(0, 11)) 

ymax <- max(성적[3:5]) #성적 데이터 중에서 최대값을 찾는다(y 축의 크기 제한)
ymax
pcols<- c("red","blue","green")
png(filename="성적.png", height=400, width=700, bg="white") # 출력을 png파일로 설정
plot(성적$국어, type="o", col=pcols[1], ylim=c(0, ymax), axes=FALSE, ann=FALSE)
axis(1, at=1:10, lab=c("01","02","03","04","05","06","07","08","09","10"))
axis(2, at=c(0,2,4,6,8,10), lab=c(0,2,4,6,8,10))
box()
lines(성적$수학, type="o", pch=16, lty=2, col=pcols[2])
lines(성적$영어, type="o", pch=23, lty=3, col=pcols[3] )
title(main="성적그래프", col.main="red", font.main=4)
title(xlab="학번", col.lab=rgb(1,0,0))
title(ylab="점수", col.lab=rgb(0,0,1))
legend(1, ymax, names(성적)[c(3,4,5)], cex=0.8, col=pcols, pch=c(21,16,23), lty=c(1,2,3))
dev.off()  
# 출력장치에 대해 redirection(plot말고 다른곳에 나오게)해제. 마지막에 꼭 해줘야함!!!

plot(국어, 수학)
plot(수학~국어)

?plot
