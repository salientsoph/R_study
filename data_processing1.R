
v <- sample(1:26, 10)
length(v)

ran_al <- function(x){
  return(LETTERS[x])
}

result <- sapply(v, ran_al)
result