library(tidyverse)
library(GGally)
library(rjson)
library(jsonlite)

us_data = read.csv('USVideos.csv')
us_data <- us_data[!(us_data$video_error_or_removed == "True" || us_data$comments_disabled == TRUE),]


knitr::opts_chunk$set(echo = TRUE, fig.align = "center")
ggplot(us_data) + aes(x = reorder(us_data$category_id, as.numeric(-us_data$views), sum), y = us_data$views, label= views, fill = factor(us_data$category_id)) + geom_bar(stat = "identity") + scale_x_discrete(name = "category id",
                                                                                                                    labels = scales::comma) + scale_y_continuous(name = "# of Views") + labs(title = "Plot of video category vs number of views of US") + scale_fill_discrete(name = "Category ID")
cleaned_data = subset(us_data, select = c('trending_date', 'title', 'channel_title', 'category_id', 'publish_time', 'tags', 'views', 'likes', 'dislikes', 'comment_count'))

ggcorr(cleaned_data, palette = "RdBu", label = TRUE)
cleaned_data %>% group_by(category_id) %>% summarise(sum(as.numeric(views)))

knitr::opts_chunk$set(echo = TRUE)
us_cat_json <- fromJSON("US_category_id.json")
US_category <-  as.data.frame(cbind(us_cat_json[["items"]][["id"]], us_cat_json[["items"]][["snippet"]][["title"]]))
names(US_category) <- c("category_id","category_title")
cleaned_data <- merge(x = cleaned_data, y = US_category, by = "category_id", all = "TRUE")

ggplot(cleaned_data) + aes(x = reorder(cleaned_data$category_id, as.numeric(-cleaned_data$views), sum), y = cleaned_data$views, label= views, fill = factor(cleaned_data$category_title)) + geom_bar(stat = "identity") + scale_x_discrete(name = "category title",
                                                                                                                                                                                                                                        labels = scales::comma) + scale_y_continuous(name = "# of Views") + labs(title = "Plot of video category vs number of views of US") + scale_fill_discrete(name = "Category ID")
                                                                                                                                                                                                               
