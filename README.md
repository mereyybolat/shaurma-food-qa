# QA Testing Project — shaurma-food.kz

## 🧪 Project Overview

This project is a QA testing case for the web application **shaurma-food.kz**.  
It includes functional, UI/UX, API, negative, and cross-browser testing.

---

## 🛠 Tools Used

- Postman (API testing)
- Chrome DevTools (Network analysis)
- Jira (bug tracking)
- Excel (test cases & documentation)
- SQL (data validation)

---

## 📄 Test Documentation

Full report available here:  
📎 *Merey_TechReport (1).pdf*

---

## ✅ What Was Done

- Created a **test plan** and **test cases** for the feedback form
- Reported **5+ bugs** in Jira
- Performed **API testing** using Postman + Postman AI
- Wrote **5 SQL queries** for database validation
- Analyzed **network requests** using Chrome DevTools

---

## 📊 Postman Results

| Test Case | Result |
|-----------|--------|
| Status code 200 OK | ✅ Passed |
| Response time < 2000ms | ✅ Passed (646ms) |
| meals array validation | ❌ Failed |
| isPersonal field validation | ❌ Failed |

### 🧩 Conclusion

The API returns **HTML instead of JSON**, which indicates a backend issue.

---

## 🔗 Links

- Jira Board:  
https://mereyybolat.atlassian.net/jira/software/projects/KAN/list  

- Bug Reports:  
https://docs.google.com/spreadsheets/d/15tMXptXzVeM18deBT7fzOr5YKZVsM2gl/edit?usp=sharing&ouid=114508378313415657842&rtpof=true&sd=true  

- Test Cases:  
https://docs.google.com/spreadsheets/d/189fv0-mppJdf1jvI9x_ooK_JfqqN10nGmTB1FNaOGUE/edit?gid=512485099#gid=512485099  
