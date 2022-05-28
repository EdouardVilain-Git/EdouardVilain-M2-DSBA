create table campaign_history
as
(select cf1.campaign_id, cf1.cluster, cf1.action_year,
		AVG(cf2.nb_sollicitations) as nb_sollicitations,
        AVG(cf2.nb_messages) as nb_messages,
        AVG(cf2.action_month) as action_month,
        AVG(cf2.action_week) as action_week,
        AVG(cf2.nb_actions) as nb_actions,
        AVG(cf2.nb_donors) as nb_donors,
        AVG(cf2.nb_responses) as nb_responses,
        AVG(cf2.total_amount) as total_amount,
        AVG(cf2.nb_do) as nb_do,
        AVG(cf2.nb_pa) as nb_pa
from
campaign_features cf1
left join
campaign_features cf2
on cf1.cluster=cf2.cluster and cf1.action_year > cf2.action_year
group by cf1.campaign_id, cf1.cluster, cf1.action_year);