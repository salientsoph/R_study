
memo <- readLines("C:/Rexam/data/memo.txt")

memo[1] <- gsub("[[:punct:]]", "", memo[1]) 


memo[5] <- gsub("[[:punct:][:digit:]]", "", memo[5]) 
memo[6] <- gsub(" ", "", memo[1]) 
memo[7] <- gsub("YOU", "you", memo[7])
memo[8] <- gsub("OK", "ok", memo[8])

write.table(memo, sep='\n', file='C:/Rexam/memo_new.txt')
