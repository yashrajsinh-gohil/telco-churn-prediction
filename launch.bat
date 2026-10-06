@echo off
echo Starting Jupyter Lab for Telco Churn Prediction...
echo.
echo Your browser will open automatically.
echo To stop the server, press Ctrl+C in this window.
echo.
.venv\Scripts\jupyter.exe lab telco_churn.ipynb
pause
