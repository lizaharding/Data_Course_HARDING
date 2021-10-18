library(tidyverse)
library(janitor)



#making figure 1
df<- read.csv("~/Desktop/Data_Course/Data/landdata-states.csv")
options(scipen = 999)
df %>% 
  ggplot(aes(x=Year, y=Land.Value,color=region, scipen = 999))+
  geom_smooth()



#the NA region represents Washington DC and this code shows that
ya<- df[!complete.cases(df),]
ya
c(ya$State)

#tiding unicef data
df<- read.csv("~/Desktop/Data_Course_HARDING/Exam_2/unicef-u5mr.csv")
df
df1<- df %>% 
  pivot_longer(cols = starts_with("U5MR."),
                 names_to = "Year",
               values_to= "MortalityRate",
               names_prefix="U5MR",
               values_drop_na = TRUE)

#making figure 2
df1 %>% 
  ggplot(aes(x=Year, y=MortalityRate, color=Continent))+
  geom_point()
  
p + coord_cartesian(xlim =c(df1$Year - 30, NA), ylim = c(10, 20))
  
#making figure 3
df2<- df1 %>% 
  group_by(Year,Continent) %>% 
  summarise(Yearly_Mortality=(mean(MortalityRate)))

df2$year <- as.numeric(as.character(df2$Year))

df2 %>% 
  ggplot(aes(x=Year,y=Yearly_Mortality,color=Continent))+
  geom_line(group=df2$Continent)+
  labs(y="Mean Mortality Rate (Deaths per 1000 live births")


#making figure 4
 df1 %>% 
  ggplot(aes(x=Year, y=MortalityRate))+
  geom_point(colour="blue")+
  facet_wrap(~Region)











