@echo off
echo ==============================================
echo Starting Custom Local n8n Server
echo Data is saved locally in: %CD%\n8n_data
echo ==============================================

:: Create a local data directory if it doesn't exist
IF NOT EXIST "n8n_data" mkdir "n8n_data"

:: Set environment to use the local directory instead of the global user profile
set N8N_USER_FOLDER=%CD%\n8n_data
set TIMEZONE=Asia/Karachi
set GENERIC_TIMEZONE=Asia/Karachi

:: Set encryption key to avoid "lost credentials" issue if moved
set N8N_ENCRYPTION_KEY=upwork-custom-local-key

:: Start n8n
node node_modules\n8n\bin\n8n
