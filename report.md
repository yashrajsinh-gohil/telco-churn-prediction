# Telco Customer Churn Prediction — Report

---

## 1. Project Overview

This project builds an end-to-end machine-learning pipeline to predict customer churn for IBM Telco.
By identifying customers most likely to leave, the business can deploy targeted retention campaigns
before churn occurs, reducing revenue loss and improving customer lifetime value.
The dataset contains **7,043 rows × 21 features**; the binary target variable
is `Churn` (Yes = churned, No = retained).

---

## 2. Dataset Summary

| Property | Value |
|---|---|
| Rows | 7,043 |
| Columns (raw) | 21 |
| Target variable | `Churn` (Yes / No) |
| Churned customers | 1,869 (26.5%) |
| Retained customers | 5,174 (73.5%) |
| Missing values (TotalCharges) | 11 rows (imputed with median) |

---

## 3. EDA Findings

- **Class imbalance:** ~26% of customers churned vs ~74% who did not. ROC-AUC and F1-Score are used as primary evaluation measures rather than raw accuracy.
- **Tenure:** Churned customers have markedly lower tenure (concentrated near 0–12 months), while retained customers span the full 72-month range. Short-tenured customers are the highest-risk segment.
- **Monthly charges:** Churned customers pay higher monthly charges on average. High-cost plans (especially Fiber optic) correlate strongly with churn.
- **Contract type:** Month-to-month contracts show the highest churn concentration. Two-year contracts have negligible churn, suggesting long-term commitments are a powerful retention mechanism.
- **Internet service:** Fiber optic customers churn at a far higher rate than DSL or no-internet customers.
- **Correlation:** `tenure` and `TotalCharges` are highly correlated (r ≈ 0.83). Feature scaling was applied to handle differing value ranges across numeric columns.

---

## 4. Preprocessing Summary

1. **Dropped `customerID`** — unique identifier with no predictive signal.
2. **Imputed `TotalCharges` NaN** — 11 rows with whitespace values coerced to NaN in Stage 1; filled with the column median (1397.47).
3. **Encoded target** — `Churn`: Yes → 1, No → 0.
4. **One-hot encoded all categorical columns** using `pd.get_dummies(drop_first=True)`, producing 30 final features.
5. **Stratified 80/20 train/test split** — `stratify=y, random_state=42`; both splits preserve the ~27% churn ratio.
6. **StandardScaler fit on training data only** — prevents data leakage; the same scaler parameters are then applied to transform the test set.

---

## 5. Model Performance

| Model | Accuracy | Precision | Recall | F1-Score | ROC-AUC |
|---|---|---|---|---|---|
| Gradient Boosting | 0.7977 | 0.6519 | 0.5107 | 0.5727 | 0.8419 |
| Logistic Regression | 0.8070 | 0.6584 | 0.5668 | 0.6092 | 0.8416 |
| Random Forest | 0.7857 | 0.6216 | 0.4920 | 0.5493 | 0.8246 |

*Metrics computed on the held-out 20% test set (1,409 rows). Sorted by ROC-AUC descending.*

---

## 6. Best Model & Business Recommendations

**Best model: Gradient Boosting**
ROC-AUC = 0.8419 | Accuracy = 0.7977 | F1-Score = 0.5727 | Recall = 0.5107

The Gradient Boosting achieves the highest ROC-AUC on the test set, meaning it best separates
churners from non-churners across all probability thresholds — the most useful property
for a retention scoring system where threshold tuning is applied downstream.

### Actionable Retention Recommendations

1. **Prioritise month-to-month contract customers for upgrade campaigns.**
   Contract type is among the top-ranked features in the Random Forest model (`TotalCharges`, `tenure`, `MonthlyCharges`).
   EDA confirmed month-to-month customers churn at the highest rate. Offering 1–2 month
   free incentives to switch to annual or two-year contracts should directly reduce churn.

2. **Flag new customers (tenure < 12 months) for proactive onboarding outreach.**
   `tenure` is the strongest single churn driver. Customers who have not yet reached
   their 12-month mark represent the highest-risk cohort; a dedicated onboarding
   programme (check-in calls, usage tips, loyalty rewards) can improve early retention.

3. **Investigate pricing dissatisfaction among Fiber optic customers.**
   Fiber optic internet service is associated with both higher `MonthlyCharges` and
   higher churn. A targeted satisfaction survey and/or a loyalty discount for this
   segment could uncover whether pricing, service quality, or competitive alternatives
   are driving departures.

4. **Implement a real-time churn-score API using the Gradient Boosting model.**
   Deploy the trained model as a scoring service so that customer-service agents
   see a churn probability on every inbound call. High-score customers can be
   immediately routed to retention specialists with pre-approved offers.

5. **Bundle value-added services for high-charge, low-tenure customers.**
   The interaction of high `MonthlyCharges` and low `tenure` is a key risk signal.
   Proactively offering free add-ons (e.g., TechSupport, OnlineBackup) can increase
   perceived value and reduce the likelihood of cancellation before the customer
   has experienced the full service.

---

## 7. Figures

- **figures/eda_churn_distribution.png** — Churn class distribution bar chart (~26% Yes / ~74% No).
- **figures/eda_numeric_distributions.png** — Histograms + KDE for tenure, MonthlyCharges, TotalCharges split by Churn.
- **figures/eda_categorical_vs_churn.png** — Countplots for Contract, InternetService, PaymentMethod vs Churn.
- **figures/eda_correlation_heatmap.png** — Pearson correlation heatmap for numeric features.
- **figures/roc_curves.png** — Overlaid ROC curves for all three models with AUC legend.
- **figures/confusion_matrices.png** — Side-by-side confusion matrices for all three models.
- **figures/rf_feature_importance.png** — Random Forest top-15 feature importances (Gini impurity).
- **figures/shap_summary.png** — SHAP bar-plot feature attribution for the best model (if generated).

---

*Report generated programmatically by `telco_churn.ipynb` — Stage 6.*
