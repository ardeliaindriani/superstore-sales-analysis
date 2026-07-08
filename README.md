# Superstore Sales Analysis — SQL & Excel Dashboard

Business performance analysis of a US retail Superstore dataset (9,994 transactions, 2014–2017), combining SQL querying and an interactive Excel dashboard to identify profitability drivers and give actionable pricing/discount recommendations.

## Business Question
Where is the company losing money despite healthy sales, and what discount/pricing policy changes would recover that margin?

## Tools
Python (data validation) · SQL (querying & aggregation) · Excel (PivotTables, dynamic charts, slicers)

## Key Insights & Recommendations

### 1. Discounts above 20% consistently flip transactions from profitable to loss-making
| Discount tier | Margin |
|---|---|
| 0% | +29.5% |
| 1–20% | +11.9% |
| 21–30% | **-10.0%** |
| 31–50% | **-24.8%** |
| 51%+ | **-119.2%** |

Transactions with discounts above 20% accounted for a combined **-$135,376** in losses.

**Recommendation:** Cap standard discount approval at 20%; require manager sign-off above that threshold. Based on historical volume, this could recover a significant share of the $135K in losses.

### 2. The "Tables" sub-category looks unprofitable overall, but the root cause is discounting, not the product
- At 0% discount: Tables generated **+$13,276** profit
- At 31–50% discount: Tables lost **-$27,296**
- Net result: Tables looks like a -$17,725 loss-making category overall — masking that it's actually profitable at reasonable discount levels

**Recommendation:** Apply the same 20% discount cap specifically to Tables rather than deprioritizing the category.

### 3. The Central region has the lowest margin (7.9%) driven by the highest average discount rate (24%)
Compared to the West region (14.9% margin, 11% average discount), Central's heavier discounting is the clearest explanation for its underperformance — not lower demand or pricing.

**Recommendation:** Audit sales rep discount-approval authority in Central and align it with West's more disciplined policy.

## Dashboard
Interactive Excel dashboard (`superstore_dashboard.xlsx`) with slicers for Region, Segment, and Category — all 4 charts (Revenue by Category, Profit by Region, Discount Impact on Profit, Sales Trend) update dynamically based on slicer selection.

## SQL Queries
See `queries/` for the 7 business-driven SQL queries covering revenue trends, product performance, and customer segmentation.

## Data
Superstore retail dataset (Sales, Profit, Discount, Region, Category, Segment, Order Date, 2014–2017).
