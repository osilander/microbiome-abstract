library(fulltext)
topic <- "microbiome"
journal <- "plos"
limit <- 499
res1 <- ft_search(query = topic, from = journal, limit=limit)
x <- ft_get(res1)
xa <- chunks(x, what="abstract")
cat(unlist(tabularize(xa)), file=paste("~/Documents/Misc/scholar/",topic,"_",journal,"_", limit, ".txt",sep=""))