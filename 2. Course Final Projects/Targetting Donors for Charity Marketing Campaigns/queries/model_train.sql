create table ass3_model_train
as
(with sollicitations as
(select actions.campaign_id, actions.contact_id, year(actions.action_date) as action_year,
		acts.amount, case when  acts.amount is not null then 1 else 0 end as did_donate
from actions
left join
acts
on actions.contact_id=acts.contact_id and actions.campaign_id=acts.campaign_id)

select sollicitations.*,
		campaign_history.cluster, campaign_history.nb_sollicitations, campaign_history.nb_messages,
		campaign_history.action_month, campaign_history.action_week, campaign_history.nb_actions,
		campaign_history.nb_donors, campaign_history.nb_responses, campaign_history.total_amount as campaign_total_amount,
        campaign_history.nb_do, campaign_history.nb_pa,
        donor_history.yearly_amount, donor_history.yearly_donations, donor_history.yearly_responses,
        donor_history.total_amount as donor_total_amount, donor_history.avg_total_count, 
        donor_history.responsiveness, donor_history.frequency, donor_history.length,
        donor_history.avg_amount, donor_history.prefix_id, donor_history.zip_code,
        donor_history.is_mr, donor_history.is_mme, donor_history.is_mlle, donor_history.is_paris
from 
sollicitations
left join 
campaign_history 
on sollicitations.campaign_id=campaign_history.campaign_id
left join 
donor_history
on sollicitations.action_year=donor_history.act_year+1 and sollicitations.contact_id=donor_history.contact_id);