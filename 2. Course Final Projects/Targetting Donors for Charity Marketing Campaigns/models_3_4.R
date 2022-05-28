#ESTABLISH MYSQL CONNECTION
library(RMySQL)
library(DBI)
library(RODBC)
library(dplyr)
library(useful)
library(nnet)
library(glmnet)
library(xgboost)
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

query = "select * from ass3_model_train where action_year >= 2014"

table <- dbGetQuery(con,query)
table

table <- table[!is.na(table$yearly_amount),]
table

train_tune <- table[(table$action_year <= 2017),]
test <- table[(table$action_year = 2018),]

rows <- nrow(train_tune)
rand <- rbinom(rows, 1, .2)
rows
rand

train <- train_tune[rand == 0,]
tune <- train_tune[rand == 1,]

features = c("action_year","cluster","nb_sollicitations","nb_messages","action_month","action_week",
             "nb_actions","nb_donors","nb_responses","campaign_total_amount","nb_do","nb_pa",
            "yearly_amount","yearly_donations","yearly_responses","donor_total_amount","avg_total_count",
            "responsiveness","frequency","length","avg_amount","is_mr","is_mme","is_mlle","is_paris")
cat_features = c("cluster","is_mr","is_mme","is_mlle","is_paris")


# Donation Model
X_train_prob <- as.matrix(train[,features])
y_train_prob <- as.matrix(train[,c("did_donate")])
X_tune_prob <- as.matrix(tune[,features])
y_tune_prob <- as.matrix(tune[,c("did_donate")])

dtrain_prob <- xgb.DMatrix(data=X_train_prob, label=y_train_prob)
dtune_prob <- xgb.DMatrix(data=X_tune_prob, label=y_tune_prob)

watchlist_prob <- list(train=dtrain_prob, tune=dtune_prob)
bst_prob <- xgb.train(data=dtrain_prob, booster="gblinear", nrounds=1000, watchlist=watchlist_prob, objective="binary:logistic")

tune_prob_pred = predict(bst_prob, dtune_prob)
tune_prob_pred


# Amount model
train_amt <- train[!is.na(train$amount),]
tune_amt <- tune[!is.na(tune$amount),]

X_train_amt <- as.matrix(train_amt[,features])
y_train_amt <- as.matrix(train_amt[,c("amount")])
X_tune_amt <- as.matrix(tune_amt[,features])
y_tune_amt <- as.matrix(tune_amt[,c("amount")])

dtrain_amt <- xgb.DMatrix(data=X_train_amt, label=y_train_amt)
dtune_amt <- xgb.DMatrix(data=X_tune_amt, label=y_tune_amt)

watchlist_amt <- list(train=dtrain_amt, tune=dtune_amt)
bst_amt <- xgb.train(data=dtrain_amt, booster="gblinear", nrounds=1000, watchlist=watchlist_prob, objective="reg:squarederror")

tune_amt_pred <- predict(bst_amt,dtune_amt)
tune_amt_pred

tune_amt_pred_all <- predict(bst_amt, dtune_prob)
tune_amt_pred_all

# Compute expectancy
tune$did_donate_pred = tune_prob_pred
tune$amount_pred = tune_amt_pred_all
tune$expectancy_pred = tune_prob_pred * tune_amt_pred_all

tune$donator_pred = (tune$expectancy_pred > 0.85)
sum(tune$donator_pred)


# Make predictions on 2019 data
query_pred = "select * from ass3_model_pred"
pred_table <- dbGetQuery(con,query_pred)
pred_table

X_pred = as.matrix(pred_table[,features])

prob_pred = predict(bst_prob,X_pred)
amt_pred = predict(bst_amt,X_pred)

pred_table$prob_pred = prob_pred
pred_table$amt_pred = amt_pred
pred_table$expectancy_pred = prob_pred*amt_pred


out = data.frame(contact_id=pred_table$contact_id,campaign_id=pred_table$campaign_id,
                 will_donate_pred=pred_table$prob_pred,amount_pred=pred_table$amt_pred,
                 expectancy_pred=pred_table$expectancy_pred)
write.csv(out,"/Users/edouardvilain/Desktop/3A - DSBA/Marketing Analytics/Assignments/Assignment 3/final_preds_3_4.csv", row.names=FALSE)






