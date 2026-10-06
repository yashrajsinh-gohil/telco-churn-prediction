# Concept Note

## Title
**Telco Customer Churn Prediction Using Machine Learning**

---

## Intern Details

| Field | Value |
|---|---|
| Project Title | Telco Customer Churn Prediction |
| Domain | Machine Learning / Predictive Analytics |
| Tool Used | IBM BOB, VS Code, Python, scikit-learn |
| Dataset | IBM Telco Customer Churn (public) |
| Duration | As per internship schedule |

---

## 1. Problem Statement

Customer churn — the loss of subscribers to competitors or voluntary cancellation — is one of the most
costly challenges in the telecommunications industry. Research consistently shows that acquiring a new
customer costs **5–7× more** than retaining an existing one [1]. For a company like IBM Telco with
7,043 active customers, even a modest 1% reduction in the 26.5% churn rate directly translates to
measurable revenue recovery.

The core problem is **reactive retention**: customer-service teams only discover a customer has churned
*after* the fact. Without a predictive signal, interventions such as discount offers, contract-upgrade
incentives, or dedicated outreach arrive too late to change the outcome.

> [1] Reichheld, F. F., & Sasser, W. E. (1990). Zero defections: Quality comes to services.
> *Harvard Business Review*, 68(5), 105–111.

---

## 2. Objective

Build an end-to-end machine-learning pipeline that:

1. **Predicts** the probability that a given customer will churn within the billing period, enabling
   the business to rank customers by risk level.
2. **Identifies** the strongest feature drivers of churn (tenure, contract type, monthly charges,
   internet service type) so that retention campaigns can be precisely targeted.
3. **Delivers** actionable, evidence-backed business recommendations that map model findings directly
   to operational retention strategies.
4. **Produces** a reproducible, fully documented notebook and a standalone `report.md` suitable for
   sharing with non-technical stakeholders.

---

## 3. Dataset

| Property | Value |
|---|---|
| Source | IBM Telco Customer Churn (GitHub — IBM/telco-customer-churn-on-icp4d) |
| Records | 7,043 customers |
| Features | 21 (20 input features + 1 target) |
| Target variable | `Churn` — binary: Yes (churned) / No (retained) |
| Baseline churn rate | 26.5% (1,869 churned / 5,174 retained) |
| Missing data | 11 rows with whitespace in `TotalCharges` — imputed with column median (1,397.47) |

**Key feature categories:**

- **Numeric:** `tenure` (months), `MonthlyCharges` ($), `TotalCharges` ($)
- **Service features:** `PhoneService`, `MultipleLines`, `InternetService`, `OnlineSecurity`,
  `OnlineBackup`, `DeviceProtection`, `TechSupport`, `StreamingTV`, `StreamingMovies`
- **Account features:** `Contract`, `PaperlessBilling`, `PaymentMethod`
- **Demographics:** `gender`, `SeniorCitizen`, `Partner`, `Dependents`

---

## 4. Methodology

The project follows a sequential six-stage ML pipeline, implemented in a single annotated
Jupyter Notebook (`telco_churn.ipynb`):

| Stage | Description |
|---|---|
| **1 — Data Loading** | Load IBM Telco CSV via URL (local fallback); coerce `TotalCharges` to numeric |
| **2 — EDA** | Distribution plots, churn-split histograms, categorical churn rates, correlation heatmap |
| **3 — Preprocessing** | Drop `customerID`; median-impute `TotalCharges`; label-encode target; one-hot encode categoricals; stratified 80/20 split; StandardScaler (fit on train only) |
| **4 — Model Training** | Train Logistic Regression, Random Forest (100 trees), Gradient Boosting (100 estimators, lr=0.1) |
| **5 — Evaluation** | Compare Accuracy, Precision, Recall, F1-Score, ROC-AUC on held-out test set; plot ROC curves, confusion matrices, Random Forest feature importances, SHAP attribution |
| **6 — Report** | Programmatically generate `report.md` with live metric values, Markdown table, and business recommendations |

**Key design decisions:**

- `stratify=y` in the train/test split preserves the 26.5% class ratio in both subsets.
- `StandardScaler` is fit exclusively on training data to prevent data leakage.
- ROC-AUC is the primary ranking metric because raw accuracy is misleading for imbalanced classes.
- `random_state=42` is applied globally for full reproducibility.

---

## 5. Tools & Technologies

| Tool / Library | Role |
|---|---|
| **IBM BOB** | AI-assisted development — code generation, debugging, and plan management |
| **VS Code** | Development environment with Jupyter extension |
| **Python 3.11** | Primary programming language |
| **pandas 3.x** | Data loading, cleaning, and transformation |
| **scikit-learn 1.x** | Model training, evaluation metrics, preprocessing |
| **matplotlib / seaborn** | EDA and evaluation visualisations |
| **SHAP** | Model explainability (TreeExplainer for best model) |
| **Jupyter Notebook** | Interactive, narrative-style pipeline execution |

---

## 6. Expected Outcomes

| Outcome | Value |
|---|---|
| Best model ROC-AUC | ~0.84 (Gradient Boosting: **0.8419**) |
| Best model Accuracy | ~80% (Gradient Boosting: **79.77%**) |
| Best model F1-Score | ~0.57 (Gradient Boosting: **0.5727**) |
| Feature drivers identified | `tenure`, `MonthlyCharges`, `TotalCharges`, `Contract_*` |
| Actionable recommendations | 5 evidence-backed retention strategies |
| Deliverable files | `telco_churn.ipynb`, `report.md`, 8× `.png` figures |

The pipeline demonstrates that churn can be predicted with meaningful discrimination
(ROC-AUC = 0.8419 vs 0.50 random baseline), giving the retention team a ranked customer
list from which even targeting the top 20% highest-risk customers would capture the majority
of churners while keeping outreach costs manageable.

---

## 7. References

1. Reichheld, F. F., & Sasser, W. E. (1990). Zero defections: Quality comes to services.
   *Harvard Business Review*, 68(5), 105–111.
2. IBM Telco Customer Churn dataset:
   https://github.com/IBM/telco-customer-churn-on-icp4d
3. scikit-learn documentation: https://scikit-learn.org/stable/
4. Lundberg, S. M., & Lee, S. I. (2017). A unified approach to interpreting model predictions.
   *Advances in Neural Information Processing Systems*, 30.
