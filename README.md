# Rijksmuseum API Testing with Robot Framework

![Robot Framework](https://img.shields.io/badge/Robot%20Framework-API%20Testing-green)  
A test automation project using **Robot Framework** to validate the **Rijksmuseum API**. It covers **collections retrieval, object details, pagination, filtering, and negative test cases**.

## 🚀 Features
- ✅ **Retrieve Collections** – Ensure API returns valid collections.
- ✅ **Retrieve Object Details** – Verify individual artwork details.
- ✅ **Pagination Testing** – Check multi-page responses.
- ✅ **Filtering & Sorting** – Validate parameters like `type`, `material`, `artist`, etc.
- ✅ **Negative Testing** – Handle invalid API keys and endpoints.
- ✅ **Allure Reporting** – Generate test reports.

---

## 📂 Project Structure
Rijksmuseum_API/ 
── tests/ # Robot Framework test cases 
    ├── rijksmuseum_tests.robot
── results/ # Test execution reports 
── .gitignore # Ignore unnecessary files
── requirements.txt # Dependencies (Robot Framework, RequestsLibrary)
── README.md # Project documentation 

---

## 🔧 Setup & Installation

1️⃣ Clone the Repository
```bash
git clone https://github.com/lsuser/Rijksmuseum_API.git
cd Rijksmuseum_API
```

2️⃣ Install Dependencies
```bash
pip install -r requirements.txt
```

3️⃣ Run API Tests
Run all tests:
```bash
robot -d results tests/rijksmuseum_tests.robot
```
Run  test with allure listener:
```bash
robot --listener allure_robotframework -d results tests/rijksmuseum_tests.robot
```
Run tests with tags (e.g., smoke tests):
```bash
robot -d results -i smoke tests/
```

📊 Test Reports

Generate an Allure Report after test execution:
``` bash
allure serve results/allure-results
```
This opens a detailed HTML report in your browser.

📌 API Reference

Rijksmuseum API Docs
https://data.rijksmuseum.nl/docs/api/collection

![Test Status](https://github.com/lsuser/Rijksmuseum_API/actions/workflows/robot-tests.yml/badge.svg)

[View Test Report](https://github.com/lsuser/Rijksmuseum_API/index.html)


