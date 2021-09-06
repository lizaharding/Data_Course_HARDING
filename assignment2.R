csv_files <- list.files(pattern= ".csv",path= "data",full.names=TRUE,recursive=TRUE)
csv_files
read.csv(csv_files[140])
length(csv_files)
df <- read.csv(csv_files[140])
head(df,n=5)
head(df[1:5])
list.files(pattern="*b",path="data",full.names=TRUE,recursive=TRUE)
list.files(recursive=TRUE, full.names=FALSE,pattern = "b)")
