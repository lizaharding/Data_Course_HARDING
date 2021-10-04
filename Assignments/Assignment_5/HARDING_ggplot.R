library(tidyverse)

data(iris)
iris %>% 
  ggplot(aes(x=Sepal.Length, y=Petal.Length, color=Species))+
  geom_point()+
  geom_smooth(method="lm")+
  labs(title="Sepal Length vs Petal Length", subtitle = "For three Iris Species")


iris %>% 
  ggplot( aes(x=Petal.Width, fill = Species)) + geom_density(alpha = .5) + labs(title = "Distrubution of Petal Widths", subtitle = "For three Iris Species")

ya <- iris$Petal.Width/iris$Sepal.Width


iris %>% 
  ggplot(aes(x=Species, y=ya, color=Species, fill=Species))+
  geom_boxplot()+
  geom_smooth(method="lm")+
  labs(title="Sepal to Petal width ratio", subtitle = "For three Iris Species", y="Ratio of Sepal Width to Petal Width")
`Deviance from Mean` <- iris$Sepal.Length- mean(iris$Sepal.Length)
`Deviance from Mean`

so sorry professor but that y axix is really giving me troubles so its not correct


ba<- order(`Deviance from Mean`)
baa<- ba[order(ba)]
iris %>%
  ggplot(aes(x=baa,y=`Deviance from Mean`)) + 
  geom_bar(stat='identity', aes(fill=Species), width=.5)  +
  labs(title= "Sepal Length Deviance from the mean of all Observations") +
  coord_flip()
