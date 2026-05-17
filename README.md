# QA Testing Project — shaurma-food.kz

**Тип тестирования:** Функциональное, UI/UX, API, негативное, кросс-браузерное

**Инструменты:** Postman, DevTools, Jira, Excel, SQL

## Что сделано
- Тест-план и тест-кейсы для формы отзыва
- 5+ баг-репортов в формате Jira
- API тестирование через Postman + Postman AI
- 5 SQL запросов для верификации данных
- Анализ Network вкладки DevTools

## Результаты Postman
| Тест | Результат |
|------|-----------|
| Status code 200 OK | ✅ PASSED |
| Response time < 2000ms | ✅ PASSED (646ms) |
| meals array validation | ❌ FAILED |
| isPersonal field | ❌ FAILED |

**Вывод:** сервер возвращает HTML вместо JSON — 
баг локализован на стороне бэкенда

## Jira Board
[https://mereyybolat.atlassian.net/jira/software/projects/KAN/list]

## Баг-репорты
[https://docs.google.com/spreadsheets/d/15tMXptXzVeM18deBT7fzOr5YKZVsM2gl/edit?usp=sharing&ouid=114508378313415657842&rtpof=true&sd=true]

## Тест-кейсы
[https://docs.google.com/spreadsheets/d/189fv0-mppJdf1jvI9x_ooK_JfqqN10nGmTB1FNaOGUE/edit?gid=512485099#gid=512485099]
