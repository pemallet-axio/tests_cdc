print("Modification du csv")
df = read.csv("/home/results/dummy_data.csv")
print(df)
df[[3]][2] = 22
df[[4]][2] = .9
print(df)

write.csv(df, "/home/results/dummy_data_out.csv")
