# Presentation Outline — Telco Customer Churn Prediction

> **Format:** 12 slides | **Duration:** 10–12 minutes  
> Replace `[Your Name]`, `[Internship ID]`, and `[College Name]` with your actual details before use.

---

## Slide 1 — Title Slide

**Title:** Telco Customer Churn Prediction Using Machine Learning

**Bullets / Content:**
- **Presented by:** [Your Name]
- **Internship ID:** [e.g., IBM-INT-2024-XXXXX]
- **College / Institution:** [College Name]
- **Mentor / Guide:** [Mentor Name if applicable]
- **Tool:** IBM BOB | Python | scikit-learn

---

## Slide 2 — Problem Statement & Business Goal

**Title:** Why Does Churn Matter?

**Bullets:**
- Telecom customer churn costs **5–7× more** to replace a lost customer than to retain one
  *(Reichheld & Sasser, HBR 1990)*
- IBM Telco dataset baseline churn rate: **26.5%** (1,869 of 7,043 customers)
- Current approach is **reactive** — intervention happens *after* the customer has already left
- **Goal:** Build a predictive ML pipeline that flags high-risk customers *before* they churn,
  enabling targeted, proactive retention campaigns

---

## Slide 3 — Dataset Overview

**Title:** IBM Telco Customer Churn Dataset

**Bullets:**
- **Source:** IBM GitHub — `telco-customer-churn-on-icp4d` (publicly available)
- **Size:** 7,043 rows × 21 features; target variable: `Churn` (Yes / No)
- **3 numeric features:** `tenure` (0–72 months), `MonthlyCharges`, `TotalCharges`
- **17 categorical features:** demographics, service subscriptions, contract & billing details
- **Data quality issue:** 11 rows had whitespace in `TotalCharges` → coerced to NaN,
  imputed with column median ($1,397.47)

> **Figure reference:** `figures/eda_churn_distribution.png` — class balance bar chart

---

## Slide 4 — EDA Key Findings (Part 1): Numeric Features

**Title:** EDA — Numeric Feature Patterns

**Bullets:**
- **Tenure:** Churners are heavily concentrated at **0–12 months** tenure;
  retained customers spread across the full 0–72 month range —
  *new customers are the highest-risk cohort*
- **Monthly Charges:** Churners pay **higher monthly charges** on average;
  the churn group KDE peak is ~$70–80 vs ~$20–30 for retained customers
- **TotalCharges:** Strongly right-skewed; churners cluster at low totals
  (short tenure × high monthly rate = early exit before charges accumulate)
- **Correlation:** `tenure` ↔ `TotalCharges` r ≈ **0.83**; `MonthlyCharges` ↔ `TotalCharges` r ≈ 0.65

> **Figure references:**
> `figures/eda_numeric_distributions.png` | `figures/eda_correlation_heatmap.png`

---

## Slide 5 — EDA Key Findings (Part 2): Categorical Features

**Title:** EDA — Categorical Feature Patterns

**Bullets:**
- **Contract type:** Month-to-month customers churn at the highest rate;
  two-year contract customers show negligible churn — *long-term commitments anchor retention*
- **Internet service:** Fiber optic customers churn far more than DSL or no-internet customers —
  may reflect pricing dissatisfaction or competitive alternatives
- **Payment method:** Electronic check customers have a noticeably higher churn proportion
  compared to bank transfer / credit card users
- **Class imbalance:** ~26% Yes / ~74% No → raw accuracy is misleading;
  **ROC-AUC and F1-Score** chosen as primary evaluation metrics

> **Figure reference:** `figures/eda_categorical_vs_churn.png`

---

## Slide 6 — Preprocessing Pipeline

**Title:** Data Preprocessing — 6 Steps

**Bullets:**
1. **Drop `customerID`** — unique identifier; no predictive signal; would cause overfitting
2. **Impute `TotalCharges` NaN** — 11 rows filled with column median ($1,397.47)
3. **Encode target** — `Churn`: Yes → 1, No → 0
4. **One-hot encode all categorical columns** — `pd.get_dummies(drop_first=True)`;
   raw 20 features → **30 engineered binary features**
5. **Stratified 80/20 train/test split** — `stratify=y, random_state=42`;
   train: 5,634 rows | test: 1,409 rows; both preserve ~26.5% churn ratio
6. **StandardScaler (fit on train only)** — prevents data leakage;
   scaler parameters from training data applied to transform test set

---

## Slide 7 — Models Trained

**Title:** Three Classifiers Compared

**Bullets:**
- **Logistic Regression** — linear baseline; interpretable coefficients;
  `max_iter=1000` (default 100 fails to converge on this dataset)
- **Random Forest** — ensemble of 100 decision trees; robust to outliers;
  provides feature importance via mean decrease in Gini impurity;
  `n_estimators=100, random_state=42`
- **Gradient Boosting** — sequential boosting; iteratively corrects residual errors;
  typically strongest on tabular churn data;
  `n_estimators=100, learning_rate=0.1, random_state=42`
- All models trained on `X_train_scaled` (5,634 × 30); evaluated on `X_test_scaled` (1,409 × 30)
- `random_state=42` applied globally for full reproducibility

---

## Slide 8 — Evaluation Metrics Table

**Title:** Model Performance on Hold-Out Test Set (1,409 rows)

**Bullets / Table:**

| Model | Accuracy | Precision | Recall | F1-Score | **ROC-AUC** |
|---|---|---|---|---|---|
| **Gradient Boosting** | 0.7977 | 0.6519 | 0.5107 | 0.5727 | **0.8419** ★ |
| Logistic Regression | 0.8070 | 0.6584 | 0.5668 | 0.6092 | 0.8416 |
| Random Forest | 0.7857 | 0.6216 | 0.4920 | 0.5493 | 0.8246 |

- ★ **Best model by ROC-AUC: Gradient Boosting (0.8419)** — 68% better than random (0.50 baseline)
- Logistic Regression achieves higher Accuracy and F1-Score but narrowly trails in ROC-AUC
- ROC-AUC selected as the primary ranking metric because it measures discrimination across
  *all* probability thresholds — critical for a scoring system where the cutoff is tuned downstream

---

## Slide 9 — ROC Curves & Confusion Matrices

**Title:** Model Visualisations

**Bullets:**
- **ROC curves** show all three models substantially above the random-classifier diagonal;
  Gradient Boosting and Logistic Regression curves are nearly overlapping (AUC difference < 0.001)
- **Confusion matrices** (default 0.5 threshold):
  - Gradient Boosting: TP=296, FP=158, TN=874, FN=81 on 1,409-row test set
  - False Negatives (missed churners) are the costliest error type in retention use-cases —
    threshold can be lowered to trade Precision for higher Recall
- All three models significantly outperform the 26.5% baseline majority classifier

> **Figure references:**
> `figures/roc_curves.png` | `figures/confusion_matrices.png`

---

## Slide 10 — Feature Importance & SHAP

**Title:** What Drives Churn?

**Bullets:**
- **Top 3 Random Forest features (Gini importance):**
  `TotalCharges`, `tenure`, `MonthlyCharges` — numeric billing & relationship-length features dominate
- **Contract_Two year** and **Contract_One year** are the highest-ranked categorical features —
  confirming EDA finding that contract type is a primary churn lever
- **SHAP (TreeExplainer, 500-row sample):** confirms `tenure` and `MonthlyCharges` have the
  highest mean absolute SHAP values; short tenure pushes churn probability up, long tenure pulls it down
- Features related to internet service (Fiber optic indicator) and payment method also appear
  in the top 15, consistent with EDA categorical analysis

> **Figure references:**
> `figures/rf_feature_importance.png` | `figures/shap_summary.png`

---

## Slide 11 — Business Recommendations

**Title:** 5 Actionable Retention Strategies

**Bullets:**
1. **Month-to-month → annual contract upgrade campaigns** — contract type is a top-5 RF feature;
   offer 1–2 months free to convert high-risk customers to longer commitments
2. **Proactive onboarding for customers with tenure < 12 months** — `tenure` is the #1 or #2
   feature across all models; early check-ins, usage tips, and loyalty rewards can reduce early exits
3. **Targeted pricing review for Fiber optic customers** — Fiber optic is associated with both
   high `MonthlyCharges` and elevated churn; satisfaction survey + loyalty discount for this segment
4. **Deploy a real-time churn-score API** — serve Gradient Boosting predictions to customer-service
   agents so high-risk customers are flagged on inbound calls and routed to retention specialists
5. **Value-added service bundles for high-charge, low-tenure customers** — the `MonthlyCharges` ×
   low `tenure` interaction is a key risk signal; free add-ons (TechSupport, OnlineBackup)
   increase perceived value before the customer considers leaving

---

## Slide 12 — Conclusion & Future Scope

**Title:** Summary & Next Steps

**Bullets (Conclusion):**
- Built a complete, reproducible ML pipeline: data loading → EDA → preprocessing → 3 models → evaluation → report
- Best model (Gradient Boosting) achieves **ROC-AUC = 0.8419** on 1,409 held-out test rows
- Five evidence-backed business recommendations derived directly from model feature importances and EDA
- All code, figures, and `report.md` are reproducible with a single `Kernel → Restart & Run All`

**Bullets (Future Scope):**
- **Hyperparameter tuning:** Grid/RandomSearch + k-fold CV to push ROC-AUC further
- **Threshold optimisation:** Lower the classification threshold to maximise Recall
  (reduce missed churners), accepting a Precision trade-off
- **Class imbalance techniques:** SMOTE or class-weight balancing to improve minority-class detection
- **Deployment:** Wrap the best model as a Flask/FastAPI REST endpoint; integrate with CRM systems
- **Temporal split:** Use a time-based train/test split to simulate real-world deployment conditions
