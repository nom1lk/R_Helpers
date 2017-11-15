
# Make some vectors of random length
x <- 1
for (i in 1:5) {
  assign(paste("v", i, sep=""),abs(seq(1,ceiling(rnorm(1,10,4)),1)))
}

v1
v2
v3
v4
v5

# Put vector names into an object
group <- c()
for (i in 1:5) {
  group[i] <- paste("v",i,sep="")
}

# Get the length of the longest vector
g <- c()
for (i in 1:length(group)) {
  g[i] <- length(get(group[i]))
}
max(g)

# Assign NAs to the elements of each vector until all vectors are as long as the longest vector
for (i in 1:length(group)) {
  assign(group[i], c(get(group[i]), rep(NA, max(g) - length(get(group[i])))))
}

# Bind vectors togehter and convert into dataframe
abcde <- cbind(sapply(group[1:5], get))
abcde <- as.data.frame(abcde)
abcde




