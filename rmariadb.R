install.packages("reshape")
library(reshape)
library(rJava)
library(RJDBC)
library(DBI)

str(iris)
head(iris, 6)

iris <- rename(iris, c(Sepal.Length="slength", 
                       Sepal.Width="swidth", 
                       Petal.Length="plength", 
                       Petal.Width="pwidth",
                       Species="species"))
dbWriteTable(conn, "iris", iris)

iris_all <- dbGetQuery(conn, iris)
  
iris_setosa = "select * from iris where species ='setosa'"
iris_versicolor = "select * from iris where species = 'versicolor'"
iris_verginica = "select * from iris where species = 'virginica'"
dbGetQuery(conn, iris_setosa)
dbGetQuery(conn, iris_versicolor)
dbGetQuery(conn, iris_verginica)




productdf <- data.frame(read.table("C:/Rexam/data/product_click.log"))
names(productdf) <- c('clicktime','pid')

dbWriteTable(conn, "productlog", productdf)
p003 = "select * from productlog where pid = 'p003'"
# 문자열 데이터는 단일 인용부호만 지원하는 경우도 있다
# 비교값만 인용부호를 설정, 이때 pid와 같은 이름은 인용부호 x
dbGetQuery(conn, p003)




emp <- data.frame(read.csv("C:/Rexam/data/emp.csv"))
dbWriteTable(conn, "emp", emp)


result1 <- "select * from emp order by sal desc"
dbGetQuery(conn, result1)

result2 <- "select * from emp order by hiredate asc"
dbGetQuery(conn, result2)

result3 <- "select * from emp where sal >= 2000"
dbGetQuery(conn, result3)

result4 <- "select * from emp where sal >= 2000 && sal < 3000"
dbGetQuery(conn, result4)




