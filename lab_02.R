# 문제1

# 10 에서 38사이의 숫자 중에서 2씩 증가한 값으로 벡터를 생성하고
# 3행 5열의 매트릭스를 만들어 m1 에 저장한다.(행 우선 저장)
v1 <- seq(10, 38, 2)
m1 <- matrix(v1, nrow=3, byrow=T)
m1

# 각 원소 값들에 100을 더한 결과로 매트릭스 m2 를 만든다.
m2 <- m1+100
# m1 에서 최대값을 추출하여 m_max_v 에 저장한다.
m_max_v <- max(m1)
# m1 에서 최소값을 추출하여 m_min_v 에 저장한다.
m_min_v <- min(m1)
# m1 에서 행 단위의 최대값을 추출하여 row_max 에 저장한다.
row_max <- apply(m1, 1, max)
# m1 에서 열 단위의 최대값을 추출하여 col_max 에 저장한다.
col_max <- apply(m1, 2, max)
# m1, m2, m_max_v, m_min_v, row_max, col_max를 화면에 출력한다.
m1; m2; m_max_v; m_min_v; row_max; col_max



# 문제2
n1 <- c(1,2,3)
n2 <- c(4,5,6)
n3 <- c(7,8,9)
m2 <- cbind(n1, n2, n3)
m2

num <- c(n1, n2, n3)
matrix(num, nrow=3)


# 문제3 
n4 <- c(1:9)
m3 <- matrix(n4, nrow=3, byrow=T)
m3



# 문제4
m4 <- m3
rownames(m4) <- c("row1", "row2", "row3")
colnames(m4) <- c("col1", "col2", "col3")
m4


# 문제5 
# 다음과 같이 구성 되는 2행 3열 매트릭스 alpha를 생성한 후에
# alpha에 ‘x’, ‘y’, ‘z’ 라는 행을 추가하여 alpha2 를 만들고 출력한다.
# alpha에 ‘s’, ‘p’ 라는 열을 추가하여 alpha3 를 만들고 출력한다.

alpha <- matrix(letters[1:6],2,3)
row1 <- c('x', 'y', 'z')
alpha2 <- rbind(alpha, row1)
alpha2<- rbind(alpha, letters[24:26])
col1 <- c('s', 'p')
alpha3 <- cbind(alpha2, col1)
alpha3<- cbind(alpha, letters[16:19])



# 문제6

a <- array(1:24, dim=c(2,3,4)) 

#(1) 2행3열4층의 데이터를 출력한다.
a[2,3,4]
#(2) 각 층마다 2행의 데이터를 출력한다.
a[2,,]
#(3) 각 층마다 1열의 데이터를 출력한다.
a[,1,]
#(4) 3층의 모든 데이터를 출력한다.
a[,,3]
#(5) a라는 배열을 구성하는 모든 데이터에 100을 + 연산하여 출력한다.
a + 100
#(6) 4층의 모든 데이터들에 100을 곱한 결과를 출력한다.
a[,,4]*100
#(7) 각층의 1행, 2열과3열만 출력한다.
a[1,2,]
a[1,3,]
#(8) 2층의 2행 데이터들의 값을 100을 더한 값으로 변경한다.
a[,2,2] <- a[,2,2]+100
#(9) 1층의 모든 데이터들의 값에 2를 뺀 값으로 변경한다.
a[,,1] <- a[,,1]-2
#(10) a 배열의 모든 데이터 값들을 10을 곱한 값으로 변경한다.
a <- a*10
#(11) a 변수를 삭제한다.
a <- NULL; a
rm(a)


