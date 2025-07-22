-- Drop existing tables to reset the schema
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE shipping CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE payments CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE order_items CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE orders CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE products CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE categories CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE customers CASCADE CONSTRAINTS';
EXCEPTION
  WHEN OTHERS THEN NULL;
END;
/

-- Customers
CREATE TABLE customers (
  customer_id     NUMBER PRIMARY KEY,
  full_name       VARCHAR2(100),
  email           VARCHAR2(100) UNIQUE,
  phone           VARCHAR2(15),
  address         CLOB,
  created_at      DATE DEFAULT SYSDATE
);

-- Categories
CREATE TABLE categories (
  category_id     NUMBER PRIMARY KEY,
  category_name   VARCHAR2(50),
  description     CLOB
);

-- Products
CREATE TABLE products (
  product_id      NUMBER PRIMARY KEY,
  name            VARCHAR2(100),
  description     CLOB,
  price           NUMBER(10,2),
  stock_quantity  NUMBER,
  category_id     NUMBER,
  CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Orders
CREATE TABLE orders (
  order_id        NUMBER PRIMARY KEY,
  customer_id     NUMBER,
  order_date      DATE DEFAULT SYSDATE,
  order_status    VARCHAR2(20),
  total_amount    NUMBER(10,2),
  CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Order Items
CREATE TABLE order_items (
  order_item_id   NUMBER PRIMARY KEY,
  order_id        NUMBER,
  product_id      NUMBER,
  quantity        NUMBER,
  unit_price      NUMBER(10,2),
  CONSTRAINT fk_order FOREIGN KEY (order_id) REFERENCES orders(order_id),
  CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Payments
CREATE TABLE payments (
  payment_id      NUMBER PRIMARY KEY,
  order_id        NUMBER,
  payment_date    DATE,
  payment_method  VARCHAR2(50),
  payment_status  VARCHAR2(20),
  CONSTRAINT fk_payment_order FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Shipping
CREATE TABLE shipping (
  shipping_id       NUMBER PRIMARY KEY,
  order_id          NUMBER,
  shipping_address  CLOB,
  shipping_date     DATE,
  delivery_date     DATE,
  shipping_status   VARCHAR2(30),
  CONSTRAINT fk_shipping_order FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
