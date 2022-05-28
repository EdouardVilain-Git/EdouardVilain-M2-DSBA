create table future_campaigns_clst
(
campaign_id VARCHAR(255) NOT NULL,
clst1 INT,
clst2 INT,
clst3 INT,
clst4 INT,
clst5 INT,
clst6 INT,
clst7 INT,
clst8 INT
);

insert into future_campaigns_clst(campaign_id,clst1,clst2,clst3,clst4,clst5,clst6,clst7,clst8)
values ("March",2,0,0,0,0,0,0,1),
		("April",0,0,0,0,0,0,0,2),
		("May",6,0,0,0,0,0,0,0),
        ("June",2,0,0,0,0,2,0,0),
        ("August",0,1,0,0,0,1,0,0),
        ("October",0,0,2,0,0,0,0,0),
        ("November",0,0,0,8,0,0,0,0),
        ("December(A)",0,0,2,0,0,0,0,0),
        ("December(B)",0,0,2,0,0,0,0,0);