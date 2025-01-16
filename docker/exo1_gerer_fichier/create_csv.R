print("Hello")

data <- data.frame(
  "categ" = c("categ1", "categ2", "categ3"),
  "number" = c(100, 200, 250),
  "prop" = c(.1, .5, .33)
)

print(data)
write.csv(data, "/home/results/dummy_data.csv")
