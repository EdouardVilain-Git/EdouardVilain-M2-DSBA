create table donor_history
as
(with year_acts as
(select contact_id, YEAR(act_date) as act_year, MIN(act_date) as min_date, MAX(act_date) as max_date,
		SUM(amount) as total_amount, COUNT(amount) as nb_donations,
        COUNT(campaign_id) as responses
from acts
group by contact_id, YEAR(act_date)
),

actions_history as
(
select actions1.contact_id, YEAR(actions1.action_date) as action_year,
		COUNT(actions1.contact_id) as nb_sollicitations
from 
actions actions1
left join
actions actions2
on actions1.contact_id=actions2.contact_id and YEAR(actions1.action_date) >= YEAR(actions2.action_date)
group by actions1.contact_id, YEAR(actions1.action_date)
)

select year_acts1.contact_id, year_acts1.act_year, 
		AVG(year_acts1.total_amount) as yearly_amount,
        AVG(year_acts1.nb_donations) as yearly_donations,
        AVG(year_acts1.responses) as yearly_responses,
		SUM(year_acts2.total_amount) as total_amount,
        SUM(year_acts2.nb_donations) / IF((DATEDIFF(MAX(year_acts2.max_date), MIN(year_acts2.min_date)) / 365) < 1.0, 1, (DATEDIFF(MAX(year_acts2.max_date), MIN(year_acts2.min_date)) / 365)) as avg_total_count,
        COALESCE(SUM(year_acts2.responses) / nb_sollicitations,0.5) as responsiveness,
        SUM(year_acts2.nb_donations) as frequency,
        DATEDIFF(MAX(year_acts2.max_date),MIN(year_acts2.min_date)) / 365 as length,
        SUM(year_acts2.total_amount) / SUM(year_acts2.nb_donations) as avg_amount,
        contacts.prefix_id, LEFT(contacts.zip_code,2) as zip_code,
        IF(contacts.prefix_id="MR",1,0) as is_mr,
        IF(contacts.prefix_id="MME",1,0) as is_mme,
		IF(contacts.prefix_id="MLLE",1,0) as is_mlle,
        IF(LEFT(contacts.zip_code,2)="75",1,0) as is_paris,
        COALESCE(AVG(year_acts3.total_amount),0) as future_yearly_amount,
        COALESCE(AVG(year_acts3.nb_donations),0) as future_yearly_donations
from
year_acts year_acts1
left join
year_acts year_acts2
on year_acts1.contact_id=year_acts2.contact_id and year_acts1.act_year >= year_acts2.act_year
left join
actions_history
on year_acts1.contact_id=actions_history.contact_id and year_acts1.act_year=actions_history.action_year
left join contacts
on year_acts1.contact_id=contacts.id
left join year_acts year_acts3
on year_acts1.contact_id = year_acts3.contact_id and year_acts1.act_year=year_acts3.act_year-1
group by year_acts1.contact_id, year_acts1.act_year);
