# 문제1
exam1 <- function() return(paste(LETTERS,letters, sep=""))
exam1()
ans1 <- exam1() 
ans1


# 문제2
exam2 <- function(num) return(sum(1:num))
exam2(3)
ans2 <- exam2(5)
ans2


# 문제3
exam3 <- function(num1, num2)
  if(num1<num2){
    return (num2 - num1)
  } else if(num1>num2){
    return (num1 - num2)
  } else{
    return (0) 
  }

a1 <- exam3(10, 20); a1
a2 <- exam3(20,5); a2
a3 <- exam3(5,30); a3
a4 <- exam3(6,3); a4
a5 <- exam3(4,4); a5


# 문제4
exam4 <- function(x,oper,y){
  if(oper!="+"&&oper!="-"&&oper!="*"&&oper!="%/%"&&oper!="%%"){
    return ("규격의 연산자만 전달하세요")
  }else if(x==0 & oper=="%/%"|oper=="%%"){
    return ("오류1")
  }else if(y==0 & oper=="%/%"|oper=="%%"){
    return ("오류2")
  }else{
    if(oper=="+"){
      result = x + y
    }else if(oper=="-"){
      result = x - y
    }else if(oper=="*"){
      result = x * y
    }else if(oper=="%/%"){
      result = x %/% y
    }else{
      result = x %% y
    }
    return(result)
  }
}

  
r1 <- exam4(4,"+", 5);r1
r2 <- exam4(4,"*",8);r2
r3 <- exam4(4,"///",9);r3
r4 <- exam4(0,"%%",9);r4
r5 <- exam4(5,"%/%",0);r5



# 문제5
exam5 <- function(p1, p2="#"){
  if(p1<0){cat("\n")
  }else{
    for(count in (1:p1)){
      cat(p2)}
    cat("\n")
  }
}
exam5(-3)
exam5(4)
exam5(3,"*")



  
# 문제6
exam6 <- function(...){
  score <- c(...)
  for(data in score){
    if(is.na(data)){     
      print("NA는 처리불가")
    }else{
      if(data>=85){
        grade <- 1
      }else if(data>=70){
        grade <- 2
      }else{
        grade <- 3
      }
      cat(data, "점은", 
        switch(EXPR = grade,"상","중","하"), "등급입니다", "\n")
    }
  }
}
  

exam6(80, 50, 70, 66, NA, 35)
