# Upwork Job Automation with n8n

This project contains an automated workflow to find relevant Upwork jobs, generate AI proposals, and email them directly to you.

## Features
- **Auto Job Hunter:** Polls Upwork RSS feeds every 15 minutes, filters out bad jobs, and generates an AI proposal for good ones.
- **Manual Webhook:** Send a webhook request with an Upwork URL/Title to generate a proposal on demand.
- **Local n8n Setup:** Uses Docker to run n8n securely on your own machine.

---

## 🚀 1. Setup & Installation

### Pre-requisites
- **Node.js**: Installed on your system.

### Custom Local Setup
Because you requested a custom local setup, we configured n8n to be installed *locally* in this directory, saving all its database, workflows, and configurations into the `n8n_data` folder entirely separate from the rest of your system.

1. Installation is already happening. Once it finishes downloading:
2. Double click the **`start-n8n.bat`** file in this folder to start your custom n8n instance.
3. Open your browser and go to:
   [http://localhost:5678](http://localhost:5678)
4. Set up an Owner account securely to proceed.

---

## ⚙️ 2. Workflow Configuration

Once logged into n8n:

### 1. Import Workflows
- Go to **Workflows > Import from File**
- Import `upwork_auto_hunter.json` from the `workflows` folder
- Import `upwork_manual_proposal.json` from the `workflows` folder

### 2. Setup Credentials
Go to Settings > Credentials and Create:
1. **OpenAI account:** Paste your OpenAI API key.
2. **SMTP account:** Add your Gmail SMTP credentials.
   - Host: `smtp.gmail.com`
   - Port: `465` (SSL)
   - User: `your-email@gmail.com`
   - Pass: `your-google-app-password`

### 3. Link Credentials to Nodes
Open each workflow, and for the following nodes, select the credentials you just created:
- **Generate Proposal** (requires OpenAI)
- **Send Notification / Send Email** (requires SMTP)

---

## 🎯 3. Customizing the Automation

### The RSS Link
1. Go to Upwork and search for your jobs (e.g., `laravel php`). Apply "Payment Verified" filters.
2. Click the **RSS link/icon** to get your personalized feed URL.
3. Open the **Auto Hunter workflow** and paste this link into the `Fetch Upwork RSS` node.

### The Keywords
Open the **Filter and Prepare** node. You can edit the arrays to suit your exact needs:
```javascript
const keywords = ['laravel', 'php', 'api', 'payment', 'bug fix', 'bug fixing'];
const blacklist = ['wordpress', 'shopify', 'wix'];
```

### The System Prompt (AI Personality)
You can customize the AI instructions in the Code nodes. By default, it expects:
> "You are an expert PHP/Laravel developer (8+ yrs). Specialties: Laravel apps, payment integrations..."

---

## ⚡ 4. Manual Execution

You can trigger the manual workflow by sending a POST request to the webhook URL (given inside the Webhook node). 
**Example Body:**
```json
{
  "title": "Laravel expert needed for payment integration",
  "url": "https://www.upwork.com/jobs/..."
}
```
You can easily send this via Postman, or by using n8n's **Chat Trigger** as an alternative.
