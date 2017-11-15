x <- 1
for (i in 1:5) {
  assign(paste("v", i, sep=""),abs(seq(1,ceiling(rnorm(1,10,4)),1)))
}

group <- c()
for (i in 1:5) {
  group[i] <- paste("v",i,sep="")
}

g <- c()
for (i in 1:length(group)) {
  g[i] <- length(get(group[i]))
}

max(g)

for (i in 1:length(group)) {
  assign(group[i], c(get(group[i]), rep(NA, max(g) - length(get(group[i])))))
}

abcde <- cbind(sapply(group[1:5], get))
abcde <- as.data.frame(abcde)
abcde





# cbind vectors of variable lengths

a <- seq(1, 10, 1)
b <- seq(1, 15, 1)
c <- seq(1, 6, 1)
d <- seq(1, 12, 1)
e <- seq(1, 11, 1)

group <- letters[1:5]
g <- c()

for (i in 1:length(group)) {
  
  g[i] <- length(get(group[i]))
  
}

max(g)

for (i in 1:length(group)) {
  
  assign(group[i], c(get(group[i]), rep(NA, max(g) - length(get(group[i])))))
  
}

abcde <- cbind(get(letters[1:5]))
abcde

c(group[i], c(1,2,3))


