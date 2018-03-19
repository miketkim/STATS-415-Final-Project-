library(tidyverse)


us_data = read.csv('USVideos.csv')
us_data <- us_data[!(us_data$video_error_or_removed == "True" || us_data$comments_disabled == TRUE),]


knitr::opts_chunk$set(echo = TRUE, fig.align = "center")
ggplot(us_data) + aes(x = reorder(us_data$category_id, as.numeric(-us_data$views), sum), y = us_data$views, label
                      = views, fill = factor(us_data$category_id)) + geom_bar(stat = "identity") + scale_x_discrete(name = "category id",
                                                                                                                    labels = scales::comma) + scale_y_continuous(name = "# of Views", labels = scales::comma) + labs(title = "Plot of 
                                                                                                                                                                                                                     video category vs number of views of US") + scale_fill_discrete(name = "Category ID")
