create table donor_history_pred
as
(select contact_id, 2018 as act_year,
		AVG(yearly_amount) as yearly_amount,
        AVG(yearly_donations) as yearly_donations, 
        AVG(yearly_responses) as yearly_responses,
        AVG(total_amount) as total_amount,
        AVG(avg_total_count) as avg_total_count,
        AVG(responsiveness) as responsiveness,
        AVG(frequency) as frequency,
        AVG(length) as length,
        AVG(avg_amount) as avg_amount,
		prefix_id, zip_code, is_mr, is_mme, is_mlle, is_paris
from donor_history
where act_year = 2017
group by contact_id, act_year, prefix_id, zip_code, is_mr, is_mme, is_mlle, is_paris);