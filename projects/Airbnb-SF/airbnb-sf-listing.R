

library("tidyverse") 
library(ggplot2)
library("ggthemes") 




library(factoextra)
library(cluster)
library(NbClust)


####
# Data from: http://insideairbnb.com/get-the-data.html
# File name: data.csv
setwd("/Users/chrisstroud/Documents/chrisstroud.github.io/projects/Airbnb-sf/")
df <- read.csv("data.csv")
####


### 
# Munge

# Selecting data for analysis
dfscore <- df %>% 
    select(neighbourhood_cleansed, 
         review_scores_accuracy, 
         review_scores_cleanliness, 
         review_scores_checkin, 
         review_scores_communication, 
         review_scores_location, 
         review_scores_value)  %>% 
     na.omit()

# Rename columns
names(dfscore) <- c("hood","accuracy","cleanliness", "checkin", "communication","location", "value") 

# Calculate average scores by neighborhood
dfscore <- dfscore %>%
  group_by(hood) %>%
  summarise(
    accuracy = mean(accuracy),
    cleanliness = mean(cleanliness),
    checkin = mean(checkin),
    communication = mean(communication),
    location = mean(location),
    value = mean(value)
  )

# Create row names
rownames(dfscore) <- dfscore$hood

# Remove hood column
dfscore$hood <- NULL
### 

###
# Is there clusters?




# How many clusters is optimal?

nb <- NbClust(dfscore, distance = "euclidean", min.nc = 2,
              max.nc = 10, method = "complete", index ="alllong")

png(file="number-clusters.png",width=1235,height=752)
p <- fviz_nbclust(nb) 
dev.off()




# Final Graph for optimal clusters
p + 
  theme_minimal() +
  scale_colour_solarized("red") +
  labs(
    title = "How many clusters should we use? ") 


# cluster analysis
# Map





















### 
# K-means clustering
set.seed(123)
km.res <- kmeans(dfscore, 2, nstart = 25)
print(km.res)

p.km.res <- fviz_cluster(km.res, 
             data = dfscore)




# PAM clustering
# Less sensitive to outliers
pam.res <- pam(dfscore, 2)
pam.res$cluster







fviz_cluster(pam.res, frame.type = "t")

# Visualize pam clusters (less subjsctive to outliers)
fviz_cluster(pam.res, stand = FALSE, geom = "point",
             frame.type = "norm")










p.pam <- fviz_cluster(pam.res, 
                      data = dfscore)
p + 
  theme_minimal() +
  geom_text(size=20) +
  labs(
    title = "What do the clusters look like? ") 












### 
# HIEARCHICAL CLUSTERING

# Model
dd <- dist(scale(dfscore), method = "euclidean")
hc <- hclust(dd, method = "ward.D2")




### DENOGRAM 


# vector of colors labelColors = c('red', 'blue', 'darkgreen', 'darkgrey',
# 'purple')
labelColors = c("#CDB380", "#036564", "#EB6841", "#EDC951")
# cut dendrogram in 4 clusters
clusMember = cutree(hc, 7)
# function to get color labels
colLab <- function(n) {
  if (is.leaf(n)) {
    a <- attributes(n)
    labCol <- labelColors[clusMember[which(names(clusMember) == a$label)]]
    attr(n, "nodePar") <- c(a$nodePar, lab.col = labCol)
  }
  n
}
# using dendrapply
clusDendro = dendrapply(hcd, colLab)
# make plot
par(mar=c(1,1,1,10)+.1)

plot(clusDendro,main = "Title", type = "triangle", horiz=TRUE) 


if(!require(devtools)) install.packages("devtools")
devtools::install_github("kassambara/factoextra")

pkgs <- c("cluster",  "NbClust")
install.packages(pkgs)

### 








