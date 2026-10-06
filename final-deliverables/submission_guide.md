# Submission Guide — Final Deliverables 2
## IBM Internship | Telco Customer Churn Prediction

> This document maps every field in the **Final Deliverables 2** submission form to the exact
> file or content to upload, and where to find it on disk.
> Read through once end-to-end before you begin uploading to avoid missing any attachment.

---

## Pre-Submission Checklist

Before opening the submission form, confirm every file below exists and is non-empty:

| ✅ | File | Location | Size Check |
|---|---|---|---|
| ☐ | `telco_churn.ipynb` | `telco-churn-prediction/telco_churn.ipynb` | > 500 KB (fully executed with outputs) |
| ☐ | `report.md` | `telco-churn-prediction/report.md` | > 5 KB |
| ☐ | `requirements.txt` | `telco-churn-prediction/requirements.txt` | > 0 KB |
| ☐ | `README.md` | `telco-churn-prediction/README.md` | > 3 KB |
| ☐ | `figures/` (8 PNGs) | `telco-churn-prediction/figures/` | 8 files present |
| ☐ | `concept_note.md` | `final-deliverables/concept_note.md` | > 4 KB |
| ☐ | `presentation_outline.md` | `final-deliverables/presentation_outline.md` | > 5 KB |
| ☐ | Screenshots PDF | Assembled per `screenshots_checklist.md` | 30 items |
| ☐ | Notebook HTML export | See Step 1 below | > 1 MB |

---

## Step 1 — Export the Notebook to HTML (Before Uploading)

Many submission forms require a static HTML or PDF export of the notebook so reviewers
can read it without installing Jupyter. Run this once from inside the project folder:

```powershell
# From inside telco-churn-prediction/
.venv\Scripts\jupyter.exe nbconvert --to html telco_churn.ipynb
```

This produces `telco_churn.html` in the same folder — a single self-contained file with
all code, outputs, and inline figures baked in. Upload this alongside the `.ipynb` file.

---

## Form Field Mapping

### Section 1 — Intern Details

| Form Field | What to Enter |
|---|---|
| Full Name | Your legal name as registered with the internship |
| Internship ID / Registration Number | Your IBM internship ID (e.g., IBM-INT-2024-XXXXX) |
| College / Institution | Your college name |
| Email | Your registered email address |
| Phone | Your contact number |
| Internship Duration | Start date – End date |

---

### Section 2 — Project Details

| Form Field | What to Enter |
|---|---|
| Project Title | `Telco Customer Churn Prediction Using Machine Learning` |
| Domain / Category | `Machine Learning / Predictive Analytics` |
| Programming Language | `Python 3.11` |
| Primary Tool / Platform | `IBM BOB, VS Code, scikit-learn` |
| Dataset Used | `IBM Telco Customer Churn — 7,043 records, 21 features` |
| Dataset Source / URL | `https://github.com/IBM/telco-customer-churn-on-icp4d` |
| Problem Statement (1–2 sentences) | *"Telecom churn costs 5–7× more to replace than retain. This project builds an ML pipeline to predict churn probability and enable proactive retention campaigns."* |
| Objective (1–2 sentences) | *"Train and compare Logistic Regression, Random Forest, and Gradient Boosting classifiers on the IBM Telco dataset; identify churn drivers; deliver actionable business recommendations."* |
| Methodology / Approach (3–5 sentences) | Copy the Methodology paragraph from `final-deliverables/concept_note.md` → Section 4 |
| Tools & Technologies | `Python, pandas, scikit-learn, matplotlib, seaborn, SHAP, Jupyter Notebook, IBM BOB, VS Code` |
| Outcome / Results | `Best model: Gradient Boosting — ROC-AUC: 0.8419, Accuracy: 79.77%, F1-Score: 0.5727. Five evidence-backed retention recommendations delivered.` |

---

### Section 3 — File Uploads

| Form Field / Upload Slot | File to Upload | Source Path |
|---|---|---|
| **Main Project File / Notebook (.ipynb)** | `telco_churn.ipynb` | `telco-churn-prediction/telco_churn.ipynb` |
| **Notebook Export (HTML or PDF)** | `telco_churn.html` | `telco-churn-prediction/telco_churn.html` *(generated in Step 1)* |
| **Project Report** | `report.md` | `telco-churn-prediction/report.md` |
| **Concept Note** | `concept_note.md` (or convert to PDF) | `final-deliverables/concept_note.md` |
| **Presentation (PPT / PDF)** | Your slide deck built from `presentation_outline.md` | `final-deliverables/presentation_outline.md` → convert to PPTX/PDF |
| **Screenshots / Output Evidence (PDF)** | Screenshots PDF assembled from checklist | Assembled per `final-deliverables/screenshots_checklist.md` |
| **Source Code / Project ZIP** | ZIP of entire `telco-churn-prediction/` folder (excluding `.venv/`) | See Step 2 below |
| **README** | `README.md` | `telco-churn-prediction/README.md` |
| **Requirements / Dependencies** | `requirements.txt` | `telco-churn-prediction/requirements.txt` |
| **Figures / Visualisations ZIP** | ZIP of `figures/` folder (all 8 PNGs) | `telco-churn-prediction/figures/*.png` |

---

## Step 2 — Create the Project ZIP (Excluding .venv)

```powershell
# Run from the workspace root (one level above telco-churn-prediction/)
Compress-Archive -Path telco-churn-prediction\* `
    -DestinationPath telco-churn-prediction-submission.zip `
    -CompressionLevel Optimal

# Manually exclude .venv if your ZIP tool includes it — or use:
# (The .venv folder is ~200 MB; reviewers do not need it)
```

> **Tip:** If using Windows Explorer, select all files *inside* `telco-churn-prediction/` except
> the `.venv` folder, right-click → Send to → Compressed (zipped) folder.

---

### Section 4 — Project Summary / Abstract (Free-Text Field)

Paste the following paragraph (adapt as needed):

> This project builds an end-to-end machine-learning pipeline to predict customer churn for IBM Telco.
> Using the public IBM Telco Customer Churn dataset (7,043 records, 21 features, 26.5% churn baseline),
> three classifiers were trained and evaluated: Logistic Regression, Random Forest, and Gradient Boosting.
> The best model — Gradient Boosting — achieved a ROC-AUC of 0.8419 on a stratified 20% hold-out test set,
> significantly above the 0.50 random baseline. SHAP explainability confirmed that `tenure`,
> `MonthlyCharges`, and contract type are the strongest churn drivers. Five actionable retention
> recommendations are delivered, including proactive onboarding for new customers, month-to-month
> contract upgrade incentives, and a proposed real-time churn-scoring API for customer-service agents.
> The entire pipeline is reproducible with a single notebook run; all outputs (figures, report.md)
> are generated programmatically.

---

### Section 5 — Mentor / Guide Sign-Off (if required)

| Form Field | What to Enter |
|---|---|
| Mentor Name | [Your IBM mentor's name] |
| Mentor Email | [Mentor's email] |
| Mentor Signature / Approval Date | Obtain from your mentor before submitting |

---

## Section 6 — Learning Outcomes / Reflection (Free-Text Field)

Key points to include (expand in your own words):

- Applied the full ML lifecycle: data loading, EDA, preprocessing, training, evaluation, and reporting
- Understood and implemented data-leakage prevention (StandardScaler fit on train split only)
- Learned to choose evaluation metrics appropriate to imbalanced classification (ROC-AUC over accuracy)
- Used IBM BOB as an AI-assisted development tool for code generation and debugging
- Gained practical experience with SHAP for model explainability — translating model outputs into business language
- Produced stakeholder-ready documentation (`report.md`, concept note, presentation) alongside technical code

---

## Quick-Reference: Files by Upload Category

```
UPLOAD CATEGORY             FILE(S)
─────────────────────────────────────────────────────────────────────
Code / Notebook             telco_churn.ipynb
                            telco_churn.html  (exported)

Report                      report.md
                            concept_note.md

Presentation                [Your PPTX/PDF built from presentation_outline.md]

Evidence / Screenshots      [Screenshots PDF — see screenshots_checklist.md]
                            figures/eda_churn_distribution.png
                            figures/eda_numeric_distributions.png
                            figures/eda_categorical_vs_churn.png
                            figures/eda_correlation_heatmap.png
                            figures/roc_curves.png
                            figures/confusion_matrices.png
                            figures/rf_feature_importance.png
                            figures/shap_summary.png

Supporting Files            README.md
                            requirements.txt
                            telco-churn-prediction-submission.zip
```

---

*Last updated: generated by IBM BOB — verify against the actual submission form before uploading.*
