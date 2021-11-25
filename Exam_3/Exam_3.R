library(tidyverse)
library(janitor)
library(easystats)
library(broom)

df<- read.csv("FacultySalaries_1995.csv",stringsAsFactors=T)
df<- df %>% distinct()
 make_clean_names(colnames(df))
#figure 1- rotate labels/rename 

df <- df %>% 
  mutate(Full=AvgFullProfSalary,
          Assoc=AvgAssocProfSalary,
          Assist=AvgAssistProfSalary,
         Full2=AvgFullProfComp,
         Assoc2=AvgAssocProfComp,
         Assist2=AvgAssistProfComp)

df1<- df %>% 
  pivot_longer(cols = c("Full","Assoc","Assist"), 
names_to = "Rank", 
values_to = "Salary",
names_repair = "unique") %>% 
  pivot_longer(cols = c("Full2","Assoc2","Assist2"), names_to = "rank2", values_to = "Compensation")

df1<- df1[order(df1$Tier),]
df2=df1[-c(10441:10449),]

l<- df2 %>% 
  ggplot(aes(x=Rank,y=Salary, fill=Rank))+
  geom_boxplot()+
  facet_wrap(~Tier)+
  scale_color_manual(labels = c("Assist", "Assoc","Full"), values = c("red", "green","blue"))

l+ theme(axis.text.x = element_text(angle = 45, hjust = 1))


#2    double check how data was cleaned as well as export table

anova <- aov(data= df1,Salary~State+Rank+ Tier)
capture_a<- summary(anova)
capture.output(capture_a,file = "Salary_ANOVA_Summary.txt")

#3 done
df5 <- read.csv("Juniper_Oils.csv")
colnames(df5) <- make_clean_names(colnames(df5))
df6<- df5 %>% 
  mutate_if(is.numeric,as.character, is.factor, as.character) %>% 
  pivot_longer(data=df5, cols=c("alpha_pinene","para_cymene","alpha_terpineol","cedr_9_ene","alpha_cedrene","beta_cedrene","cis_thujopsene","alpha_himachalene","beta_chamigrene","cuparene","compound_1","alpha_chamigrene","widdrol","cedrol","beta_acorenol","alpha_acorenol","gamma_eudesmol","beta_eudesmol","alpha_eudesmol","cedr_8_en_13_ol","cedr_8_en_15_ol","compound_2","thujopsenal"),
             names_to = "Compounds", values_to = "Concentration")

df6 %>% 
  ggplot(aes(x=years_since_burn,y=Concentration))+
  geom_smooth(method = "loess")+
           facet_wrap(~Compounds,scales = "free")+
  labs(x="YearsSinceBurn",y="Concentration")
  
#4 somethings not right
mod1 <- glm(data = df6,
            formula = as.factor(Concentration)~Compounds*years_since_burn,
            family = "binomial")

summary(mod1)
tidy(mod1)


