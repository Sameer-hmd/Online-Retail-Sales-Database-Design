-- 1. View: Total Sales Per Product
CREATE OR REPLACE VIEW v_total_sales_per_product AS
SELECT 
    p.product_id,
    p.name AS product_name,
    c.category_name,
    SUM(oi.quantity) AS total_units_sold,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM 
    products p
JOIN 
    categories c ON p.category_id = c.category_id
JOIN 
    order_items oi ON p.product_id = oi.product_id
GROUP BY 
    p.product_id, p.name, c.category_name;

-- 2. View: Customer Order Summary
CREATE OR REPLACE VIEW v_customer_order_summary AS
SELECT 
    cu.customer_id,
    cu.full_name,
    cu.email,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spent
FROM 
    customers cu
LEFT JOIN 
    orders o ON cu.customer_id = o.customer_id
GROUP BY 
    cu.customer_id, cu.full_name, cu.email;

-- 3. View: Orders with Payment and Shipping Status
CREATE OR REPLACE VIEW v_order_status_summary AS
SELECT 
    o.order_id,
    o.order_date,
    cu.full_name AS customer_name,
    o.total_amount,
    p.payment_method,
    p.payment_status,
    s.shipping_status
FROM 
    orders o
JOIN 
    customers cu ON o.customer_id = cu.customer_id
LEFT JOIN 
    payments p ON o.order_id = p.order_id
LEFT JOIN 
    shipping s ON o.order_id = s.order_id;

-- 4. View: Top 5 Selling Products
CREATE OR REPLACE VIEW v_top_5_products AS
SELECT * FROM (
    SELECT 
        p.name AS product_name,
        SUM(oi.quantity) AS total_sold,
        RANK() OVER (ORDER BY SUM(oi.quantity) DESC) AS rank
    FROM 
        products p
    JOIN 
        order_items oi ON p.product_id = oi.product_id
    GROUP BY 
        p.name
)
WHERE rank <= 5;

-- 5. View: Monthly Revenue Trend
CREATE OR REPLACE VIEW v_monthly_revenue AS
SELECT 
    TO_CHAR(order_date, 'YYYY-MM') AS month,
    SUM(total_amount) AS total_revenue
FROM 
    orders
GROUP BY 
    TO_CHAR(order_date, 'YYYY-MM')
ORDER BY 
    month;
