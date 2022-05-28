create table campaign_features
as
(select campaign_cluster_actions.campaign_id, campaign_cluster_actions.cluster, campaign_cluster_actions.action_year,
		nb_sollicitations, nb_messages, action_month, action_week, nb_actions,
		coalesce(nb_donors,0) as nb_donors, coalesce(nb_responses,0) as nb_responses, 
        coalesce(total_amount,0) as total_amount, coalesce(nb_do,0) as nb_do, coalesce(nb_pa,0) as nb_pa
from
(select campaign_id, cluster, YEAR(action_date) as action_year, count(contact_id) as nb_sollicitations, count(distinct message_id) as nb_messages, 
		MIN(MONTH(action_date)) as action_month, MIN(WEEK(action_date)) as action_week, 
		count(distinct action_date) as nb_actions
from actions_clst
group by campaign_id, cluster, YEAR(action_date)
order by campaign_id) campaign_cluster_actions
left join
(select campaign_id, count(distinct contact_id) as nb_donors, count(distinct amount) as nb_responses,
		sum(amount) as total_amount, sum(case when act_type_id='DO' then 1 else 0 end) as nb_do,
        sum(case when act_type_id='PA' then 1 else 0 end) as nb_pa
from acts
group by campaign_id) campaign_cluster_acts
on campaign_cluster_actions.campaign_id = campaign_cluster_acts.campaign_id);