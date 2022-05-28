create table ass3_model_pred
as
(select campaign.campaign_id, donor.contact_id, donor.act_year+1 as action_year,
		campaign.nb_sollicitations, campaign.nb_messages, campaign.action_month,
		campaign.action_week, campaign.nb_actions, campaign.nb_donors, campaign.nb_responses,
        campaign.total_amount as campaign_total_amount, campaign.nb_do, campaign.nb_pa,
        donor.yearly_amount, donor.yearly_donations, donor.yearly_responses, 
        donor.total_amount as donor_total_amount, donor.avg_total_count,
        donor.responsiveness, donor.frequency, donor.length, donor.avg_amount,
        donor.prefix_id, donor.zip_code, donor.is_mr, donor.is_mme, donor.is_mlle, donor.is_paris
from 
donor_history_pred donor
cross join
campaign_history_pred campaign);
