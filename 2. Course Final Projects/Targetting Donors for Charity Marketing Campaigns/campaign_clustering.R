#ESTABLISH MYSQL CONNECTION
library(RMySQL)
library(DBI)
library(RODBC)
library(dplyr)
library(useful)
# Connect to the MySQL database: con
con <- dbConnect(RMySQL::MySQL(), 
                 dbname = "ma_charity_full", 
                 host = "127.0.0.1", 
                 port = 3306,
                 user = "root",
                 password = "Melbourne09")

#IMPORT TABLES
tables <- dbListTables(con)
# Display structure of tables
str(tables)
tables <- lapply(tables , dbReadTable, conn = con)

# Write cluster table query
query = "select * from campaign_cluster"

# Get table
table <- dbGetQuery(con,query)
head(table)

# Get column names
names(table)
summary(table)


# Scale columns
table$nb_sollicitations = scale(table$nb_sollicitations)
table$nb_messages = scale(table$nb_messages)
table$action_month = scale(table$action_month)
table$action_week = scale(table$action_week)
table$nb_actions = scale(table$nb_actions)
table$nb_donors = scale(table$nb_donors)
table$nb_responses = scale(table$nb_responses)
table$total_amount = scale(table$total_amount)
table$nb_do = scale(table$nb_do)
table$nb_pa = scale(table$nb_pa)

head(table)

table_train = table[, which(names(table) != "campaign_id")]
head(table_train)

# Set random seed
set.seed(1234)

# Compute number of correct clusters
campaigns_cluster <- FitKMeans(table_train, max.clusters=10, nstart=25)
campaigns_cluster

# Correct number of clusters is 8 
campaignsK9N25 <- kmeans(table_train, centers=8, nstart=25)
plot(campaignsK9N25, data=table_train)

# Adding cluster column to initial table
table$cluster = campaignsK9N25$cluster
table

out = table[,c("campaign_id","cluster")]
write.csv(out,"/Users/edouardvilain/Desktop/3A - DSBA/Marketing Analytics/Assignments/Assignment 3/campaign_clusters.csv", row.names=FALSE)
