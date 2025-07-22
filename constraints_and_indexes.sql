-- Add NOT NULL constraints
ALTER TABLE customers MODIFY (full_name NOT NULL, email NOT NULL);
ALTER TABLE products MODIFY (name NOT NULL, price NOT NULL);
ALTER TABLE orders MODIFY (order_status NOT NULL, total_amount NOT NULL);
ALTER TABLE payments MODIFY (payment_method NOT NULL, payment_status NOT NULL);

-- Add UNIQUE constraints
ALTER TABLE customers ADD CONSTRAINT uq_customer_email UNIQUE (email);
ALTER TABLE products ADD CONSTRAINT uq_product_name UNIQUE (name);

-- Add CHECK constraints
ALTER TABLE orders ADD CONSTRAINT chk_order_status CHECK (order_status IN ('Placed', 'Shipped', 'Delivered', 'Cancelled'));
ALTER TABLE payments ADD CONSTRAINT chk_payment_status CHECK (payment_status IN ('Paid', 'Pending', 'Failed'));

-- Add foreign keys (if not already in create_tables.sql)
ALTER TABLE products ADD CONSTRAINT fk_products_category FOREIGN KEY (category_id) REFERENCES categories(category_id);
ALTER TABLE orders ADD CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id);
ALTER TABLE order_items ADD CONSTRAINT fk_order_items_order FOREIGN KEY (order_id) REFERENCES orders(order_id);
ALTER TABLE order_items ADD CONSTRAINT fk_order_items_product FOREIGN KEY (product_id) REFERENCES products(product_id);
ALTER TABLE payments ADD CONSTRAINT fk_payments_order FOREIGN KEY (order_id) REFERENCES orders(order_id);
ALTER TABLE shipping ADD CONSTRAINT fk_shipping_order FOREIGN KEY (order_id) REFERENCES orders(order_id);

-- Create Indexes
CREATE INDEX idx_customers_email ON customers(email);
CREATE INDEX idx_orders_date ON orders(order_date);
CREATE INDEX idx_products_category ON products(category_id);
CREATE INDEX idx_order_items_product ON order_items(product_id);
CREATE INDEX idx_payments_status ON payments(payment_status);
CREATE INDEX idx_shipping_status ON shipping(shipping_status);
