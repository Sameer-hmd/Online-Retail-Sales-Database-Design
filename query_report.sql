-- 1. Top 10 Customers by Spending
SELECT 
    cu.full_name,
    cu.email,
    SUM(o.total_amount) AS total_spent
FROM 
    customers cu
JOIN 
    orders o ON cu.customer_id = o.customer_id
GROUP BY 
    cu.full_name, cu.email
ORDER BY 
    total_spent DESC
FETCH FIRST 10 ROWS ONLY;

-- 2. Products with Low Stock (less than 20)
SELECT 
    product_id,
    name,
    stock_quantity
FROM 
    products
WHERE 
    stock_quantity < 20
ORDER BY 
    stock_quantity ASC;

-- 3. Monthly Revenue Summary (Last 12 Months)
SELECT 
    TO_CHAR(order_date, 'YYYY-MM') AS month,
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS total_revenue
FROM 
    orders
WHERE 
    order_date >= ADD_MONTHS(SYSDATE, -12)
GROUP BY 
    TO_CHAR(order_date, 'YYYY-MM')
ORDER BY 
    month;

-- 4. Category-wise Sales Revenue
SELECT 
    c.category_name,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM 
    categories c
JOIN 
    products p ON c.category_id = p.category_id
JOIN 
    order_items oi ON p.product_id = oi.product_id
GROUP BY 
    c.category_name
ORDER BY 
    total_sales DESC;

-- 5. Orders Without Payment or Payment Pending
SELECT 
    o.order_id,
    o.order_date,
    cu.full_name,
    p.payment_status
FROM 
    orders o
JOIN 
    customers cu ON o.customer_id = cu.customer_id
LEFT JOIN 
    payments p ON o.order_id = p.order_id
WHERE 
    p.payment_status IS NULL OR p.payment_status = 'Pending';

-- 6. Top 5 Best-Selling Products by Revenue
SELECT 
    p.name AS product_name,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM 
    products p
JOIN 
    order_items oi ON p.product_id = oi.product_id
GROUP BY 
    p.name
ORDER BY 
    revenue DESC
FETCH FIRST 5 ROWS ONLY;

-- 7. Customer Order History with Product Names
SELECT 
    cu.full_name,
    o.order_id,
    o.order_date,
    p.name AS product_name,
    oi.quantity,
    oi.unit_price
FROM 
    customers cu
JOIN 
    orders o ON cu.customer_id = o.customer_id
JOIN 
    order_items oi ON o.order_id = oi.order_id
JOIN 
    products p ON oi.product_id = p.product_id
ORDER BY 
    cu.full_name, o.order_date DESC;

-- 8. Average Order Value by Payment Method
SELECT 
    p.payment_method,
    COUNT(o.order_id) AS total_orders,
    ROUND(AVG(o.total_amount), 2) AS avg_order_value
FROM 
    payments p
JOIN 
    orders o ON p.order_id = o.order_id
GROUP BY 
    p.payment_method
ORDER BY 
    avg_order_value DESC;
