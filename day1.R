# R 공부 첫 시작!
# ':'은 벡터 만들 때 사용
v1 <- 1:10
v1 = 1:10
1:10 -> v1
# : 사이엔 띄어도, 안 띄어도 됨
# 한 줄에 여러개 넣고 싶으면 ';' 사용


# print 안 쓰는 건 단독일 때만 가능.(console창에만 나타남)
print(v1)
v1
1:100
100:1

(v2 <- v1 + 100); v2  # ()로 묶으면 식으로 간주해서 console 창에 나옴
v3 <- v1 * 10; v3
ls()  # list의 약어. 


# c(): 벡터 함수 만들기
v4 <- c(10, 5, 7, 4, 15, 1) # 벡터값 지정
v5 <- c(100, 200, 300, '사백')

# seq()
seq(1, 10)
seq(1, 10, 2)
seq(0, 100, 5)

# rep() = repeat
rep(1, 100)  # 1을 100번 반복
rep(1:3, 5)  # 1부터 3을 5번 반복
rep(1:3, times=5) # 키워드 파라미터. 위와 같은 결과
rep(1:3, each=5)# 각각 반복(1 5개, 2 5개, 3 5개)
?rep  # = help() = 설명을 해줌 


LETTERS # 대문자 알파벳
letters # 소문자 알파벳
month.name # 월별 이름
month.abb # 월별 간축이름
pi # pi 원주율

LETTERS;letters;month.name;month.abb;pi


LETTERS[1]; LETTERS[c(3,4,5)]
LETTERS[3:5]; LETTERS[5:3]
LETTERS[-1] # - 인덱스: 그 원소만 빼고 출력(여기서는 1만 빼고 출력)
LETTERS[c(-2,-4)] # 2랑 4만 빼고 출력


length(LETTERS) # 데이터의 갯수
length(month.name)
length(pi)


x <- c(10,2,7,4,15)
x
print(x)
class(x) # 데이터의 타입을 체크
class(letters) # character
rev(x) # rev 함수에서만 새로운 벡터를 리턴(기존 벡터는 변경 없음)
range(x) # 최소값, 최대값을 꺼냄
sort(x) # (accendent)
sort(x, decreasing = TRUE) # (decendent)
sort(x, decreasing = T) # 위와 동일
x <- sort(x)
order(x) # 인덱스 나열, accendent. 가장 작은 element값부터 순서대로 인덱스를 나열함


x[3] <- 20
x
x + 1 # 각각 element 마다 +1
x <- x + 1
max(x);min(x);mean(x);sum(x)
summary(x) # 수치데이터들 


x[c(2,4)] # = x[2], x[4]. 인덱스값을 줌. 이에 해당되는 element(2,4)는 True.
x[c(-2,-4)] # 2, 4 가 False.
x[c(F,T,F,T,F)] 
x[c(T,F)] # 반복해서 적용함(T,F,T,F,..식으로)
x > 5 # 원소마다 5보다 큰지 확인
x[x > 5] # x 값 중에서 5보다 큰값만 추출
x[x > 5 & x < 15] # 5초과, 15미만 인 값만 추출(각각의 원소마다)
x[x > 5 && x < 15] # 벡터의 첫번째 원소만 고려
x[x > 5 | x < 15] # | = or. 5 초과 이거나 15 미만


# names(): textminding 할 때 사용
names(x) # x 벡터의 이름 벡터(현재는 정해져있지 않으므로 null)
names(x) <- LETTERS[1:5] # 각각의 element마다 고유의 이름 부여 가능
names(x)
names(x) <- NULL # 네임벡터 없애기
names(x)
x[2];x["B"]; # 인덱싱 2번째의 네임벡터를 'B'로 지정
# x[B()]: B라는 함수를 가져와서 x에 대입하고 리턴



# &(각각의 원소마다), &&(첫번째 원소만)
c(T, T, F, F) & c(T, F, T, F) # T F F F 
c(T, T, F, F) | c(T, F, T, F) # T T T F
c(T, T, F, F) && c(T, F, T, F) # T
c(T, T, F, F) || c(T, F, T, F) # T


ls()
rm(x) # 벡터 삭제
x
class(x)

rainfall <- c(21.6, 23.6, 45.8, 77.0, 
              102.2, 133.3,327.9, 348.0, 
              137.6, 49.3, 53.0, 24.9)
rainfall > 100  # boolean 값으로 나타남 
rainfall[rainfall > 100] # rainfall 중에서 100 이상의 값인 rainfall 값을 나타냄

which(rainfall > 100) # 인덱스를 뽑아냄

month.name[which(rainfall > 100)]  
month.abb[which(rainfall > 100)]
month.korname <- c("1월","2월","3월",
                   "4월","5월","6월",
                   "7월","8월","9월",
                   "10월","11월","12월")
month.korname[which(rainfall > 100)]
which.max(rainfall)
which.min(rainfall)
month.korname[which.max(rainfall)]
month.korname[which.min(rainfall)]


# sample 함수(벡터함수, 몇 개 꺼낼건지)
sample(1:20, 3) # 1~20 중 3개 랜덤 추출
sample(1:45, 6)
sample(1:10, 7)
sample(1:10, 7, replace=T) # replace=T: 중복해도 상관 없을 때 


# paste: 아규먼트로 이루어진 것들을 하나로 결합해줌
paste("I'm","Duli","!!") #default: 각각의 element 사이사이 blank 줌
paste("I'm","Duli","!!", sep="-")
paste("I'm","Duli","!!", sep="") # 공백을 없앨 때
paste0("I'm","Duli","!!") # paste0: 중간에 공백을 없앰, 위와 동일


fruit <- c("Apple", "Banana", "Strawberry")
food <- c("Pie","Juice", "Cake")
paste(fruit, food)


paste(fruit, food, sep="")
paste(fruit, food, sep=":::")
paste(fruit, food, sep="", collapse="-") # collapse: 각각의 element를 붙임
paste(fruit, food, sep="", collapse="")
paste(fruit, food, collapse=",")






# matrix 실습
x1 <-matrix(1:8) # 8행 1열
x1
x1 <-matrix(1:8, nrow = 2) # 2행 4열
x1
x1<-x1*3
x1
sum(x1); min(x1);max(x1);mean(x1)


# matrix: 모든 열의 행의 갯수가 같고, 모든 행의 열의 갯수가 같다.
x2 <-matrix(1:8, nrow =3) # 3행(-> 열의 갯수가 3의 배수여야함)
x2

(chars <- letters[1:10])

mat1 <-matrix(chars)
mat1; dim(mat1)
matrix(chars, nrow=1) # 1행
matrix(chars, nrow=5) # 5행, 데이터를 열부터 채운다
matrix(chars, nrow=5, byrow=T) # byrow=T: 데이터를 행부터 채운다
matrix(chars, ncol=5) 
matrix(chars, ncol=5, byrow=T)
matrix(chars, nrow=3, ncol=5)
matrix(chars, nrow=3)


vec1 <- c(1,2,3)
vec2 <- c(4,5,6)
vec3 <- c(7,8,9)
mat1 <- rbind(vec1,vec2,vec3); mat1 # vec1, vec2, vec3을 행으로 받음  
mat2 <- cbind(vec1,vec2,vec3); mat2 # vec1, vec2, vec3을 열로 받음 
mat1[1,1]
mat1[2,];mat1[,3]
mat1[1,1,drop=F]
mat1[2,,drop=F];mat1[,3,drop=F]

rownames(mat1) <- NULL
colnames(mat2) <- NULL
mat1;mat2
rownames(mat1) <- c("row1","row2","row3")
colnames(mat1) <- c("col1","col2","col3")
mat1
ls()
mean(x2)
sum(x2)
min(x2)
max(x2)
summary(x2)

mean(x2[2,])
sum(x2[2,])
rowSums(x2); colSums(x2)



# apply(matrix or array, 방향, 처리할 내용)
x2
apply(x2, 1, sum) # 1:행. 같은 행에 있는 값들을 더함
apply(x2, 2, sum) # 2:열. 같은 열에 있는 값들을 더함
?apply
apply(x2, 1, max)
apply(x2, 1, min)
apply(x2, 1, mean)

apply(x2, 2, max)
apply(x2, 2, min)
apply(x2, 2, mean)





#Array 실습

a1 <- array(1:30, dim=c(2,3,5)) #행, 열, 층
a1

a1[1,3,4] # 1행 2열 4층의 element 추출
a1[,,3] # 3층의 모든 element
a1[,2,] # 모든 층에 대해 2열의 모든 element
a1[1,,] # 모든 층에 대해 1행의 모든 element



