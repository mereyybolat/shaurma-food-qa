-- ============================================
-- QA Testing Project — shaurma-food.kz
-- SQL Queries for Data Verification
-- Author: Merey Bolat
-- Date: 13.04.2026 — 17.05.2026
-- Database: PostgreSQL
-- ============================================

-- Базовая схема (контекст):
-- users(id PK, full_name, email UNIQUE, birth_date DATE, created_at DATETIME)
-- products(id PK, name, price DECIMAL(10,2), category_id FK, is_active BOOLEAN)
-- categories(id PK, title)
-- orders(id PK, user_id FK, created_at DATETIME, status ENUM('new','paid','shipped','cancelled'))
-- order_items(order_id FK, product_id FK, qty INT, price DECIMAL(10,2))
-- employees(id PK, full_name, salary DECIMAL(10,2), hired_at DATE, department_id FK, manager_id FK NULL)
-- departments(id PK, title)
-- payments(id PK, order_id FK, amount DECIMAL(10,2), paid_at DATETIME, method ENUM('card','cash','wallet'))


-- ============================================
-- 1. Фильтрация по возрасту пользователей
-- Задание: вывести пользователей СТАРШЕ 25 лет
-- Важно: "старше 25" = строго больше, 25 лет ровно не включается
-- NULL birth_date исключаем
-- Сортировка: самые старшие первыми (ASC)
-- ============================================

SELECT id, full_name, birth_date
FROM users
WHERE birth_date IS NOT NULL
  AND age(CURRENT_DATE, birth_date) > INTERVAL '25 years'
  -- Используем age() а не год, чтобы корректно учесть
  -- пользователей у которых день рождения ещё не наступил в этом году
ORDER BY birth_date ASC;


-- ============================================
-- 2. Активные товары дороже 1000
-- Задание: вывести товары с is_active = true и price > 1000
-- Примечание: price > 1000 уже автоматически исключает NULL —
-- отдельная проверка AND price IS NOT NULL не нужна
-- Сортировка: по цене DESC, при равенстве по имени ASC
-- ============================================

SELECT id, name, price
FROM products
WHERE is_active = TRUE
  AND price > 1000
  -- NULL в price автоматически исключается условием price > 1000
ORDER BY price DESC, name ASC;


-- ============================================
-- 3. Средняя зарплата и медиана по отделам
-- Задание: avg_salary и median_salary для каждого отдела
-- Отделы без сотрудников не выводим (INNER JOIN)
-- Округление до 2 знаков
-- percentile_cont(0.5) корректно считает медиану
-- для чётного и нечётного количества сотрудников
-- ============================================

SELECT
    d.title,
    ROUND(AVG(e.salary), 2) AS avg_salary,
    ROUND(
        CAST(
            percentile_cont(0.5) WITHIN GROUP (ORDER BY e.salary)
        AS numeric),
    2) AS median_salary
FROM employees e
JOIN departments d ON e.department_id = d.id
GROUP BY d.title
ORDER BY avg_salary DESC;


-- ============================================
-- 4. Заказы за последние 30 дней
-- Задание: список заказов с данными пользователя
-- Условия: только последние 30 дней, email не NULL и не пустой
-- INNER JOIN — пользователи без заказов не выводятся
-- ============================================

SELECT
    o.id         AS order_id,
    o.created_at AS order_date,
    u.id         AS user_id,
    u.full_name  AS user_name,
    u.email      AS user_email,
    o.status
FROM orders o
INNER JOIN users u ON o.user_id = u.id
WHERE o.created_at >= (now() - INTERVAL '30 days')
  AND u.email IS NOT NULL
  AND u.email <> ''
  -- Исключаем и NULL и пустую строку
ORDER BY o.created_at DESC;


-- ============================================
-- 5. Количество заказов по пользователям
-- Задание: пользователи с orders_count >= 3
-- Учитываем только реальные заказы: paid и shipped
-- WHERE фильтрует статусы ДО агрегации
-- HAVING фильтрует результат ПОСЛЕ агрегации
-- ============================================

SELECT
    u.id        AS user_id,
    u.full_name,
    COUNT(o.id) AS orders_count
FROM users u
JOIN orders o ON u.id = o.user_id
WHERE o.status IN ('paid', 'shipped')
  -- Фильтр по статусу до группировки
GROUP BY u.id, u.full_name
HAVING COUNT(o.id) >= 3
  -- Фильтр по количеству после группировки
ORDER BY orders_count DESC, u.full_name ASC;
