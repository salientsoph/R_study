# R 설치 후 할 일

## 1. option 설정

1. setting-global options-code-saving-default text encoding: utf-8 로 수정

2. appearance-font size 



## 2. project(폴더) 만들기

1. file-new project-new directory-new project-'Rexam' c드라이브에.

2. file-new file-R script





# R이란

![](C:\Users\salient\Pictures\R.png)

## 1. R vs python

1. __SQL, R__: 데이터가 주인공  

   - 어떤 데이터를 다루느냐, 연산자가 뭐 있는지, 제어문이 뭐 있는지가 R의 절반.

   - 기본 구문이 잘 만들어져 있다. 
   - Javascript 의 함수와 비슷하다.

2. __파이썬 등__: 로직이 주인공



## 2. R의 자료형

1. __문자형(charactar)__: 문자, 문자열

   -> 문자, 문자열 구분하지 않는다.

2. __수치형(numeric)__: 정수(integer), 실수(double)

3. __복소수형(complex)__: 실수 + 허수

4. __논리형(logical)__: 참값, 거짓값



## 3. R의 데이터값

1. __문자형 리터럴__: "가나다", '가나다', '', '123', "abc"
   - 대문자, 소문자 구분 필요
   - 내용 없는 null 문자열도 가능
2. __수치형 리터럴__: 100, 3.14, 0
3. __논리형 리터럴__: TRUE(=T), FALSE(=F)
   - 모두 대문자(파이썬은 첫문자만 대문자, Javascript는 모두 소문자)
4. __NULL__: 데이터 셋(객체)이 비어있음을 의미함
   - R은 class 등은 정의 불가
5. __NA__: Not Available. 아직 정해져있지 않음. 데이터 셋의 내부에 존재하지 않는 값(격측치)를 의미
   - 가장 많이 쓰임
   - 전처리시 NA를 어떻게 처리해야할지가 중요
6. __NaN__: Not A Number. 숫자가 아님. 
   - Inf: 무한대값



## 4. 타입 체크 함수들

1. is.character(x) - 문자형

2. is.logical(x) - 논리형

3. is.numeric(x) - 수치형

4. is.double(x) - 실수형

5. is.integer(x) - 정수형

6. is.null(x)

7. is.na(x) -중요!!! <na 값인가>를 체크함(각각 원소마다)

8. is.nan(x)

9. is.finite(x)

10. is.infinite(x)



## 5. 자동형 변환 룰

- __문자형(character) > 복소수형(complex) > 수치형(numeric) > 논리형(logical)__

  ex) 문자형 + 수치형 = 문자형



## 6. 강제형 변환 함수

1. as.character(x)

2. as.complex(x)      

3. as.numeric(x)               

4. as.double(x)                         

5. as.integer(x)                  

6. as.logical(x)



## 7. 자료형 또는 구조 확인 함수

class(x), str(x), mode(x), typeof(x)







# R의 데이터 셋

1. __벡터(팩터)__: 주로 1차원

2. __행렬__: 2차원

3. __배열__: 행렬이 여러개. 3차원. 
   - 잘 쓸 일이 없다. 딥러닝 때는 쓸 일이 있지만, 그 외 일반적 데이터 분석에는 행렬까지 하면 충분.

4. __데이터프레임__

5. __리스트__: 모든 유형의 객체 집합(서로 다른 타입, 서로 다른 데이터셋 모두 가능)

-> 총 5개의 데이터 셋이 존재한다.

![](C:\Users\salient\Pictures\데이터셋.png)

- __동일한 유형의 데이터__:

  - array(배열), matrix(행렬), vector(벡터), scala(스칼라), factor(요인)

  - __동일한 타입의 데이터만 저장 가능__

  - 예) 모두 숫자형, 모두 문자형 등

  - 스칼라: 벡터에 포함된다. 하나의 데이터 타입. element가 1개인 벡터. 

    but R의 기본 데이터는 아니다. 벡터가 가장 작음. 
    
    

- __서로 다른 유형의 데이터__: (데이터 프레임: 가장 많이 쓰임)

  - 구조로 보면 행렬과 비슷, 2차원.



![](C:\Users\salient\Pictures\데이터셋2.png)







## 1. 벡터(Vector)

![](C:\Users\salient\Pictures\벡터.png)

- R 에서 다루는 __가장 기초적인 데이터셋(데이터 구조)__로서 1차원으로 사용된다.

- 하나의 데이터 값도 벡터로 취급된다.

- __동일 타입의 데이터만__으로 구성된다.
  
  - 문자형(character) > 수치형(numeric) > 논리형(logical))
  
- 벡터 생성 방법 : c(), seq(), rep(), __:__ 연산자
  - __c()__: 두 개 이상의 원소를 갖는 벡터들을 c() 함수의 인수로 준다.
    - ex) c(1,2,3,4,5); c("100", "200", "삼백"); c(T, R, R, T)
  - __seq()__: 숫자 간의 간격을 1 이외의 숫자로 줄 때
    - ex) seq(1, 10); seq(1, 10, 2); seq(0, 100, 5)
  - __rep()__: 주어진 값을 반복 사용
    - rep(1, 100) : 1을 100번 반복
    - rep(1:3, 5) : 1부터 3을 5번 반복
    - rep(1:3, times=5) :  (times:키워드 파라미터) 위와 같은 결과
    - rep(1:3, each=5) : (each:키워드 파라미터) 각각 반복(1-5개, 2-5개, 3-5개)
  - __: 연산자__: 하나씩 증가 또는 감소하는 숫자 벡터
    - v1 = 1:10; 1:10 -> v1

- 미리 정의된 내장 상수 벡터들 : LETTERS, letters, month.name, month.abb, pi

  - __LETTERS__: 대문자 알파벳
  - __letters__: 소문자 알파벳
  - __month.name__: 월별 이름
  - __month.abb__: 간축된 월별 이름
  - __pi__: pi 원주율

- 인덱싱 : __1__부터 시작하는 인텍스값과 [ 인덱스 ] 연산자 사용

  

  ### 주요 함수

  __length(v)__: 벡터의 element 갯수를 셀 때

  __names(v)__: 벡터에 이름을 부여할 때 (element 마다도 이름 부여 가능)

  __sort(v)__: accendent 나열 

  __sort(v, decreasing = TRUE)__: decendent 나열

  __order(v)__: 인덱스 나열, accendent 나열. 가장 작은 element값부터 순서대로 인덱스를 나열함

  ___

  #### sort() vs order()

  ```R
  > v <- c(10,3,7,4,8)
  
  > sort(v)  # accendent
  [1]  3  4  7  8 10
  
  > order(v)  # index로 나타남(accendent)
  [1] 2 4 3 5 1
  ```

  ___

  __class(v)__: 데이터의 타입을 체크

  __range(v)__: 최소값, 최대값을 출력

  __rev(v)__: 이 함수에서만 새로운 벡터를 리턴함(기존 벡터는 변경 없음)

  __max(v)__; 최대값

  __min(v)__; 최소값

  __mean(v)__; 평균

  __sum(v)__; 총 합

  __summary(v)__; 수치 데이터들 모두 보여줌

  __ls(v)__; 벡터를 모두 보여줌

  __rm(v)__; 벡터 삭제

  __sample(num1:num2, num3)__; 랜덤 추출

  - sample(1:20, 3);  1~20 중 3개 랜덤 추출
  - sample(1:10, 7, replace=T) ; replace=T: 중복해도 상관 없을 때 

  __paste(v1, v2, ...)__; element들을 하나로 결합해줌

  ```R
  > paste("I'm","Duli","!!", sep="")
  "I'mDuli!!"
  
  fruit <- c("Apple", "Banana", "Strawberry")
  food <- c("Pie","Juice", "Cake")
  > paste(fruit, food)
  "Apple Pie"       "Banana Juice"    "Strawberry Cake"
  ```

  __which(조건식)__; 인덱스 값을 뽑아냄

  ```R
  > rainfall <- c(21.6, 23.6, 45.8, 77.0, 102.2, 133.3, 327.9,
                  348.0, 137.6, 49.3, 53.0, 24.9)
  
  > rainfall > 100  # boolean 값으로 나타남
   [1] FALSE FALSE FALSE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE
  
  > rainfall[rainfall > 100]  # rainfall 중에서 100 이상의 값인 rainfall 값을 나타냄
  [1] 102.2 133.3 327.9 348.0 137.6
  
  # which
  > which(rainfall > 100) # 인덱스를 뽑아냄
  [1] 5 6 7 8 9
  
  > month.name[which(rainfall > 100)]
  [1] "May"       "June"      "July"      "August"    "September"
  > month.abb[which(rainfall > 100)]
  [1] "May" "Jun" "Jul" "Aug" "Sep"
  
  > month.korname <- c("1월","2월","3월","4월","5월","6월",
  +                    "7월","8월","9월","10월","11월","12월")
  > month.korname[which(rainfall > 100)]
  [1] "5월" "6월" "7월" "8월" "9월"
  
  # which
  > which.max(rainfall)
  [1] 8
  > which.min(rainfall)
  [1] 1
  > month.korname[which.max(rainfall)]
  [1] "8월"
  > month.korname[which.min(rainfall)]
  [1] "1월"
  ```

  

  



## 2. 행렬(Matrix)

![](C:\Users\salient\Pictures\행렬.png)



![](C:\Users\salient\Pictures\행열.png)

<img src="C:\Users\salient\Pictures\행과열.png" style="zoom:40%;" />

- 행(row, 가로)과 열(column, 세로)로 구성됨.

- __2차원의 벡터__이다. 

- __동일타입의 데이터만__ 저장 가능

- 인덱싱 : __[행의인덱싱, 열의인덱싱]__ ,[행의인덱싱, ], [, 열의인덱싱]

   - default: 열부터 데이터를 채운다. 즉, __데이터가 다 열로 들어간다.__

     ex) x1 <-matrix(1:8);  1~8을 8행 1열(행 갯수를 안줘서, 열부터 채운다.)

     x1 <-matrix(1:8, nrow = 2);  1~8을 2행 4열

- 행렬 생성방법 : 
  - __matrix(data=벡터, nrow=행의갯수, ncol=열의갯수)__
  - __matrix(data=벡터, nrow=행의갯수, ncol=열의갯수, byrow=TRUE)__
    - 열을 먼저 채움
    - byrow=T: 행의 방향으로 데이터를 채움
    - default; bybrow = false

- __rbind(v1, v2, ..)__, __cbind(v1, v2, ..)__: 벡터 간 결합, 벡터와 행렬을 결합
  - ex) mat1 <- rbind(vec1,vec2,vec3);  vec1, vec2, vec3을 행으로 받음
  - mat2 <- cbind(vec1,vec2,vec3);  vec1, vec2, vec3을 열로 받음 

- drop 속성을 사용해서 행렬구조 유지
  
  - mat1[1,1,__drop=F__]: mat1의 구조를 유지한 채로 (1,1)의 데이터값 추출



###   주요함수 

​	__dim(m)__: 행렬이 몇 차원(몇 행 몇 열)인지 체크. 

​	__nrow(m)__, __ncol(m)__: 행의 갯수, 열의 갯수

​	__rownames(m)__, __colnames(m)__: 행 이름, 열 이름

​	__rowSums(m)__, __colSums(m)__: 행 총합, 열 총합

​	__rowMeans(m)__, __colMeans(m)__: 행 평균, 열 평균

​	__apply(m, 방향, 처리할 내용)__: 

- 방향(1: 행, 2: 열)

- apply(x2, __1__, sum); 같은 __행__에 있는 값들을 더함

- apply(x2, __2__, sum); 같은 __열__에 있는 값들을 더함





## 3. 배열(Array)

![](C:\Users\salient\Pictures\배열.png)

- __3차원 벡터__이다.

- __동일타입의 데이터만__ 저장 가능

- 인덱싱 : [행의인덱싱, 열의인덱싱, 층(면)의인덱스]





## 4. 팩터(factor)

- R에서의 팩터 = 범주형 데이터
  - 범주형 데이터:
    - 사물의 범주(category)를 구분하는 목적으로 사용되는 데이터
    - ex) 성별(여자,남자), 산업(제조업,유통업,서비스업,농수산업), 차량(소형,중형,대형)
    - 질적자료로써, 측정 대상의 특성을 분류하거나 확인할 목적으로 부여한 값들
    - 값들의 순서 적용 여부에 따라 -> 명목형/순서형 
- 레벨을 원소로 하는 벡터. 벡터의 기본적인 특성을 가짐.
- 가능한 범주 값(level) 만으로 구성되는 벡터
  
  - level(레벨): 범주형 데이터에 포함된 가능한 범주값
- 벡터를 팩터로 바꾸면, 팩터로서의 특성이 부여됨(범주 값(질적 자료)으로 인식해버린다)
- 연속적 숫자가 아닌, 이상 숫자로 인식해버린다. (summary를 할 시 갯수를 세어버림)
- 팩터 생성 방법 : 
  - __factor(벡터)__
  - __factor(벡터[, levels=레벨벡터])__
  - __factor(벡터[, levels=레벨벡터], ordered=TRUE)__
  - __factor(벡터[,levers=레벨벡터,label=명칭벡터])__: 벡터 값을 label에 지정된 명칭에 따라 바꿈

- 팩터의 레벨 정보 추출 : __levels(팩터변수)__

  

  ### 주요함수

  __plot(f)__: 삼전도(그래프), 막대그래프 등 시각화 api를 그림

  __summary(f)__: 각 데이터가 몇 개 있는지 세어준다(level 기준)





## 5. 데이터프레임(data.frame)

- __2차원 구조__

- 열단위로 __서로 다른 타입의 데이터들__로 구성 가능

- __모든 열의 데이터 개수(행의 개수)는 동일해야 한다.__

- 데이터프레임 생성 방법 :
  - data.frame(백터들..)
  - data.frame(열이름=벡터,…)
  - data.frame(벡터들…[,**stringsAsFactors=FALSE**])   
    - default: 문자열을 캐릭터로 바꾼다(문자열을 팩터로 변환하기 싫을 때) 
    
      = ([stringsAsFactors=FALSE])
    
  - [stringsAsFactors=TRUE] : 팩터로 줄 수 있음
  - as.data.frame(벡터 또는 행렬 등)
    
    - as. ~ : ~로 바꿔라
  
- 데이터프레임 변환
  - rbind(df, 백터)
  - cbind(df, 벡터)

- 데이터프레임의 구조 확인: 
  - __str(df)__    structer 의 약어. 관측치(observation)과 각 level에 따른 데이터를 보여줌.
  - __dim(df)__   행의 갯수, 열의 갯수

- 인덱싱 : 

  - __[행의 인덱싱, 열의 인덱싱]__
  - [열의 인덱싱]  인덱싱을 하나만 지정한 경우->열이 우선
  - __df$컬럼이름__    컬럼이름 __하나만__ 지정 가능. 그래도 쓰는 이유는 가독성이 좋아서.
  - __[[열의 인덱싱]]__

- 원하는 행과 열 추출 : __subset(df, select=컬럼명들, subset=(조건))__

  ```R
  > subset(emp,select = c(ename, job, sal))
      ename       job  sal
  1   SMITH     CLERK  800
  2   ALLEN  SALESMAN 1600
  3    WARD  SALESMAN 1250
  4   JONES   MANAGER 2975
  
  > subset(emp,subset=emp$ename=="KING")
    empno ename       job mgr   hiredate  sal comm deptno
  9  7839  KING PRESIDENT  NA 1981-11-17 5000   NA     10
  
  > subset(emp,emp$ename=="KING")
    empno ename       job mgr   hiredate  sal comm deptno
  9  7839  KING PRESIDENT  NA 1981-11-17 5000   NA     10
  
  
  # select ename,sal from emp where sal>=2000
  subset(emp, select=c("ename","sal"), subset= emp$sal>= 2000)
  
  # c("ename","sal") = ename, sal만 추출. 연봉이 2000보다 큰.
  subset(emp, emp$sal>= 2000, c("ename","sal"))
  emp[emp$sal>=2000,c("ename","sal")]
  
  # select ename,sal from emp where sal between 2000 and 3000
  subset(emp, select=c("ename","sal"), subset=(sal>=2000 & sal<=3000))
  emp[emp$sal>=2000 & emp$sal <=3000, c("ename","sal")]
  
  ```

  

  ### 주요함수

  __names(df)__: col이 우선이기에 col 이름

  __colnames(df)__: 열 이름

  __rownames(df)__: 행 이름

  __ifelse(조건문, True일때, False일때)__

  ```R
  score$grade<-ifelse(score$sum >= 230,"A",
                      ifelse(score$sum >= 215,"B", 
                             ifelse(score$sum >=200,"C","D")))
  ```

  __table(df)__: 집계표를 만듦(팩트형이 아니어도 갯수를 셈)

  __as.character(df)__: 데이터(숫자 등)을 문자열로 바꿀 때







## 6. 리스트(list)

- 저장 가능한 __데이터의 타입, 데이터 셋의 종류에 제한이 없다.__ 

  -> 데이터의 타입이 다양해도, 데이터 셋의 종류가 다양해도 상관 없음

- (벡터, 행렬, 배열, 데이터 프레임, 리스트, 함수 등) __서로 다른 구조의 데이터__를 하나로 묶을 수 있는 자료구조

- 통계 분석 결과가 리스트 구조로 제시되는 경우가 많음

- 서로 다른 구조의 다수의 데이터 객체를 개별로 따로 따로 관리하는 것보다는, 이것들을 리스트라는 한 바구니에 정리해서 모아놓으면 관리하기 편함

- 리스트 생성 방법:

  - __list()__ 함수 
    - 리스트는 서브 리스트에 데이터값을 저장함

- 부분 집합 추출 방법:

  - __[__: 데이터 값을 리스트에 담아서 추출
    - 리스트가 포함한 하위 리스트를 뽑아낸다.
    - ex) 큰 장바구니(리스트) 안에 사과가 든 비닐봉지(서브 리스트)
    - -> 사과가 든 비닐봉지 째로 꺼낼 때
  - __[[__:  데이터 값을 벡터 그대로 추출, 이름이 부여되어 있지 않는 경우 사용
    - -> 사과들만 꺼낼 때
  - __$__: 데이터 값을 벡터 그대로 추출, 이름이 부여되어 있는 경우에만 사용 가능

- 리스트 해제: 

  - __unlist()__: 리스트를 벡터로 반환

 

- 리스트 예시

```R
a <- list(
    a = 1:3,
    b = "a string",
    c = pi,
    d = list(-1, -5)
)

# a 리스트: 4개의 데이터셋을 지님

# a, b, c: 벡터
# d: 리스트
```

![리스트](C:\Users\salient\Pictures\리스트.png)

```R
# “a string”를 꺼낼 때
> a$b
[1] "a string"

> a[[2]]
[1] "a string"

> a[2]    # -> 리스트 째로 추출
$b
[1] "a string"


a[[4]][1]  #-> 리스트로 감싼채로 추출(데이터셋의 1번 데이터를 리스트로 추출)
a[[4]][[1]]  #-> 벡터 추출

```



- 데이터셋의 중요성: 자료를 분석하기 위해, 다양한 형태의 개별 자료를 통합적으로 분석하기 위함

- ex) 개인 신용분석을 위해서는 개인의 소득, 부채, 성별, 학력 등등의 숫자형, 문자형, 요인(Factor)형 등의 자료

  -> 모두 데이터셋에 담아야 한다. 

- 변수와-관측값 (Variable-Observation) 형식의 자료를 분석

  -> 데이터프레임(data.frame)을 사용

- 리스트 vs 데이터프레임

  - 데이터프레임: 모든 변수에 대해서 관측값이 같은 길이를 갖도록 만들어 놓은 것

    -> 이에 비해 list는 관측값 길이 상관 없음

<img src="C:\Users\salient\Pictures\리스트데이터프레임.png" alt="리스트데이터프레임"  />







# R 연산자

<img src="C:\Users\salient\Pictures\연산자.png" alt="연산자"  />

- 논리 연산자

  - __&__: and 벡터연산

  - __&&__: and, 첫번째 데이터만 갖고 연산

  - __|__: or 벡터연산

  - __||__: or, 첫번째 데이터만 갖고 연산

- <<- : 함수에서 사용

- !

  ```R
  emp[!is.na(emp$comm),]  # !=not
  # is.na(emp$comm) == na로 나오는 직원이 TRUE
  # !is.na(emp$comm) == na로 안 나오는 직원이 TRUE
  ```


- 연산자 예시

```R
> y <- c(0,25,50,75,100)
> z <- c(50,50,50,50,50)

> y == z
[1] FALSE FALSE  TRUE FALSE FALSE
> y != z
[1]  TRUE  TRUE FALSE  TRUE  TRUE
> y > z
[1] FALSE FALSE FALSE  TRUE  TRUE
> y < z
[1]  TRUE  TRUE FALSE FALSE FALSE
> y >= z
[1] FALSE FALSE  TRUE  TRUE  TRUE
> y <= z
[1]  TRUE  TRUE  TRUE FALSE FALSE
> y == 50 # c(50, 50, 50, 50, 50)
[1] FALSE FALSE  TRUE FALSE FALSE
> y > 50
[1] FALSE FALSE FALSE  TRUE  TRUE

> num1 <- 11 # c(11)
> num2 <- 3  # c(3)
> num1 / num2
[1] 3.666667
> num1 %% num2 # 나머지
[1] 2
> num1 %/% num2  # 몫
[1] 3
```









# R의 데이터 입출력



## 데이터 출력 함수

1. __print(x, …)__   : 데이터셋을 출력. x = 프린트할 데이터셋.

   __print(출력데이터 [, 옵션들])__

2. __cat()__  : 메시지를 출력하는 기능. __자동으로 개행처리를 안하므로__, \n 을 같이 써줘야함.

   __cat(…, 옵션들…)__

```R
# print
> print(100)
[1] 100
> print(pi)
[1] 3.141593
> data <- "가나다"
> print(data)
[1] "가나다"
> print(data, quote=FALSE)
[1] 가나다
> v1 <- c("사과", "바나나", "포도")
> print(v1)
[1] "사과"   "바나나" "포도"  
> print(v1, print.gap=10)
[1]          "사과"            "바나나"          "포도"  

# cat
> cat(100)
100> cat(100,200)
100 200> cat(100,200,"\n")
100 200 
> cat("aaa", "bbb", "ccc", "ddd", "\n")
aaa bbb ccc ddd 
> cat(v1, "\n")
사과 바나나 포도 
> cat(v1, sep="-", "\n")
사과-바나나-포도-

# print vs cat
> print(paste("R", "은 통계분석", "전용 언어입니다."))
[1] "R 은 통계분석 전용 언어입니다."
> cat("R", "은 통계분석", "전용 언어입니다.", "\n")
R 은 통계분석 전용 언어입니다. 

```



## 데이터셋과 함수 저장

1. 모든 리스트 저장(working directory에 저장됨)
   - __save(list=ls(), file="all.rda")__

2. 모든 리스트 삭제 
   - __rm(list=ls()) __

3. 읽어오기
   - __load("all.rda")__

4. 한 개 저장
   - __save(변수명,  file="one.rda")__     xxx.RData



## 파일에서 데이터 읽어들이기

- __getwd()__    현재 working directory 확인

- __setwd('xxx')__  working directory 설정

- defult=native code이므로, UTF-8 -> encoding="UTF-8" 꼭 써야함(반드시 대문자)

  

1. __scan__
   - word단위로 읽음
   - 숫자를 읽어옴(숫자에 특화됨)
   - 문서가 숫자 이외의 문자도 있다면 -> what="" 꼭 써야함

```R
nums<- scan("sample_num.txt")
> nums
[1]  10  30  40 100  20  40  70

words_ansi<- scan("sample_ansi.txt", what="")     # 숫자 외의 문자도 포함
# word_ansi <- scan("data/sample_ansi.txt")  -> what="" 포함 안 해서 에러남

words_utf8 <- scan("sample_utf8.txt", what="", encoding="UTF-8")
```



2. __readlines__
   - 행 단위로 읽음

```R
lines_ansi <- readLines("data/sample_ansi.txt")
> lines_ansi
[1] "aaa 가나다 123" "bbb ccc ddd" 

lines_utf8 <- readLines("data/sample_utf8.txt",encoding="UTF-8")
```



3. __read__

   - read.csv: csv를 읽어오는데 특화됨.

   - url을 써도 읽어옴. 첫번째 행은 무조건 title로 인식.
     - title이 없는 csv인 경우, title이 없다는 걸 써줘야함.

```R
df1 <- read.csv("CSV파일 또는 CSV를 응답하는 URL")   # csv 파일을 팩터로 받음
emp <- read.csv(file.choose())   # 직접 파일을 선택할 수 있음
```





4. __read table__
   - 첫번째 행부터 data로 인식(title로 인식 안함)(read와 다름)
   - 열 이름은 따로 없이 v1 v2 v3... 로 붙임

```R
df2 <- read.table("일정한 단위(공백 또는 탭등)로 구성되어 있는 텍스트 파일 또는 URL")

# 필요에 따라서 stringsAsFactors 속성 사용
df2 <- read.table("data/product_click.log", stringsAsFactors = T)
```

 

5. __write.csv__(파일명), __write.table__(파일명)







# 제어문

- 주어진 명령을 수행하는데 있어서 조건에 따라서 수행여부를 정하고자 하는 경우

  -> __조건문(if 문)__

- 필요한 만큼 반복 수행하려는 경우 

  -> __반복문(for, while, repeat)__

- 제어문을 적용하여 __수행하려는 명령이 여러 개__이면 __블록({ })__ 로 구성한다.



## 1. if 문

- if(조건)

  수행명령문장

 

- if(조건){

   수행명령문장1}

  else{

  수행명령문장2

  수행명령문장3

  }



- if(조건1){

  수행명령문장1}

  else if(조건2){

   수행명령문장2}

  else if(조건3){

   수행명령문장3}

  else{

  수행명령문장}

  -> 여기서 else if는 여러개 가능)

  

## 2. ifelse 함수

__ifelse(조건, 조건이 참일 때 명령문1, 조건이 거짓일 때 명령문2)__

 

## 3. switch 함수

- __switch(EXPR=수치데이터, 식1, 식2, 식3, …)__

  - 원하는 만큼 식을 나열

  - 식이 어떤 타입인가에 따라서 결과값이 다르다

  - 수치데이터=1 -> 식1, 

    수치데이터=2 -> 식2, 

    수치데이터=3 -> 식3

    -> 순서대로 대입



- __switch(EXPR=문자열데이터, 비교값1=식1, 비교값2=식2, 비교값3=, 비교값4=식3, …, 식4)__

  - 비교값=식(키워드 파마리터마냥 식을 줌)

  - __비교값3=__ (blank) 이면, == 식3(다음 식을 불러옴)

  - (단독) __식4__ 이면 == (앞의 것들이 모두 아닐 때. default 값)

 

## 4. 반복문(for, while, repeat)

- __for (변수 in 데이터셋) {수행명령문장}__

 

- __while (조건) {수행명령문장}__

 

- __repeat 명령문 {수행명령문장} __

  - 적어도 한 번 이상 명령문을 실행할 시

  - (while (TRUE)와 동일) (무한 루프)

  - 무한 루프에서 벗어나기 위해 분기문을 반드시 포함

 

## 5. 분기문(break, next)

- __break__: 해당 루프(반복문)를 종료.

- __next__ 

  - 현재 반복을 종료하고 실행 위치를 다음 반복문으로 이동.

  - continue와 동일

 (반복문 내에서는 화면에 결과 출력시 출력함수(print() 또는 cat())를 사용해야 한다.)







# 함수

- R 프로그램의 주요 구성 요소로서 특정 작업을 독립적으로 수행하는 프로그램 코드 집합

- 함수를 사용하여 반복적인 연산을 효과적으로 할 수 있음
- javascript의 함수와 비슷함

- 함수의 처리 과정 

  - 시작(입력) :매개변수를 통해 아규먼트값을 받아옴.

  - 실행(연산) : 연산, 변환 등..

  - 종료(출력) :수행결과를 데이터셋으로 반환, 출력 등..

- 함수 정의 

​       함수명<- function([매개변수]) {

​       함수의 수행 코드(=수행 명령 문장들..)

​       [ return(리턴하려는값) ]

​		}

- 함수 호출 

  - __변수명<- 함수명()__

  - __변수명<- 함수명(아규먼트)__

  - __함수명()__

  - __함수명(아규먼트)__

- 호출시 함수가 정의하고 있는 매개변수(기본값이 없는) 사양에 맞춰서 아규먼트를 전달

  - 2개를 정의할 시, 2개 모두 전달 필요

- 기본값을 갖는 매개변수 선언하여 선택적으로 전달되는 아규먼트를 처리 가능

  -> 즉, default값 정의 가능

- 리턴값이 없는 함수: NULL 이 리턴

- 리턴값: return() 함수를 호출하여 처리함

  - return() 문이 생략된 경우: 마지막으로 출력된 데이터값이 자동으로 리턴

  - 가급적 리턴함수를 사용하여 명확히 구현하는 것이 필요

- 아규먼트의 타입을 제한:  is.xxxx() 함수(타입체크 함수) 활용

- 아규먼트의 개수와 타입을 가변적으로 처리 가능, 리턴값의 경우에도 선택적으로 처리 가능

  -> 가변형 아규먼트 사용

- 함수 안에서 만들어진 변수는 지역변수 (함수 밖: 전역변수(전역 대입 연산자 필요))
  - 지역변수: 함수내에서만 사용 가능
  - <- : 지역변수 설정

- 함수 안에서 만들어지지 않은 변수를 사용시: 전역 변수 사용
  - 전역변수에도 존재하지 않으면 오류 발생
- 함수내에서 전역변수에 값을 저장하려는 경우 대입연산자로 <<- 을 사용한다. 



```R

f1 <- function() print("TEST")  # f1()로 호출(아규먼트 없는 것만 호출 가능)

f2 <- function(num) {print("TEST"); print(num) } # f2(100)로 호출
												 # f2(100,200), f2() -> 모두 오류 발생

f3 <- function (p="R") print(p)	# f3(), f3(p="PYTHON"), f3("java")로 호출
								# f3()  p="R"
								# p라는 매개변수, R이라는 default 값

f4 <- function (p1="ㅋㅋㅋ",p2) for(i in 1:p2) print(p1)
			                            # f4(p1="abc", p2=3), f4("abc", 3) 로 호출
    									# -> 일일이 지정해서 호출
    
    									# f4("abc", 3)   -> 각각 p1, p2에 들어감
    
			                            # f4(5) 은 불가  -> 5가 p1으로 들어감(에러)
    									# f4(p2=5) 은 가능
										# p1은 생략 가능, p2는 생략 불가

f5 <- function(...) { print("TEST"); data <- c(...); print(length(data))}
					        # f5(10, 20, 30), f5(“abc”, T, 10, 20) 로 호출



```

