# Marketing Analytics - Targetting Donors for Charity Marketing Campaigns <a name="donorcampaign"></a>

- **Duration:** 1 month.
- **Group Size:** 5.
- **Project Description:** We are asked to respond to a pitch from a charity's fundraising manager. As the new year is coming up, the charity is planning newt year's 9 marketing campaigns, each with a given fixed cost ($25k) and additional variable cost (85c/sollicitation). We are asked **to design and deploy a sollicitation strategy** towards existing donors for each of the 9 campaigns. The available information is a database containing several tables, of which donation history, marketing campaign information and donor information. 
- **Final Result:** Our strategy is based on a **donation expectation model**. To do so, we to built feature sets for each donor and marketing campaign which, when concatenated together, gave a donor/campaign feature set we trained our model on. The donor feature set was computed solely on aggregated historical donor data. The campaign feature set was computed by clustering campaigns together, and aggregating historical data from campaigns within a same cluster. For each future campaign and donor, we predicted a donation amount and donation expectation which, when multiplied together, outputted a donation expectation. We also computed a predicted number of donations per donor which, given the responsiveness of the donor in the past, led to an ideal number of sollicitations. The decision of sollicitating a donor for a given campaign was then based on the result of the two previous models: 
    1. a donor should only be sollicitated for a campaign if his/her donation expectation is higher than the sollicitation cost.
    2. a donor should not be sollicitated more than his/her ideal number of sollicitations. In the case he could donate in more campaigns, only select the ones with the best donation expectation.
- **Grade:** 18/20 (9/10 on managerial insights, 9/10 on analytics).

---

- **Files Description:**
    - **[Campaign Clustering -](https://github.com/EdouardVilain-Git/EdouardVilain-M2-DSBA/blob/main/2.%20Course%20Final%20Projects/Targetting%20Donors%20for%20Charity%20Marketing%20Campaigns/campaign_clustering.R)** Code for the Marketing Campaigns Clustering.
    - **[Donation Expectation Model -](https://github.com/EdouardVilain-Git/EdouardVilain-M2-DSBA/blob/main/2.%20Course%20Final%20Projects/Targetting%20Donors%20for%20Charity%20Marketing%20Campaigns/models_3_4.R)** Code to model donor donation value, probability, responsiveness and total donations.
    - **[SQL Queries -](https://github.com/EdouardVilain-Git/EdouardVilain-M2-DSBA/tree/main/2.%20Course%20Final%20Projects/Targetting%20Donors%20for%20Charity%20Marketing%20Campaigns/queries)** All SQL queries used for feature engineering. 

<br>

<p align="center">
  <b>Marketing Campaign Clusters</b>
</p>

<p align="center">
    <img src="./images/clusters.jpg" alt="clusters" width="600"/>
</p>
