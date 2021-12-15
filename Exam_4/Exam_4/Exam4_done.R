library(tidyverse)
library(patchwork)
library(GGally)
options(scipen=999)


# YOUR TASKS:

**I.**
  **Read the cleaned_covid_data.csv file into an R data frame. (20 pts)**
  
  df <- read_csv("cleaned_covid_data.csv")

**II.**
  **Subset the data set to just show states that begin with "A" and save this as an object called A-states. (20 pts)**
  
  
  
  A_states <- df[grepl("^A",df$Province_State),]



+ Use the *tidyverse* suite of packages
+ Selecting rows where the state starts with "A" is tricky (you can use the grepl() function or just a vector of those states if you prefer)


**III.**
  **Create a plot _of that subset_ showing Active cases over time, with a separate facet for each state. (20 pts)**
  
  
  
  
  A_states %>% 
  ggplot(aes(x=Last_Update, y=Active)) +
  geom_point()+
  facet_wrap(~Province_State, scales = "free")+
  geom_smooth(se=FALSE)+
  labs(x="Time", y="Active Cases",title="Active Cases in States that start with A")




+ Create a scatterplot
+ Add loess curves WITHOUT standard error shading
+ Keep scales "free" in each facet

**IV.** (Back to the full dataset)
**Find the "peak" of Case_Fatality_Ratio for each state and save this as a new data frame object called state_max_fatality_rate. (20 pts)**
  
  I'm looking for a new data frame with 2 columns:

 + "Province_State"
 + "Maximum_Fatality_Ratio"
 + Arrange the new data frame in descending order by Maximum_Fatality_Ratio
This might take a few steps. Be careful about how you deal with missing values!'




state_max_fatality_rate<- df %>% 
  group_by(Province_State) %>% 
  summarise(Max_Fatality = max(Case_Fatality_Ratio,na.rm =TRUE)) %>% 
  arrange(desc(Max_Fatality))


**V.**
  **Use that new data frame from task IV to create another plot. (20 pts)**
  
  
  
  state_max_fatality_rate %>% 
  ggplot(aes(x=reorder(Province_State,-Max_Fatality), y=Max_Fatality))+
  geom_col()+
  theme(axis.text.x = element_text(angle = 90,hjust =1))



+ X-axis is Region
+ Y-axis is Maximum_Fatality_Ratio
+ bar plot
+ x-axis arranged in descending order, just like the data frame (make it a factor to accomplish this)
+ X-axis labels turned to 90 deg to be readable

Even with this partial data set (not current), you should be able to see that (within these dates), different states had very different fatality ratios.



