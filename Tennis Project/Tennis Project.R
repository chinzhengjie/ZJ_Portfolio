#install.packages("readr")
#install.packages("tidyverse")
#install.packages("ggplot2")
#install.packages("lubridate")
#install.packages("gridExtra")
#install.packages("reshape")

library(readr)
library(dplyr)
library(tidyverse)
library(ggplot2)
library(lubridate)
library(scales)
library(reshape)
library(grid)
library(gridExtra)
require(gridExtra)

match_df <- read_csv("C:/Users/USER/Documents/Data Analytics/Tennis Project/Data/Match.csv")
player_df <- read_csv("C:/Users/USER/Documents/Data Analytics/Tennis Project/Data/Player.csv")
stats_df <- read_csv("C:/Users/USER/Documents/Data Analytics/Tennis Project/Data/Stats.csv")

clean_df <- merge(stats_df, match_df, by=c("match_id"))
clean_df <- merge(clean_df, player_df, by=c("player_id"))

clean_df <- clean_df %>%
		  select(-player_id,-hand,-country,-birthday,-pts) %>%
		  mutate(aces_per_first_serve_in=round((aces/first_serve_in), 2),
			  num_of_sets=ifelse(!is.na(clean_df$"5"), 5,
		    			  ifelse(!is.na(clean_df$"4"), 4,
		    			  ifelse(!is.na(clean_df$"3"), 3,
		    			  ifelse(!is.na(clean_df$"2"), 2,
		    			  ifelse(!is.na(clean_df$"1"), 1, 0))))))

big3_stats2 <- clean_df[clean_df$name == "Roger Federer" | clean_df$name == "Novak Djokovic" | clean_df$name == "Rafael Nadal", ]

# 1. Rank Top 10 Match Wins againt Rank Top 10
winners <- clean_df[clean_df$rank <= 10 & clean_df$rank >= 1 & clean_df$winner == TRUE,] %>% 
  select(c("match_id","name"))
losers <- clean_df[clean_df$rank <= 10 & clean_df$rank >= 1 & clean_df$winner == FALSE,] %>% 
  select(c("match_id","name"))

top10_rank_winners_sum <- merge(winners, losers[, c("match_id", "name")], by="match_id") %>% 
  select(-name.y,-match_id) %>% 
  dplyr::rename(name=name.x) %>% 
  group_by(name) %>%
  tally()


top10_rank_winners_sum %>% 
  ggplot(aes(x = reorder(name, n), y = n, fill=name)) + 
  geom_bar(stat="identity",color="black",width=0.7) +
  geom_text(aes(label=n), position = position_dodge(),hjust = -0.5, size = 2.75) +
  labs(title="Wins Against Rank Top 10 Players",subtitle="in Grandslams (2000-2019)") +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 65)) +
  scale_fill_manual(values = rep(c("skyblue2","palegreen3","skyblue2","palegreen3","skyblue2","palegreen3","skyblue2"),times=c(21,1,2,1,2,1,5))) +
  guides(x = "none") +
  theme(plot.title = element_text(vjust=5,hjust = 0.35,size=15),
  plot.subtitle = element_text(vjust=6,hjust = 0.4,size=10),
  plot.margin = unit(c(1,0,1,1),"cm"),
  axis.line = element_line(),
  axis.ticks.x=element_blank(),
  axis.text.x=element_blank(),
  axis.title.x=element_blank(),
  axis.title.y=element_blank(),
  axis.text.y=element_text(color="black"),
  legend.position = "none",
  panel.background = element_blank()) +
  coord_flip()

  #ggsave(filename="Rank Top 10 Match Wins againt Rank Top 10.png",width=12,height=8)
  

# 2a. Big 3 Win Rate against Top 10 Rank Players

top10_rank_losers_sum <- merge(losers, winners[, c("match_id", "name")], by="match_id") %>% 
  select(-name.y,-match_id) %>% 
  dplyr::rename(name=name.x) %>% 
  group_by(name) %>%
  tally()

big3_stats1 <- merge(top10_rank_winners_sum, top10_rank_losers_sum, by="name") %>%
  dplyr::rename(wins=n.x,losses=n.y) %>%
  mutate(win_per=(wins/(wins+losses))) %>%
  filter(name=="Roger Federer" | name=="Rafael Nadal" | name=="Novak Djokovic",)

top10_win_rate_p <- big3_stats1 %>%
  mutate(win_per=round(win_per*100,1)) %>%
  ggplot(aes(x=name, y = win_per)) +
  geom_segment(aes(xend=name, yend=0), size = 0.5) +
  geom_point(size=22, color="black", fill = "deepskyblue", shape = 21, stroke=1) +
  geom_text(aes(label=sprintf("%.1f", round(win_per, digits = 1))), position = position_stack(vjust = 1.0), size = 5) +
  labs(title="The Big 3 vs Rank Top 10 Players",subtitle="in Grandslams (2000-2019)", y="Win Percentage") +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 90)) +
  guides(y = "none") +
  theme(plot.title = element_text(vjust=5,hjust = 0.53,size=15),
  plot.subtitle = element_text(vjust=6,hjust = 0.5,size=10),
  plot.margin = unit(c(1,1,0,1),"cm"),
  axis.ticks.x=element_blank(),
  axis.title.x=element_blank(),
  axis.text.x=element_blank(),
  axis.title.y = element_text(vjust=6, size=11),
  axis.line = element_line(),
  panel.grid.major.y = element_line(color="grey", size=0.25),
  panel.background = element_blank())

# 2b. Big 3 Win/Loss against Top 10 Rank Players
top10_win_loss_p <- big3_stats1 %>%
  melt() %>% 
  filter(variable!="win_per") %>%
  ggplot(aes(x=name, y = value, fill = variable)) +
  geom_bar(stat="identity", position="dodge", color="black",width=0.6) +
  labs(y="Matches") +
  scale_fill_manual(labels = c("Wins", "Losses"),values =c("palegreen2","coral1")) +
  theme(axis.ticks.x=element_blank(),
  axis.title.x=element_blank(),
  axis.text.x=element_text(color="black"),
  axis.ticks.y=element_blank(),
  axis.title.y = element_text(vjust=6, size=11),
  axis.text.y=element_text(color="black"),
  legend.title = element_blank(),
  legend.position=c(0.96,0.9),
  legend.key.size = unit(0.4, 'cm'),
  plot.margin = unit(c(1,1,1,1),"cm"),
  panel.grid.major.y = element_line(color="grey", size=0.25),
  panel.grid.minor.y = element_line(color="grey", size=0.25),
  panel.background = element_blank())

# 2c. Big 3 against Top 10 Rank Players
grid.arrange(top10_win_rate_p,top10_win_loss_p,nrow=2)

  #g <- arrangeGrob(top10_win_rate_p,top10_win_loss_p,nrow=2)
  #ggsave(file="Big 3 vs Top 10 Rank Players.png", g)


# 3. Big 3 Average Match Duration
big3_stats2 %>% 
  group_by(name, tournament) %>% 
  summarise(avrg_match_mins = mean(match_minutes)) %>%
  arrange(name, tournament) %>%
  ggplot(aes(x = name, y = avrg_match_mins, fill = tournament)) + 
  geom_col(position = position_dodge(0.7),width=0.6, color="black") +
  labs(title="Average Match Duration (Minutes)",subtitle="by Grandslam (2000-2019)") +
  scale_y_continuous(limits = c(0, 180), breaks=c(0,60,120,180)) +
  scale_fill_manual(values = c("skyblue2", "darkorange", "dodgerblue4", "palegreen3")) +
  guides(fill=guide_legend(title="Tournament")) +
  coord_flip() +
  theme(axis.title.x=element_blank(),
  axis.ticks.x=element_blank(),
  axis.text.x=element_text(color="black"),
  axis.title.y=element_blank(),
  axis.text.y=element_text(size=13,color="black"),
  axis.ticks.y=element_blank(),
  legend.key.size = unit(0.5, 'cm'),
  legend.title = element_blank(),
  plot.title = element_text(vjust=7,hjust = 0.5,size=15),
  plot.subtitle = element_text(vjust=9,hjust = 0.5,size=10),
  plot.margin = unit(c(1,1,1,1),"cm"),
  panel.grid.major.x = element_line(color="grey", size=0.25),
  panel.grid.minor.x = element_line(color="grey", size=0.25),
  panel.background = element_blank())

  #ggsave(filename="Big 3 Average Match Duration.png",width=12,height=8)

# 4a. Big 3 Win Rate on 3, 4 and 5 set matches 
sets_stats1 <- big3_stats2 %>%
  group_by(name, num_of_sets, winner) %>%
  tally() %>%
  dplyr::rename(wins=n) %>% 
  filter(winner==TRUE) %>%
  select(-winner)
  
sets_stats2 <- big3_stats2 %>%
  group_by(name, num_of_sets) %>%
  tally() %>%
  dplyr::rename(total=n)

set_win_rate_p <- merge(sets_stats1, sets_stats2, by=c("name","num_of_sets")) %>%
  mutate(win_rate=round((wins/total)*100,1)) %>%
  filter(num_of_sets==3 | num_of_sets==4 | num_of_sets==5) %>%
  ggplot(aes(x = num_of_sets, y=win_rate)) + 
  geom_segment(aes(xend=num_of_sets, yend=0), size = 0.5) +
  geom_point(size=16, color="black", fill = "deepskyblue", shape = 21, stroke=1) +
  geom_text(aes(label=sprintf("%.1f", round(win_rate, digits = 1))), position = position_stack(vjust = 1.0), size = 4) +
  labs(title="The Big 3 in 3, 4 and 5 Set Matches",subtitle="in Grandslams (2000-2019)", y="Win Percentage") +
  guides(y="none") +
  scale_x_continuous(limits = c(2.5, 5.5), breaks=c(3,4,5)) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 115)) +
  facet_wrap(~name) +
  theme(plot.title = element_text(vjust=5,hjust = 0.5,size=15),
  plot.subtitle = element_text(vjust=7,hjust = 0.5,size=10),
  plot.margin = unit(c(1,1,0,1.7),"cm"),
  panel.background = element_blank(),
  panel.grid.major.y = element_line(color="grey", size=0.25),
  strip.background = element_blank(),
  strip.text.x = element_blank(),
  axis.line = element_line(),
  axis.ticks.x=element_blank(),
  axis.title.x=element_blank(),
  axis.text.x=element_text(color="black"),
  axis.ticks.y=element_blank(),
  axis.title.y = element_text(vjust=15, size=11))

# 4b. Big 3 Win/Loss in 3, 4 and 5 set matches
set_win_loss_p <- big3_stats2 %>% 
  filter(num_of_sets==3 | num_of_sets==4 | num_of_sets==5) %>%
  ggplot() + 
  geom_bar(mapping = aes(x = num_of_sets, fill = winner), position = "dodge",width=0.6,color="black") +
  labs(x="Number Of Sets", y="Matches") +
  scale_x_continuous(limits = c(2.5, 5.5), breaks=c(3,4,5)) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 280), breaks=c(0,50,100,150,200,250)) +
  scale_fill_manual(labels = c("Losses", "Wins"),values =c("coral1","palegreen2")) +
  facet_wrap(~name) +
  theme(legend.title = element_blank(),
  legend.position=c(0.96,0.83),
  legend.key.size = unit(0.4, 'cm'),
  plot.margin = unit(c(0.5,1,1,1),"cm"),
  panel.grid.major.y = element_line(color="grey", size=0.25),
  panel.grid.minor.y = element_line(color="grey", size=0.25),
  panel.background = element_blank(),
  strip.background =element_rect(fill="white"),
  axis.title.x = element_text(vjust=-3, size=10),
  axis.ticks.x=element_blank(),
  axis.text.x=element_text(color="black"),
  axis.ticks.y=element_blank(),
  axis.title.y = element_text(vjust=6, size=11))

# 4c. 3, 4 and 5 set stats
grid.arrange(set_win_rate_p,set_win_loss_p,nrow=2)

  #g <- arrangeGrob(set_win_rate_p,set_win_loss_p,nrow=2)
  #ggsave(file="Big 3 Win-Loss in 3, 4 and 5 set matches.png", g)


  # 5. Big 3 Average Aces for every 10 First Serves In     (Not Useful, same as #7)
big3_stats2 %>% 
  group_by(name,tournament) %>%
  summarise(avrg_aces_per_first_serve_in=mean(aces_per_first_serve_in)*10) %>%
  ggplot(aes(x = name, y = avrg_aces_per_first_serve_in, fill = tournament)) + 
  geom_col(position = position_dodge(0.8),width=0.7,color="black") +
  labs(title="Average Aces for every 10 First Serves In by Tournament", y="Aces") +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 2.1)) +
  scale_fill_manual(values = c("skyblue2", "darkorange", "dodgerblue4", "palegreen3")) +
  guides(fill=guide_legend(title="Tournament")) +
  theme(plot.title = element_text(vjust=5,hjust = 0.5),
  plot.margin = unit(c(1,1,1,1),"cm"),
  axis.title.x=element_blank(),
  axis.ticks.x=element_blank(),
  axis.text.x=element_text(color="black"),
  axis.text.y=element_text(color="black"),
  axis.ticks.y=element_blank(),
  axis.title.y = element_text(vjust=4, size=11),
  legend.key.size = unit(0.5, 'cm'),
  panel.grid.major.y = element_line(color="grey", size=0.25),
  panel.background = element_blank())


# 6. Big 3 First Serve % per Tournament
big3_stats2 %>% 
  group_by(name,tournament) %>%
  summarise(avrg_first_serve_per=mean(first_serve_per)) %>%
  ggplot(aes(x = name, y = avrg_first_serve_per, fill = tournament)) + 
  geom_col(position = position_dodge(0.7),width=0.6,color="black") +  
  labs(title="Average First Serve Percentage", subtitle="by Grandslam (2000-2019)") +
  scale_y_continuous(labels = scales::percent,expand = c(0, 0), limits = c(0, 1), breaks=c(0.5,0.55,0.6,0.65,0.7,0.75)) +
  scale_fill_manual(values = c("skyblue2", "darkorange", "dodgerblue4", "palegreen3")) +
  coord_cartesian(ylim=c(0.5,0.75)) +
  guides(fill=guide_legend(title="Tournament")) +
  theme(panel.grid.major.y = element_line(color="grey", size=0.25),
  panel.grid.minor.y = element_line(color="grey", size=0.25),
  panel.background = element_blank(),
  plot.margin = unit(c(1,1,1,1),"cm"),
  plot.title = element_text(vjust=6,hjust = 0.5,size=15),
  plot.subtitle = element_text(vjust=7,hjust = 0.5,size=10),
  legend.key.size = unit(0.5, 'cm'),
  legend.title = element_blank(),
  axis.title.x=element_blank(),
  axis.ticks.x=element_blank(),
  axis.text.x=element_text(color="black"),
  axis.text.y=element_text(color="black"),
  axis.ticks.y=element_blank(),
  axis.title.y=element_blank())

  #ggsave("Big 3 First Serve Percentage.png")


# 7. Big 3 Aces per Tournament
big3_stats2 %>% 
  group_by(name, tournament) %>% 
  summarise(avrg_aces=mean(aces)) %>% 
  ggplot(aes(x = name, y = avrg_aces, fill = tournament)) + 
  geom_col(position = position_dodge(0.7),width=0.6,color="black") +
  labs(title="Average Aces",subtitle="by Grandslam (2000-2019)") +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 15)) +
  scale_fill_manual(values = c("skyblue2", "darkorange", "dodgerblue4", "palegreen3")) +
  guides(fill=guide_legend(title="Tournament")) +
  theme(plot.title = element_text(vjust=7,hjust = 0.5,size=15),
  plot.subtitle = element_text(vjust=8,hjust = 0.5,size=10),
  plot.margin = unit(c(1,1,1,1),"cm"),
  axis.title.x=element_blank(),
  axis.ticks.x=element_blank(),
  axis.text.x=element_text(color="black"),
  axis.text.y=element_text(color="black"),
  axis.ticks.y=element_blank(),
  axis.title.y = element_blank(),
  legend.key.size = unit(0.5, 'cm'),
  legend.title = element_blank(),
  panel.grid.major.y = element_line(color="grey", size=0.25),
  panel.grid.minor.y = element_line(color="grey", size=0.25),
  panel.background = element_blank())

  #ggsave("Big 3 Average Aces.png")


# 8a. Big 3 Break Points Saved Percentage
bp_stats <- clean_df %>% 
  mutate(name = ifelse(name=="Roger Federer", "Roger Federer",
		    ifelse(name=="Rafael Nadal", "Rafael Nadal",
		    ifelse(name=="Novak Djokovic", "Novak Djokovic", "Others")))) %>%
  select(name,bp_saved,bp_faced)

bp_saved_perc_p <- bp_stats %>%
  aggregate(by=list(bp_stats$name),FUN=mean,na.rm=TRUE) %>%
  mutate(bp_saved_perc=round((bp_saved/bp_faced)*100,1)) %>%
  select(-name) %>% 
  rename_with(.cols = 1, ~"name") %>% 
  ggplot(aes(x=name,y=bp_saved_perc)) +
  geom_segment(aes(xend=name, yend=0), size = 0.5) +
  geom_point(size=20, color="black", fill = "deepskyblue", shape = 21, stroke=1) +
  geom_text(aes(label=sprintf("%.1f", round(bp_saved_perc, digits = 1))), position = position_stack(vjust = 1.0), size = 4.5) +
  labs(title="The Big 3 in Break Points",subtitle="in Grandslams (2000-2019)", y="Break Points Saved/Faced Percentage") +
  guides(y="none") +
  scale_x_discrete(limits = c("Others","Novak Djokovic", "Rafael Nadal", "Roger Federer")) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 80)) +
  theme(plot.title = element_text(vjust=7,hjust = 0.5,size=15),
  plot.subtitle = element_text(vjust=8,hjust = 0.5,size=10),
  plot.margin = unit(c(1,1,0,1.8),"cm"),
  panel.background = element_blank(),
  panel.grid.major.y = element_line(color="grey", size=0.25),
  axis.line = element_line(),
  axis.ticks.x=element_blank(),
  axis.title.x=element_blank(),
  axis.text.x=element_blank(),
  axis.text.y=element_text(color="black"),
  axis.ticks.y=element_blank(),
  axis.title.y = element_text(vjust=21, size=9))

# 8b. Big 3 Break Points Saved and Faced
bp_saved_faced_p <- bp_stats %>%
  aggregate(by=list(bp_stats$name),FUN=mean,na.rm=TRUE) %>% 
  select(-name) %>% 
  rename_with(.cols = 1, ~"name") %>% 
  melt() %>% 
  ggplot(aes(x=name,y=value,fill=variable)) +
  geom_col(position = "dodge",width=0.6, color="black") +
  labs(y="Average Break Points Saved/Faced") +
  scale_x_discrete(limits = c("Others","Novak Djokovic", "Rafael Nadal", "Roger Federer")) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 10), breaks=c(0,2,4,6,8,10)) +
  scale_fill_manual(labels = c("Break Points Saved", "Break Points Faced"),values =c("palegreen2","coral1")) +
  theme(legend.title = element_blank(),
  legend.position=c(0.92,0.95),
  legend.key.size = unit(0.4, 'cm'),
  plot.margin = unit(c(1,1,1,1),"cm"),
  panel.grid.major.y = element_line(color="grey", size=0.25),
  panel.background = element_blank(),
  axis.ticks.x=element_blank(),
  axis.title.x=element_blank(),
  axis.text.x=element_text(color="black"),
  axis.ticks.y=element_blank(),
  axis.text.y=element_text(color="black"),
  axis.title.y = element_text(vjust=6, size=9,color="black"))


# 8c. Big 3 Break Point Stats
grid.arrange(bp_saved_perc_p, bp_saved_faced_p,nrow=2)

  #g <- arrangeGrob(bp_saved_perc_p, bp_saved_faced_p,nrow=2)
  #ggsave(file="Big 3 Break Point Stats.png", g)

  
# 9. Big 3 on Return of Serve
serve_stats <- clean_df %>% 
  mutate(name = ifelse(name=="Roger Federer", "Roger Federer",
		    ifelse(name=="Rafael Nadal", "Rafael Nadal",
		    ifelse(name=="Novak Djokovic", "Novak Djokovic", "Others")))) %>%
  select(name,first_serve_rtn_won,second_serve_rtn_won)

serve_stats %>%
  aggregate(by=list(serve_stats$name),FUN=mean,na.rm=TRUE) %>% 
  select(-name) %>% 
  rename_with(.cols = 1, ~"name") %>% 
  melt() %>% 
  ggplot(aes(x=name,y=value,fill=variable)) +
  geom_col(position = "dodge",width=0.5,color="black") +
  labs(title="The Big 3's Average Wins on Return of Serve",subtitle="in Grandslams (2000-2019)") +
  scale_x_discrete(limits = c("Others","Novak Djokovic", "Rafael Nadal", "Roger Federer")) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 30),breaks=c(15,17,19,21,23,25)) +
  scale_fill_manual(labels = c("First Serve Returns Won", "Second Serve Returns Won"),values =c("palegreen2","skyblue")) +
  coord_cartesian(ylim=c(15,25)) +
  theme(axis.ticks.x=element_blank(),
  axis.title.x=element_blank(),
  axis.text.x=element_text(color="black"),
  axis.text.y=element_text(color="black"),
  axis.ticks.y=element_blank(),
  axis.title.y = element_blank(),
  legend.title = element_blank(),
  legend.key.size = unit(0.4, 'cm'),
  plot.margin = unit(c(1,1,1,1),"cm"),
  plot.title = element_text(vjust=7,hjust = 0.5,size=15),
  plot.subtitle = element_text(vjust=8,hjust = 0.5,size=10),
  panel.grid.major.y = element_line(color="grey", size=0.25),
  panel.grid.minor.y = element_line(color="grey", size=0.25),
  panel.background = element_blank())

  #ggsave(filename="Big 3 on Return of Serve.png",width=10,height=8)


# 10. Time in Top 3
ranking = big3_stats2[order(big3_stats2[,'year'],-big3_stats2[,'rank']),]
ranking = ranking[!duplicated(ranking[,c('name','year')]),]

fed_rank <- ranking %>%
  filter(name=="Roger Federer") %>%
  select(name, rank, year) %>% 
  arrange(year) %>% 
  ggplot(aes(x=year, y=rank, group=1)) + 
  geom_line(color = "palegreen3",size=1.2) + 
  geom_point(color = "black",fill="palegreen3",size=8,shape=21) +
  geom_text(aes(label=rank), position = position_identity(), size = 3) +
  labs(title="The Big 3's World Ranking",subtitle="(2000-2019)") +
  scale_x_continuous(limits=c(2000,2020),breaks = c(2000,2005,2010,2015,2020)) +
  scale_y_reverse(limits=c(100,-10)) +
  guides(y="none") +
  theme(panel.grid.major.x = element_line(color="grey", size=0.25),
  panel.background = element_blank(),
  plot.title = element_text(vjust=7,hjust = 0.5,size=15),
  plot.subtitle = element_text(vjust=8,hjust = 0.5,size=10),
  plot.margin = unit(c(1,1,0,1),"cm"),
  axis.line = element_line(),
  axis.ticks.x=element_blank(),
  axis.title.x = element_blank(),
  axis.text.x=element_text(color="black"),
  axis.text.y=element_blank(),
  axis.ticks.y=element_blank(),
  axis.title.y = element_blank())

nad_rank <- ranking %>%
  filter(name=="Rafael Nadal") %>%
  select(name, rank, year) %>% 
  arrange(year) %>% 
  ggplot(aes(x=year, y=rank, group=1)) + 
  geom_line(color = "darkorange",size=1.2) + 
  geom_point(color = "black",fill="darkorange",size=8,shape=21) +
  geom_text(aes(label=rank), position = position_identity(), size = 3) +
  scale_x_continuous(limits=c(2000,2020),breaks = c(2000,2005,2010,2015,2020)) +
  scale_y_reverse(limits=c(100,-10)) +
  guides(y="none") +
  theme(panel.grid.major.x = element_line(color="grey", size=0.25),
  panel.background = element_blank(),
  plot.margin = unit(c(0.5,1,0.5,1),"cm"),
  axis.line = element_line(),
  axis.ticks.x=element_blank(),
  axis.title.x = element_blank(),
  axis.text.x=element_text(color="black"),
  axis.text.y=element_blank(),
  axis.ticks.y=element_blank(),
  axis.title.y = element_blank())

djo_rank <- ranking %>%
  filter(name=="Novak Djokovic") %>%
  select(name, rank, year) %>% 
  arrange(year) %>% 
  ggplot(aes(x=year, y=rank, group=1)) + 
  geom_line(color = "skyblue", size=1.2) + 
  geom_point(color = "black",fill="skyblue",size=8,shape=21) + # how to outline the points with black?
  geom_text(aes(label=rank), position = position_identity(), size = 3) +
  scale_x_continuous(limits=c(2000,2020),breaks = c(2000,2005,2010,2015,2020)) +
  scale_y_reverse(limits=c(200,-10)) +
  guides(y="none") +
  theme(panel.grid.major.x = element_line(color="grey", size=0.25),
  panel.background = element_blank(),
  plot.margin = unit(c(0.5,1,0.5,1),"cm"),
  axis.line = element_line(),
  axis.ticks.x=element_blank(),
  axis.title.x = element_blank(),
  axis.text.x=element_text(color="black"),
  axis.text.y=element_blank(),
  axis.ticks.y=element_blank(),
  axis.title.y = element_blank())

require(gridExtra)
grid.arrange(fed_rank, nad_rank, djo_rank, nrow=3)

  #g <- arrangeGrob(fed_rank, nad_rank, djo_rank, nrow=3)
  #ggsave(file="Big 3 World Ranking.png", g, width=12,height=8)


# 11. Matches Won per Tournament
A_djo_p <- big3_stats2 %>%
  filter(name=="Novak Djokovic" & tournament == "Australian Open") %>%
  select(name,tournament,winner) %>% 
  group_by(name,tournament,winner) %>% 
  summarise(n=n()) %>%
  ggplot(aes(x = winner, y = n)) + 
  geom_col(position = "dodge",width=0.7, fill="skyblue", color="black") +
  labs(title="", subtitle="Djokovic",x="", y="Matches") +
  scale_x_discrete(labels=c("Losses","Wins")) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 130)) +
  geom_text(aes(label=n), position = position_dodge(),vjust = -1, size = 3) +
  theme(plot.subtitle = element_text(hjust = 0.5,size=9),
	  plot.margin = unit(c(1,0,0,0),"cm"),
        axis.line = element_line(),
	  axis.title.y = element_text(vjust=6, size=11),
   	  axis.text.y=element_text(color="black"),
	  axis.ticks.x=element_blank(),
  	  axis.text.x=element_text(color="black"),
        panel.grid.major.y = element_line(color="grey", size=0.25),
        panel.background = element_blank(),
        panel.border = element_blank())

A_fed_p <- big3_stats2 %>%
  filter(name=="Roger Federer" & tournament == "Australian Open") %>%
  select(name,tournament,winner) %>% 
  group_by(name,tournament,winner) %>% 
  summarise(n=n()) %>%
  ggplot(aes(x = winner, y = n)) + 
  geom_col(position = "dodge",width=0.6, fill="skyblue", color="black") +
  labs(title="Australian Open", subtitle="Federer",x="", y="") +
  scale_x_discrete(labels=c("Losses","Wins")) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 130)) +
  geom_text(aes(label=n), position = position_dodge(),vjust = -1, size = 3) +
  theme(plot.title = element_text(vjust=1,hjust = 0.5,size=13.4),
        plot.subtitle = element_text(hjust = 0.5,size=9),
	  plot.margin = unit(c(1,0,0,0),"cm"),
        axis.line.x = element_line(),
	  axis.ticks.x=element_blank(),
  	  axis.text.x=element_text(color="black"),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        panel.grid.major.y = element_line(color="grey", size=0.25),
        panel.background = element_blank(),
        panel.border = element_blank())

A_nad_p <- big3_stats2 %>%
  filter(name=="Rafael Nadal" & tournament == "Australian Open") %>%
  select(name,tournament,winner) %>% 
  group_by(name,tournament,winner) %>% 
  summarise(n=n()) %>%
  ggplot(aes(x = winner, y = n)) + 
  geom_col(position = "dodge",width=0.6, fill="skyblue", color="black") +
  labs(title="", subtitle="Nadal", x="", y="") +
  scale_x_discrete(labels=c("Losses","Wins")) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 130)) +
  geom_text(aes(label=n), position = position_dodge(),vjust = -1, size = 3) +
  theme(plot.subtitle = element_text(hjust = 0.5,size=9),
	  plot.margin = unit(c(1,0,0,0),"cm"),
        axis.line.x = element_line(),
	  axis.ticks.x=element_blank(),
  	  axis.text.x=element_text(color="black"),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        panel.grid.major.y = element_line(color="grey", size=0.25),
        panel.background = element_blank(),
        panel.border = element_blank())

F_djo_p <- big3_stats2 %>%
  filter(name=="Novak Djokovic" & tournament == "French Open") %>%
  select(name,tournament,winner) %>% 
  group_by(name,tournament,winner) %>% 
  summarise(n=n()) %>%
  ggplot(aes(x = winner, y = n)) + 
  geom_col(position = "dodge",width=0.6, fill="darkorange", color="black") +
  labs(title="", subtitle="Djokovic",x="", y="") +
  scale_x_discrete(labels=c("Losses","Wins")) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 130)) +
  geom_text(aes(label=n), position = position_dodge(),vjust = -1, size = 3) +
  theme(plot.subtitle = element_text(hjust = 0.5,size=9),
	  plot.margin = unit(c(1,0,0,0),"cm"),
        axis.line.x = element_line(),
	  axis.ticks.x=element_blank(),
  	  axis.text.x=element_text(color="black"),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        panel.grid.major.y = element_line(color="grey", size=0.25),
        panel.background = element_blank(),
        panel.border = element_blank())

F_fed_p <- big3_stats2 %>%
  filter(name=="Roger Federer" & tournament == "French Open") %>%
  select(name,tournament,winner) %>% 
  group_by(name,tournament,winner) %>% 
  summarise(n=n()) %>%
  ggplot(aes(x = winner, y = n)) + 
  geom_col(position = "dodge",width=0.6, fill="darkorange", color="black") +
  labs(title="French Open", subtitle="Federer",x="", y="") +
  scale_x_discrete(labels=c("Losses","Wins")) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 130)) +
  geom_text(aes(label=n), position = position_dodge(),vjust = -1, size = 3) +
  theme(plot.title = element_text(vjust=1,hjust = 0.5,size=13.4),
        plot.subtitle = element_text(hjust = 0.5,size=9),
	  plot.margin = unit(c(1,0,0,0),"cm"),
        axis.line.x = element_line(),
	  axis.ticks.x=element_blank(),
  	  axis.text.x=element_text(color="black"),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        panel.grid.major.y = element_line(color="grey", size=0.25),
        panel.background = element_blank(),
        panel.border = element_blank())

F_nad_p <- big3_stats2 %>%
  filter(name=="Rafael Nadal" & tournament == "French Open") %>%
  select(name,tournament,winner) %>% 
  group_by(name,tournament,winner) %>% 
  summarise(n=n()) %>%
  ggplot(aes(x = winner, y = n)) + 
  geom_col(position = "dodge",width=0.6, fill="darkorange", color="black") +
  labs(title="", subtitle="Nadal",x="", y="") +
  scale_x_discrete(labels=c("Losses","Wins")) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 130)) +
  geom_text(aes(label=n), position = position_dodge(),vjust = -1, size = 3) +
  theme(plot.subtitle = element_text(hjust = 0.5,size=9),
	  plot.margin = unit(c(1,0,0,0),"cm"),
        axis.line.x = element_line(),
	  axis.ticks.x=element_blank(),
  	  axis.text.x=element_text(color="black"),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        panel.grid.major.y = element_line(color="grey", size=0.25),
        panel.background = element_blank(),
        panel.border = element_blank())

W_djo_p <- big3_stats2 %>%
  filter(name=="Novak Djokovic" & tournament == "Wimbledon") %>%
  select(name,tournament,winner) %>% 
  group_by(name,tournament,winner) %>% 
  summarise(n=n()) %>%
  ggplot(aes(x = winner, y = n)) + 
  geom_col(position = "dodge",width=0.7, fill="palegreen3", color="black") +
  labs(title="", subtitle="Djokovic",x="", y="Matches") +
  scale_x_discrete(labels=c("Losses","Wins")) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 130)) +
  geom_text(aes(label=n), position = position_dodge(),vjust = -1, size = 3) +
  theme(plot.subtitle = element_text(hjust = 0.5,size=9),
	  plot.margin = unit(c(0,0,1,0),"cm"),
        axis.line = element_line(),
	  axis.ticks.x=element_blank(),
  	  axis.text.x=element_text(color="black"),
   	  axis.text.y=element_text(color="black"),
	  axis.title.y = element_text(vjust=6, size=11),
        panel.grid.major.y = element_line(color="grey", size=0.25),
        panel.background = element_blank(),
        panel.border = element_blank())

W_fed_p <- big3_stats2 %>%
  filter(name=="Roger Federer" & tournament == "Wimbledon") %>%
  select(name,tournament,winner) %>% 
  group_by(name,tournament,winner) %>% 
  summarise(n=n()) %>%
  ggplot(aes(x = winner, y = n)) + 
  geom_col(position = "dodge",width=0.6, fill="palegreen3", color="black") +
  labs(title="Wimbledon", subtitle="Federer",x="", y="") +
  scale_x_discrete(labels=c("Losses","Wins")) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 130)) +
  geom_text(aes(label=n), position = position_dodge(),vjust = -1, size = 3) +
  theme(plot.title = element_text(vjust=1,hjust = 0.5,size=13.4),
        plot.subtitle = element_text(hjust = 0.5,size=9),
	  plot.margin = unit(c(0,0,1,0),"cm"),
        axis.line.x = element_line(),
	  axis.ticks.x=element_blank(),
  	  axis.text.x=element_text(color="black"),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        panel.grid.major.y = element_line(color="grey", size=0.25),
        panel.background = element_blank(),
        panel.border = element_blank())

W_nad_p <- big3_stats2 %>%
  filter(name=="Rafael Nadal" & tournament == "Wimbledon") %>%
  select(name,tournament,winner) %>% 
  group_by(name,tournament,winner) %>% 
  summarise(n=n()) %>%
  ggplot(aes(x = winner, y = n)) + 
  geom_col(position = "dodge",width=0.6, fill="palegreen3", color="black") +
  labs(title="", subtitle="Nadal", x="", y="") +
  scale_x_discrete(labels=c("Losses","Wins")) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 130)) +
  geom_text(aes(label=n), position = position_dodge(),vjust = -1, size = 3) +
  theme(plot.subtitle = element_text(vjust=1,hjust = 0.5,size=9),
	  plot.margin = unit(c(0,0,1,0),"cm"),
        axis.line.x = element_line(),
	  axis.ticks.x=element_blank(),
  	  axis.text.x=element_text(color="black"),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        panel.grid.major.y = element_line(color="grey", size=0.25),
        panel.background = element_blank(),
        panel.border = element_blank())

U_djo_p <- big3_stats2 %>%
  filter(name=="Novak Djokovic" & tournament == "US Open") %>%
  select(name,tournament,winner) %>% 
  group_by(name,tournament,winner) %>% 
  summarise(n=n()) %>%
  ggplot(aes(x = winner, y = n)) + 
  geom_col(position = "dodge",width=0.6, fill="dodgerblue", color="black") +
  labs(title="", subtitle="Djokovic",x="", y="") +
  scale_x_discrete(labels=c("Losses","Wins")) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 130)) +
  geom_text(aes(label=n), position = position_dodge(),vjust = -1, size = 3) +
  theme(plot.subtitle = element_text(hjust = 0.5,size=9),
	  plot.margin = unit(c(0,0,1,0),"cm"),
        axis.line.x = element_line(),
	  axis.ticks.x=element_blank(),
  	  axis.text.x=element_text(color="black"),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        panel.grid.major.y = element_line(color="grey", size=0.25),
        panel.background = element_blank(),
        panel.border = element_blank())

U_fed_p <- big3_stats2 %>%
  filter(name=="Roger Federer" & tournament == "US Open") %>%
  select(name,tournament,winner) %>% 
  group_by(name,tournament,winner) %>% 
  summarise(n=n()) %>%
  ggplot(aes(x = winner, y = n)) + 
  geom_col(position = "dodge",width=0.6, fill="dodgerblue", color="black") +
  labs(title="US Open", subtitle="Federer",x="", y="") +
  scale_x_discrete(labels=c("Losses","Wins")) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 130)) +
  geom_text(aes(label=n), position = position_dodge(),vjust = -1, size = 3) +
  theme(plot.title = element_text(vjust=1,hjust = 0.5,size=13.4),
        plot.subtitle = element_text(hjust = 0.5,size=9),
	  plot.margin = unit(c(0,0,1,0),"cm"),
        axis.line.x = element_line(),
	  axis.ticks.x=element_blank(),
  	  axis.text.x=element_text(color="black"),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        panel.grid.major.y = element_line(color="grey", size=0.25),
        panel.background = element_blank(),
        panel.border = element_blank())

U_nad_p <- big3_stats2 %>%
  filter(name=="Rafael Nadal" & tournament == "US Open") %>%
  select(name,tournament,winner) %>% 
  group_by(name,tournament,winner) %>% 
  summarise(n=n()) %>%
  ggplot(aes(x = winner, y = n)) + 
  geom_col(position = "dodge",width=0.6, fill="dodgerblue", color="black") +
  labs(title="", subtitle="Nadal",x="", y="") +
  scale_x_discrete(labels=c("Losses","Wins")) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 130)) +
  geom_text(aes(label=n), position = position_dodge(),vjust = -1, size = 3) +
  theme(plot.subtitle = element_text(hjust = 0.5,size=9),
	  plot.margin = unit(c(0,0,1,0),"cm"),
        axis.line.x = element_line(),
	  axis.ticks.x=element_blank(),
  	  axis.text.x=element_text(color="black"),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        panel.grid.major.y = element_line(color="grey", size=0.25),
        panel.background = element_blank(),
        panel.border = element_blank())

grid.arrange(A_djo_p, A_fed_p, A_nad_p, F_djo_p, F_fed_p, F_nad_p, W_djo_p, W_fed_p, W_nad_p, U_djo_p, U_fed_p, U_nad_p, ncol=6, nrow=2)

  #g <- arrangeGrob(A_djo_p, A_fed_p, A_nad_p, F_djo_p, F_fed_p, F_nad_p, W_djo_p, W_fed_p, W_nad_p, U_djo_p, U_fed_p, U_nad_p, ncol=6, nrow=2)
  #ggsave(file="Grandslam Win-Loss.png", g,height=8,width=12)


# 12. Grandslams (part 1)
fed_slams <- big3_stats2 %>% 
  select(name,winner,round,year,tournament) %>% 
  filter(winner == TRUE, round == 'The Final', name == "Roger Federer") %>% 
  summarise(name=name,year=year,tournament=tournament) %>%
  arrange(year) %>% 
  mutate(count=1, slams = cumsum(count)) %>% 
  select(-count, -tournament) %>% 
  arrange(desc(slams)) %>% 
  group_by(year) %>%
  filter(slams== max(slams)) %>% 
  as.data.frame() %>% 
  add_row(name="Roger Federer",year=2000,slams=0) %>% 
  add_row(name="Roger Federer",year=2001,slams=0) %>% 
  add_row(name="Roger Federer",year=2002,slams=0) %>% 
  add_row(name="Roger Federer",year=2011,slams=16) %>% 
  add_row(name="Roger Federer",year=2013,slams=17) %>% 
  add_row(name="Roger Federer",year=2014,slams=17) %>% 
  add_row(name="Roger Federer",year=2015,slams=17) %>% 
  add_row(name="Roger Federer",year=2016,slams=17) %>% 
  add_row(name="Roger Federer",year=2019,slams=20) %>% 
  add_row(name="Roger Federer",year=2020,slams=20) %>% 
  add_row(name="Roger Federer",year=2021,slams=20)

djo_slams <- big3_stats2 %>% 
  select(name,winner,round,year,tournament) %>% 
  filter(winner == TRUE, round == 'The Final', name == "Novak Djokovic") %>% 
  summarise(name=name,year=year,tournament=tournament) %>%
  arrange(year) %>% 
  mutate(count=1, slams = cumsum(count)) %>% 
  select(-count, -tournament) %>% 
  arrange(desc(slams)) %>% 
  group_by(year) %>%
  filter(slams== max(slams)) %>% 
  as.data.frame() %>% 
  add_row(name="Novak Djokovic",year=2000,slams=0) %>% 
  add_row(name="Novak Djokovic",year=2001,slams=0) %>%
  add_row(name="Novak Djokovic",year=2002,slams=0) %>%
  add_row(name="Novak Djokovic",year=2003,slams=0) %>%
  add_row(name="Novak Djokovic",year=2004,slams=0) %>%
  add_row(name="Novak Djokovic",year=2005,slams=0) %>%
  add_row(name="Novak Djokovic",year=2006,slams=0) %>%
  add_row(name="Novak Djokovic",year=2007,slams=0) %>%
  add_row(name="Novak Djokovic",year=2009,slams=1) %>%
  add_row(name="Novak Djokovic",year=2010,slams=1) %>%
  add_row(name="Novak Djokovic",year=2017,slams=12) %>% 
  add_row(name="Novak Djokovic",year=2020,slams=17) %>% 
  add_row(name="Novak Djokovic",year=2021,slams=20)

nad_slams <- big3_stats2 %>% 
  select(name,winner,round,year,tournament) %>% 
  filter(winner == TRUE, round == 'The Final', name == "Rafael Nadal") %>% 
  summarise(name=name,year=year,tournament=tournament) %>%
  arrange(year) %>% 
  mutate(count=1, slams = cumsum(count)) %>% 
  select(-count, -tournament) %>% 
  arrange(desc(slams)) %>% 
  group_by(year) %>%
  filter(slams== max(slams)) %>% 
  as.data.frame() %>% 
  add_row(name="Rafael Nadal",year=2000,slams=0) %>% 
  add_row(name="Rafael Nadal",year=2001,slams=0) %>% 
  add_row(name="Rafael Nadal",year=2002,slams=0) %>% 
  add_row(name="Rafael Nadal",year=2003,slams=0) %>% 
  add_row(name="Rafael Nadal",year=2004,slams=0) %>% 
  add_row(name="Rafael Nadal",year=2015,slams=14) %>% 
  add_row(name="Rafael Nadal",year=2016,slams=14) %>% 
  add_row(name="Rafael Nadal",year=2020,slams=20) %>% 
  add_row(name="Rafael Nadal",year=2021,slams=20)

slam_count_p1 <- rbind(fed_slams,djo_slams,nad_slams) %>%
  arrange(name,year) %>% 
  ggplot(aes(x = year, y = slams, color=name)) +
  geom_line(size=1.2) +
  geom_point(size=2) +
  labs(title="The Big 3's Grandslam Wins",subtitle="(2000-2021)") +
  scale_x_discrete(limits=c(2000,2005,2010,2015,2020)) +
  scale_y_continuous(limits = c(0, 23.81)) +
  scale_color_manual(values=c("dodgerblue", "darkorange","green3")) +
  theme(axis.ticks.x=element_blank(),
  axis.title.x=element_blank(),
  axis.text.x=element_text(color="black"),
  axis.text.y=element_text(color="black"),
  axis.ticks.y =element_blank(),
  axis.title.y =element_blank(),
  legend.title = element_blank(),
  legend.key.size = unit(0.5, 'cm'),
  plot.title = element_text(vjust=5,hjust = 0.5,size=15),
  plot.subtitle = element_text(vjust=6,hjust = 0.5,size=10),
  plot.margin = unit(c(1,1,0,1),"cm"),
  panel.grid.major.x = element_line(color="grey", size=0.25),
  panel.grid.major.y = element_line(color="grey", size=0.25),
  panel.background = element_blank())


# 12. Grandslams (part 2)
slam_count_p2 <- big3_stats2 %>% 
  select(name, tournament, winner, year, round) %>% 
  filter(round=="The Final",winner=="TRUE") %>% 
  select(-round,-winner) %>% 
  as.data.frame() %>% 
  add_row(name="Novak Djokovic",tournament="Australian Open",year=2020) %>%
  add_row(name="Rafael Nadal",tournament="French Open",year=2020) %>% 
  add_row(name="Novak Djokovic",tournament="Australian Open",year=2021) %>% 
  add_row(name="Novak Djokovic",tournament="French Open",year=2021) %>%
  add_row(name="Novak Djokovic",tournament="Wimbledon",year=2021) %>%
  ggplot(aes(x=year, y=tournament)) + 
  geom_tile(aes(fill = name), colour = "white", width=0.95, height=0.95) +
  guides(fill=guide_legend(title="Won By")) +
  scale_fill_manual(values=c("skyblue", "orange","palegreen3")) +
  labs(y="") +
  theme(plot.margin = unit(c(0,0.3,0,1.2),"cm"),
  panel.background = element_blank(),
  panel.border = element_blank(),
  legend.key.size = unit(0.5, 'cm'),
  legend.title=element_text(size=10),
  legend.box.margin=margin(0,20,0,-25),
  axis.ticks.x=element_blank(),
  axis.title.x=element_blank(),
  axis.text.x=element_text(color="black"),
  axis.ticks.y=element_blank(),
  axis.text.y=element_text(color="black"),
  aspect.ratio=0.20)


# 12. Grandslams (combined)
grid.arrange(slam_count_p1,slam_count_p2, nrow=2)

  #g <- arrangeGrob(slam_count_p1,slam_count_p2, nrow=2)
  #ggsave(file="Big 3 Grandslams.png", g, width=12,height=6)






