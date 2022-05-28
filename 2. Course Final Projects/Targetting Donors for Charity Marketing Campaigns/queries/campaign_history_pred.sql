create table campaign_history_pred
(select campaign_id,
		SUM(IF(cluster=1,clst1*cluster,IF(cluster=2,clst2*cluster,IF(cluster=3,clst3*cluster,IF(cluster=4,clst4*cluster,IF(cluster=5,clst5*cluster,IF(cluster=6,clst6*cluster,IF(cluster=7,clst7*cluster,clst8*cluster)))))))) / (clst1+clst2+clst3+clst4+clst5+clst6+clst7+clst8) as cluster,
		SUM(IF(cluster=1,clst1*nb_sollicitations,IF(cluster=2,clst2*nb_sollicitations,IF(cluster=3,clst3*nb_sollicitations,IF(cluster=4,clst4*nb_sollicitations,IF(cluster=5,clst5*nb_sollicitations,IF(cluster=6,clst6*nb_sollicitations,IF(cluster=7,clst7*nb_sollicitations,clst8*nb_sollicitations)))))))) / (clst1+clst2+clst3+clst4+clst5+clst6+clst7+clst8) as nb_sollicitations,
		SUM(IF(cluster=1,clst1*nb_messages,IF(cluster=2,clst2*nb_messages,IF(cluster=3,clst3*nb_messages,IF(cluster=4,clst4*nb_messages,IF(cluster=5,clst5*nb_messages,IF(cluster=6,clst6*nb_messages,IF(cluster=7,clst7*nb_messages,clst8*nb_messages)))))))) / (clst1+clst2+clst3+clst4+clst5+clst6+clst7+clst8) as nb_messages,
        SUM(IF(cluster=1,clst1*action_month,IF(cluster=2,clst2*action_month,IF(cluster=3,clst3*action_month,IF(cluster=4,clst4*action_month,IF(cluster=5,clst5*action_month,IF(cluster=6,clst6*action_month,IF(cluster=7,clst7*action_month,clst8*action_month)))))))) / (clst1+clst2+clst3+clst4+clst5+clst6+clst7+clst8) as action_month,
        SUM(IF(cluster=1,clst1*action_week,IF(cluster=2,clst2*action_week,IF(cluster=3,clst3*action_week,IF(cluster=4,clst4*action_week,IF(cluster=5,clst5*action_week,IF(cluster=6,clst6*action_week,IF(cluster=7,clst7*action_week,clst8*action_week)))))))) / (clst1+clst2+clst3+clst4+clst5+clst6+clst7+clst8) as action_week,
        SUM(IF(cluster=1,clst1*nb_actions,IF(cluster=2,clst2*nb_actions,IF(cluster=3,clst3*nb_actions,IF(cluster=4,clst4*nb_actions,IF(cluster=5,clst5*nb_actions,IF(cluster=6,clst6*nb_actions,IF(cluster=7,clst7*nb_actions,clst8*nb_actions)))))))) / (clst1+clst2+clst3+clst4+clst5+clst6+clst7+clst8) as nb_actions,
        SUM(IF(cluster=1,clst1*nb_donors,IF(cluster=2,clst2*nb_donors,IF(cluster=3,clst3*nb_donors,IF(cluster=4,clst4*nb_donors,IF(cluster=5,clst5*nb_donors,IF(cluster=6,clst6*nb_donors,IF(cluster=7,clst7*nb_donors,clst8*nb_donors)))))))) / (clst1+clst2+clst3+clst4+clst5+clst6+clst7+clst8) as nb_donors,
        SUM(IF(cluster=1,clst1*nb_responses,IF(cluster=2,clst2*nb_responses,IF(cluster=3,clst3*nb_responses,IF(cluster=4,clst4*nb_responses,IF(cluster=5,clst5*nb_responses,IF(cluster=6,clst6*nb_responses,IF(cluster=7,clst7*nb_responses,clst8*nb_responses)))))))) / (clst1+clst2+clst3+clst4+clst5+clst6+clst7+clst8) as nb_responses,
        SUM(IF(cluster=1,clst1*total_amount,IF(cluster=2,clst2*total_amount,IF(cluster=3,clst3*total_amount,IF(cluster=4,clst4*total_amount,IF(cluster=5,clst5*total_amount,IF(cluster=6,clst6*total_amount,IF(cluster=7,clst7*total_amount,clst8*total_amount)))))))) / (clst1+clst2+clst3+clst4+clst5+clst6+clst7+clst8) as total_amount,
        SUM(IF(cluster=1,clst1*nb_do,IF(cluster=2,clst2*nb_do,IF(cluster=3,clst3*nb_do,IF(cluster=4,clst4*nb_do,IF(cluster=5,clst5*nb_do,IF(cluster=6,clst6*nb_do,IF(cluster=7,clst7*nb_do,clst8*nb_do)))))))) / (clst1+clst2+clst3+clst4+clst5+clst6+clst7+clst8) as nb_do,
        SUM(IF(cluster=1,clst1*nb_pa,IF(cluster=2,clst2*nb_pa,IF(cluster=3,clst3*nb_pa,IF(cluster=4,clst4*nb_pa,IF(cluster=5,clst5*nb_pa,IF(cluster=6,clst6*nb_pa,IF(cluster=7,clst7*nb_pa,clst8*nb_pa)))))))) / (clst1+clst2+clst3+clst4+clst5+clst6+clst7+clst8) as nb_pa
from 
future_campaigns_clst
cross join
(select cluster,
		AVG(nb_sollicitations) as nb_sollicitations,
        AVG(nb_messages) as nb_messages,
        AVG(action_month) as action_month,
        AVG(action_week) as action_week,
        AVG(nb_actions) as nb_actions,
        AVG(nb_donors) as nb_donors,
        AVG(nb_responses) as nb_responses,
        AVG(total_amount) as total_amount,
        AVG(nb_do) as nb_do,
        AVG(nb_pa) as nb_pa
from campaign_features
group by cluster) campaign_history_clst
group by campaign_id,clst1,clst2,clst3,clst4,clst5,clst6,clst7,clst8);
