require(rgl)

var1 <- c(-0.42851733, 1.919442397, -1.903711958)
var2 <- c(1.665832756, -0.837439878, -1.301100833)
var3 <- c(-0.740856388, -1.687152936, -1.21745445)

plot(var1, var2)
plot3d(var1, var2, var3, xlab = "participle", ylab = "adjective", zlab = "pronoun", type = "s")